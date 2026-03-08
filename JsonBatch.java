import java.sql.*;
import java.util.*;
import java.util.concurrent.*;
import java.util.concurrent.atomic.*;

/**
 * JsonBatch — JDBC batch-insert stress tester for a JSON column.
 *
 * Usage:
 *   java -cp .:<tt-jdbc-jar> JsonBatch \
 *        -url <jdbc-url> -threads <n> -rows <n> -batchsize <n>
 *
 * Example (TimesTen direct):
 *   java -cp .:/opt/TimesTen/tt221/lib/ttjdbc8.jar JsonBatch \
 *        -url "jdbc:timesten:direct:sampledb" \
 *        -threads 4 -rows 100000 -batchsize 500
 */
public class JsonBatch {

    // ------------------------------------------------------------------ args
    private static String  url;
    private static int     threads;
    private static int     rows;
    private static int     batchSize;

    // ------------------------------------------------------------------ stats
    private static final AtomicLong totalInserted = new AtomicLong(0);
    private static final AtomicLong totalErrors   = new AtomicLong(0);

    // ================================================================== main
    public static void main(String[] args) throws Exception {
        parseArgs(args);

        System.out.printf("URL        : %s%n", url);
        System.out.printf("Threads    : %d%n", threads);
        System.out.printf("Rows       : %d%n", rows);
        System.out.printf("Batch size : %d%n", batchSize);

        // Create the table on a single connection before launching threads
        try (Connection conn = DriverManager.getConnection(url)) {
            createTable(conn);
        }

        // Divide rows across threads — first (remainder) threads get one extra row
        int base      = rows / threads;
        int remainder = rows % threads;

        ExecutorService    executor = Executors.newFixedThreadPool(threads);
        CountDownLatch     latch    = new CountDownLatch(threads);
        List<Future<Long>> futures  = new ArrayList<>();

        long startTime = System.currentTimeMillis();
        int  nextId    = 1;

        for (int t = 0; t < threads; t++) {
            int threadRows  = base + (t < remainder ? 1 : 0);
            int threadStart = nextId;
            nextId += threadRows;

            final int fRows  = threadRows;
            final int fStart = threadStart;
            final int fThread = t + 1;

            futures.add(executor.submit(() -> {
                try {
                    return runThread(fThread, fStart, fRows);
                } finally {
                    latch.countDown();
                }
            }));
        }

        latch.await();
        executor.shutdown();

        // Collect per-thread results
        for (Future<Long> f : futures) {
            try { totalInserted.addAndGet(f.get()); }
            catch (ExecutionException e) { totalErrors.incrementAndGet(); }
        }

        long elapsed  = System.currentTimeMillis() - startTime;
        long inserted = totalInserted.get();
        long errors   = totalErrors.get();
        double secs   = elapsed / 1000.0;

        System.out.println();
        System.out.println("========== Results ==========");
        System.out.printf("  Rows inserted : %,d%n",   inserted);
        System.out.printf("  Errors        : %,d%n",   errors);
        System.out.printf("  Elapsed       : %.3f s%n", secs);
        if (secs > 0)
            System.out.printf("  Throughput    : %,.0f rows/s%n", inserted / secs);
    }

    // ============================================================= createTable
    private static void createTable(Connection conn) throws SQLException {
        System.out.println("\nPreparing table TRADE_DOCUMENTS...");
        try (Statement st = conn.createStatement()) {
            // Drop if exists (TimesTen 18.1+)
            try {
                st.execute("DROP TABLE TRADE_DOCUMENTS");
                System.out.println("  Dropped existing TRADE_DOCUMENTS.");
            } catch (SQLException ex) {
                // Table did not exist — that is fine
            }
            st.execute(
                "CREATE TABLE TRADE_DOCUMENTS (" +
                "  ID  INTEGER     NOT NULL PRIMARY KEY, " +
                "  DOC JSON" +
                ")"
            );
        }
        conn.commit();
        System.out.println("  Table TRADE_DOCUMENTS created.");
    }

    // =============================================================== runThread
    private static long runThread(int threadNum, int startId, int numRows)
            throws SQLException {
        long inserted = 0;
        try (Connection conn = DriverManager.getConnection(url)) {
            conn.setAutoCommit(false);
            try (PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO TRADE_DOCUMENTS (ID, DOC) VALUES (?, ?)")) {

                Random rng        = new Random((long) threadNum * 0xDEADBEEFL);
                int    batchCount = 0;

                for (int i = 0; i < numRows; i++) {
                    int id = startId + i;
                    ps.setInt(1, id);
                    ps.setString(2, generateJson(id, rng));
                    ps.addBatch();
                    batchCount++;

                    if (batchCount >= batchSize) {
                        ps.executeBatch();
                        conn.commit();
                        inserted  += batchCount;
                        batchCount = 0;
                        System.out.printf("  [T%d] committed %,d rows (running total: %,d)%n",
                                threadNum, batchSize, inserted);
                    }
                }

                // Flush the final partial batch
                if (batchCount > 0) {
                    ps.executeBatch();
                    conn.commit();
                    inserted += batchCount;
                }
            }
        }
        System.out.printf("  [T%d] done — %,d rows inserted.%n", threadNum, inserted);
        return inserted;
    }

    // ============================================================= generateJson
    /**
     * Builds a JSON document with the same top-level structure as trading_app.json
     * but with randomised values so every row is distinct.
     */
    private static String generateJson(int id, Random rng) {
        // ---- lookup tables ------------------------------------------------
        String[] currencies   = {"USD", "EUR", "GBP", "CAD", "JPY"};
        String[] themes       = {"dark", "light", "system"};
        String[] chartTypes   = {"candlestick", "line", "bar", "area"};
        String[] periods      = {"1D", "5D", "1M", "3M", "6M", "1Y"};
        String[] acctTypes    = {"cash", "margin", "ira", "roth"};
        String[] exchanges    = {"NYSE", "NASDAQ"};
        String[] assetClasses = {"equity", "etf", "option"};
        String[] symbols      = {"AAPL","MSFT","NVDA","GOOGL","AMZN","TSLA","META","SPY","QQQ","AMD"};
        String[] orderSides   = {"buy", "sell"};
        String[] orderTypes   = {"market", "limit", "stop", "stop_limit"};
        String[] orderStatuses= {"open", "filled", "cancelled", "partial"};
        String[] tifs         = {"DAY", "GTC", "IOC", "FOK"};
        String[] conditions   = {"price_above", "price_below", "pct_change_up", "pct_change_down"};
        String[] auditActions = {"ORDER_PLACED", "ALERT_CREATED", "WATCHLIST_UPDATED", "WITHDRAWAL"};

        // ---- derived scalars -----------------------------------------------
        String currency  = pick(currencies, rng);
        String userId    = String.format("USR-%08d", id);
        String acctId    = String.format("ACC-%04d-%05d", id, rng.nextInt(100000));
        String orderId   = String.format("ORD-20260307-%05d", id);
        String alertId   = String.format("ALT-%05d", id);
        String symbol1   = pick(symbols, rng);
        String symbol2   = pick(symbols, rng);
        String alertSym  = pick(symbols, rng);

        double balance   = 10_000  + rng.nextDouble() * 990_000;
        double avail     = balance * (0.50 + rng.nextDouble() * 0.40);
        double reserved  = balance - avail;
        double deposited = balance * (1.1 + rng.nextDouble() * 0.4);
        double withdrawn = deposited - balance;
        double realized  = (rng.nextDouble() - 0.3) * 20_000;
        double margin    = rng.nextBoolean() ? 0.0 : balance * 0.15;

        double maxLoss   = 5_000 + rng.nextDouble() * 95_000;
        double leverage  = 1.0   + rng.nextDouble() * 4.0;
        double mf1 = 0.0010 + rng.nextDouble() * 0.0010;
        double tf1 = mf1 + 0.0005 + rng.nextDouble() * 0.0005;

        double qty1      = 1   + rng.nextInt(500);
        double entry1    = 10  + rng.nextDouble() * 990;
        double cur1      = entry1 * (0.80 + rng.nextDouble() * 0.40);
        double mktVal1   = qty1 * cur1;
        double cost1     = qty1 * entry1;
        double upnl1     = mktVal1 - cost1;
        double upnlPct1  = upnl1 / cost1 * 100;
        double dayChg1   = (rng.nextDouble() - 0.5) * 8;
        double dayPct1   = dayChg1 / cur1 * 100;

        double invested  = mktVal1;
        double totalVal  = balance + invested;
        double portUpnl  = upnl1;
        double portUpnlPct = portUpnl / invested * 100;
        double dayPnL    = (rng.nextDouble() - 0.5) * 5_000;
        double dayPnLPct = dayPnL / totalVal * 100;

        double equityPct = 40 + rng.nextDouble() * 50;
        double etfPct    = 100 - equityPct;
        double techPct   = 30 + rng.nextDouble() * 50;
        double finPct    = rng.nextDouble() * 20;
        double hlthPct   = rng.nextDouble() * 15;
        double otherPct  = Math.max(0, 100 - techPct - finPct - hlthPct);

        int    oQty      = 1 + rng.nextInt(200);
        double limitPx   = 10 + rng.nextDouble() * 990;
        String oSide     = pick(orderSides, rng);
        String oType     = pick(orderTypes, rng);
        String oStatus   = pick(orderStatuses, rng);
        String tif       = pick(tifs, rng);

        double alertThr  = 50  + rng.nextDouble() * 750;
        double alertCur  = alertThr * (0.88 + rng.nextDouble() * 0.24);

        double spx       = 4_800 + rng.nextDouble() * 1_200;
        double ndx       = 16_500 + rng.nextDouble() * 4_000;
        double dji       = 39_000 + rng.nextDouble() * 4_000;
        double vix       = 10    + rng.nextDouble() * 40;
        double yield10   = 3.0   + rng.nextDouble() * 2.5;
        boolean inverted = rng.nextBoolean();

        String auditAction = pick(auditActions, rng);
        boolean auditOk    = rng.nextBoolean();
        int ip2 = rng.nextInt(256), ip3 = rng.nextInt(256), ip4 = rng.nextInt(256);

        // ---- build JSON string ---------------------------------------------
        StringBuilder sb = new StringBuilder(4096);

        // application
        sb.append("{\"application\":{");
        sb.append("\"name\":\"QuantEdge Trading Platform\",");
        sb.append("\"version\":\"4.2.1\",");
        appendKV(sb, "build",           20260307 + id);         sb.append(",");
        appendKV(sb, "isLive",          rng.nextBoolean());     sb.append(",");
        appendKV(sb, "maintenanceMode", false);                  sb.append(",");
        sb.append("\"debugLevel\":null,");
        sb.append("\"supportedMarkets\":[\"NYSE\",\"NASDAQ\",\"LSE\",\"TSX\",\"ASX\"],");
        sb.append("\"config\":{");
        appendKV(sb, "maxOrderSize",          500_000 + rng.nextInt(500_000)); sb.append(",");
        appendKVStr(sb, "defaultCurrency",    currency);                       sb.append(",");
        appendKV(sb, "sessionTimeoutSeconds", 900 + rng.nextInt(3600));        sb.append(",");
        appendKV(sb, "enableDarkPool",        rng.nextBoolean());               sb.append(",");
        appendKV(sb, "enableAlgoTrading",     rng.nextBoolean());               sb.append(",");
        sb.append("\"riskLimits\":{");
        appendKV(sb, "maxDailyLoss",     maxLoss);            sb.append(",");
        appendKV(sb, "maxPositionSize",  maxLoss * 5);         sb.append(",");
        appendKV(sb, "maxLeverage",      leverage, 1);         sb.append(",");
        appendKV(sb, "stopLossRequired", rng.nextBoolean());
        sb.append("},");
        sb.append("\"feeTiers\":[");
        sb.append(feeTier(1, 0,          mf1,            tf1));            sb.append(",");
        sb.append(feeTier(2, 100_000,    mf1 * 0.85,     tf1 * 0.85));    sb.append(",");
        sb.append(feeTier(3, 1_000_000,  mf1 * 0.70,     tf1 * 0.70));    sb.append(",");
        sb.append(feeTier(4, 10_000_000, mf1 * 0.50,     tf1 * 0.50));
        sb.append("]");
        sb.append("}}");

        // user
        sb.append(",\"user\":{");
        appendKVStr(sb, "id",           userId);                        sb.append(",");
        appendKVStr(sb, "username",     "user" + id);                   sb.append(",");
        appendKVStr(sb, "email",        "user" + id + "@quantedge.io"); sb.append(",");
        appendKVStr(sb, "fullName",     "User " + id);                  sb.append(",");
        appendKVStr(sb, "phone",        "+1-416-555-" + String.format("%04d", rng.nextInt(10000))); sb.append(",");
        appendKV(sb, "kycVerified",     rng.nextBoolean());              sb.append(",");
        appendKV(sb, "twoFactorEnabled",rng.nextBoolean());              sb.append(",");
        appendKVStr(sb, "referralCode", "QE-REF-" + String.format("%04d", rng.nextInt(10000))); sb.append(",");
        sb.append("\"referredBy\":null,");
        appendKVStr(sb, "createdAt",    "2024-01-15T09:23:11Z"); sb.append(",");
        appendKVStr(sb, "lastLoginAt",  "2026-03-07T08:04:55Z"); sb.append(",");
        sb.append("\"roles\":[\"trader\",\"analyst\"],");
        sb.append("\"preferences\":{");
        appendKVStr(sb, "theme",        pick(themes, rng));     sb.append(",");
        appendKVStr(sb, "defaultChart", pick(chartTypes, rng)); sb.append(",");
        appendKVStr(sb, "timezone",     "America/Toronto");      sb.append(",");
        appendKVStr(sb, "currency",     pick(currencies, rng));  sb.append(",");
        sb.append("\"notifications\":{");
        appendKV(sb, "email",      rng.nextBoolean()); sb.append(",");
        appendKV(sb, "sms",        rng.nextBoolean()); sb.append(",");
        appendKV(sb, "push",       rng.nextBoolean()); sb.append(",");
        appendKV(sb, "priceAlerts",rng.nextBoolean()); sb.append(",");
        appendKV(sb, "orderFills", rng.nextBoolean()); sb.append(",");
        appendKV(sb, "newsDigest", rng.nextBoolean());
        sb.append("},\"chartDefaults\":{");
        appendKVStr(sb, "period", pick(periods, rng)); sb.append(",");
        sb.append("\"indicators\":[\"SMA_20\",\"SMA_50\",\"MACD\",\"RSI_14\"],");
        appendKV(sb, "showVolume", rng.nextBoolean()); sb.append(",");
        appendKV(sb, "showGrid",   rng.nextBoolean()); sb.append(",");
        appendKV(sb, "logScale",   rng.nextBoolean());
        sb.append("}}}");

        // accounts
        sb.append(",\"accounts\":[{");
        appendKVStr(sb, "id",              acctId);                      sb.append(",");
        appendKVStr(sb, "type",            pick(acctTypes, rng));        sb.append(",");
        appendKVStr(sb, "currency",        currency);                    sb.append(",");
        appendKV(sb, "balance",            balance);                     sb.append(",");
        appendKV(sb, "availableBalance",   avail);                       sb.append(",");
        appendKV(sb, "reservedForOrders",  reserved);                    sb.append(",");
        appendKV(sb, "totalDeposited",     deposited);                   sb.append(",");
        appendKV(sb, "totalWithdrawn",     withdrawn);                   sb.append(",");
        appendKV(sb, "totalRealizedPnL",   realized);                    sb.append(",");
        appendKV(sb, "isDefault",          true);                        sb.append(",");
        appendKV(sb, "isFrozen",           false);                       sb.append(",");
        sb.append("\"frozenReason\":null,");
        appendKV(sb, "marginUsed",         margin);                      sb.append(",");
        appendKVStr(sb, "openedAt",        "2024-01-15T09:30:00Z");
        sb.append("}]");

        // portfolio
        sb.append(",\"portfolio\":{");
        appendKVStr(sb, "accountId",          acctId);        sb.append(",");
        appendKVStr(sb, "asOf",               "2026-03-07T15:30:00Z"); sb.append(",");
        appendKV(sb, "totalValue",            totalVal);      sb.append(",");
        appendKV(sb, "cashBalance",           balance);       sb.append(",");
        appendKV(sb, "investedValue",         invested);      sb.append(",");
        appendKV(sb, "unrealizedPnL",         portUpnl);      sb.append(",");
        appendKV(sb, "unrealizedPnLPercent",  portUpnlPct);   sb.append(",");
        appendKV(sb, "dayPnL",                dayPnL);        sb.append(",");
        appendKV(sb, "dayPnLPercent",         dayPnLPct);     sb.append(",");
        sb.append("\"positions\":[{");
        appendKVStr(sb, "positionId",         String.format("POS-%08d", id)); sb.append(",");
        appendKVStr(sb, "symbol",             symbol1);                        sb.append(",");
        appendKVStr(sb, "exchange",           pick(exchanges, rng));            sb.append(",");
        appendKVStr(sb, "assetClass",         pick(assetClasses, rng));         sb.append(",");
        appendKV(sb, "quantity",              (long) qty1);                     sb.append(",");
        appendKV(sb, "avgEntryPrice",         entry1);                          sb.append(",");
        appendKV(sb, "currentPrice",          cur1);                            sb.append(",");
        appendKV(sb, "marketValue",           mktVal1);                         sb.append(",");
        appendKV(sb, "costBasis",             cost1);                           sb.append(",");
        appendKV(sb, "unrealizedPnL",         upnl1);                           sb.append(",");
        appendKV(sb, "unrealizedPnLPercent",  upnlPct1);                        sb.append(",");
        appendKV(sb, "dayChange",             dayChg1);                          sb.append(",");
        appendKV(sb, "dayChangePercent",      dayPct1);                          sb.append(",");
        appendKV(sb, "isShort",               rng.nextBoolean());                sb.append(",");
        appendKVStr(sb, "openedAt",           "2025-09-12T13:45:22Z");           sb.append(",");
        appendKVStr(sb, "lastUpdated",        "2026-03-07T15:30:00Z");
        sb.append("}],\"allocation\":{");
        sb.append("\"byAssetClass\":{");
        appendKV(sb, "equity",       equityPct); sb.append(",");
        appendKV(sb, "etf",          etfPct);    sb.append(",");
        appendKV(sb, "fixedIncome",  0.0);       sb.append(",");
        appendKV(sb, "crypto",       0.0);       sb.append(",");
        appendKV(sb, "cash",         0.0);
        sb.append("},\"bySector\":{");
        appendKV(sb, "technology",   techPct);  sb.append(",");
        appendKV(sb, "financials",   finPct);   sb.append(",");
        appendKV(sb, "healthcare",   hlthPct);  sb.append(",");
        appendKV(sb, "energy",       0.0);       sb.append(",");
        appendKV(sb, "other",        otherPct);
        sb.append("}}}");

        // orders
        sb.append(",\"orders\":[{");
        appendKVStr(sb, "orderId",            orderId);              sb.append(",");
        appendKVStr(sb, "accountId",          acctId);               sb.append(",");
        appendKVStr(sb, "symbol",             symbol2);              sb.append(",");
        appendKVStr(sb, "exchange",           pick(exchanges, rng));  sb.append(",");
        appendKVStr(sb, "side",               oSide);                sb.append(",");
        appendKVStr(sb, "type",               oType);                sb.append(",");
        appendKVStr(sb, "status",             oStatus);              sb.append(",");
        appendKV(sb, "quantity",              oQty);                 sb.append(",");
        appendKV(sb, "filledQuantity",        0);                    sb.append(",");
        appendKV(sb, "remainingQuantity",     oQty);                 sb.append(",");
        appendKV(sb, "limitPrice",            limitPx);              sb.append(",");
        sb.append("\"stopPrice\":null,");
        sb.append("\"trailingStopPercent\":null,");
        sb.append("\"avgFillPrice\":null,");
        appendKV(sb, "estimatedValue",        oQty * limitPx);       sb.append(",");
        sb.append("\"commission\":null,");
        appendKVStr(sb, "timeInForce",        tif);                  sb.append(",");
        appendKV(sb, "isExtendedHours",       rng.nextBoolean());     sb.append(",");
        sb.append("\"notes\":null,");
        sb.append("\"tags\":[],");
        appendKVStr(sb, "createdAt",  "2026-03-07T11:02:33Z"); sb.append(",");
        appendKVStr(sb, "updatedAt",  "2026-03-07T11:02:33Z"); sb.append(",");
        sb.append("\"filledAt\":null,");
        sb.append("\"cancelledAt\":null,");
        sb.append("\"cancelReason\":null");
        sb.append("}]");

        // watchlists
        sb.append(",\"watchlists\":[{");
        appendKVStr(sb, "id",        String.format("WL-%04d", id)); sb.append(",");
        appendKVStr(sb, "name",      "Watchlist " + id);            sb.append(",");
        appendKV(sb, "isDefault",    true);                         sb.append(",");
        sb.append("\"symbols\":[\"").append(pick(symbols, rng))
          .append("\",\"").append(pick(symbols, rng)).append("\"],");
        appendKVStr(sb, "createdAt", "2025-02-20T10:00:00Z");
        sb.append("}]");

        // alerts
        sb.append(",\"alerts\":[{");
        appendKVStr(sb, "alertId",   alertId);                    sb.append(",");
        appendKVStr(sb, "symbol",    alertSym);                   sb.append(",");
        appendKVStr(sb, "condition", pick(conditions, rng));       sb.append(",");
        appendKV(sb, "threshold",    alertThr);                    sb.append(",");
        appendKV(sb, "currentValue", alertCur);                    sb.append(",");
        appendKV(sb, "isActive",     true);                        sb.append(",");
        appendKV(sb, "isTriggered",  rng.nextBoolean());           sb.append(",");
        sb.append("\"triggeredAt\":null,");
        sb.append("\"notifyVia\":[\"push\"],");
        appendKVStr(sb, "message",   "Alert for " + alertSym);    sb.append(",");
        appendKVStr(sb, "createdAt", "2026-03-07T11:05:00Z");
        sb.append("}]");

        // marketData
        sb.append(",\"marketData\":{");
        appendKVStr(sb, "asOf",          "2026-03-07T15:30:00Z");  sb.append(",");
        appendKVStr(sb, "sessionStatus", "regular");                sb.append(",");
        sb.append("\"indices\":{");
        appendIndex(sb, "SPX", spx,                              rng); sb.append(",");
        appendIndex(sb, "NDX", ndx,                              rng); sb.append(",");
        appendIndex(sb, "DJI", dji,                              rng); sb.append(",");
        appendIndex(sb, "VIX", vix,                              rng);
        sb.append("},\"forex\":{");
        appendKV(sb, "USDCAD", 1.28 + rng.nextDouble() * 0.12); sb.append(",");
        appendKV(sb, "EURUSD", 1.02 + rng.nextDouble() * 0.12); sb.append(",");
        appendKV(sb, "GBPUSD", 1.22 + rng.nextDouble() * 0.12); sb.append(",");
        appendKV(sb, "USDJPY", 138   + rng.nextDouble() * 20);
        sb.append("},\"commodities\":{");
        appendKV(sb, "goldUSDPerOz",    2500 + rng.nextDouble() * 800); sb.append(",");
        appendKV(sb, "silverUSDPerOz",  26   + rng.nextDouble() * 12);  sb.append(",");
        appendKV(sb, "crudeoilWTIUSD",  55   + rng.nextDouble() * 40);  sb.append(",");
        appendKV(sb, "naturalGasUSD",   2.5  + rng.nextDouble() * 2.5);
        sb.append("},\"treasury\":{");
        appendKV(sb, "yield2Y",  yield10 - 0.3 - rng.nextDouble() * 0.5); sb.append(",");
        appendKV(sb, "yield10Y", yield10);                                  sb.append(",");
        appendKV(sb, "yield30Y", yield10 + 0.2 + rng.nextDouble() * 0.4);  sb.append(",");
        appendKV(sb, "yieldCurveInverted", inverted);
        sb.append("}}");

        // auditLog
        sb.append(",\"auditLog\":[");
        // entry 1 — LOGIN (detail is null)
        sb.append("{");
        appendKVStr(sb, "eventId",   String.format("EVT-%d-001", id)); sb.append(",");
        appendKVStr(sb, "userId",    userId);                           sb.append(",");
        appendKVStr(sb, "action",    "LOGIN");                          sb.append(",");
        appendKVStr(sb, "ipAddress", String.format("10.%d.%d.%d", ip2, ip3, ip4)); sb.append(",");
        appendKVStr(sb, "userAgent", "QuantEdge-Desktop/4.2.1 (Windows 11)");      sb.append(",");
        appendKV(sb, "success",      true);                             sb.append(",");
        sb.append("\"detail\":null,");
        appendKVStr(sb, "timestamp", "2026-03-07T08:04:55Z");
        sb.append("},");
        // entry 2 — action with detail object
        sb.append("{");
        appendKVStr(sb, "eventId",   String.format("EVT-%d-002", id)); sb.append(",");
        appendKVStr(sb, "userId",    userId);                           sb.append(",");
        appendKVStr(sb, "action",    auditAction);                      sb.append(",");
        appendKVStr(sb, "ipAddress", String.format("10.%d.%d.%d", ip2, ip3, ip4)); sb.append(",");
        appendKVStr(sb, "userAgent", "QuantEdge-Desktop/4.2.1 (Windows 11)");      sb.append(",");
        appendKV(sb, "success",      auditOk);                          sb.append(",");
        sb.append("\"detail\":{");
        appendKVStr(sb, "orderId",   orderId);   sb.append(",");
        appendKVStr(sb, "symbol",    symbol2);   sb.append(",");
        appendKV(sb, "quantity",     oQty);       sb.append(",");
        appendKV(sb, "limitPrice",   limitPx);
        sb.append("},");
        appendKVStr(sb, "timestamp", "2026-03-07T11:02:33Z");
        sb.append("}");
        sb.append("]");

        sb.append("}");
        return sb.toString();
    }

    // -------------------------------------------------------- builder helpers
    private static void appendKV(StringBuilder sb, String key, double val) {
        sb.append('"').append(key).append("\":").append(String.format("%.2f", val));
    }

    private static void appendKV(StringBuilder sb, String key, double val, int decimals) {
        sb.append('"').append(key).append("\":").append(String.format("%." + decimals + "f", val));
    }

    private static void appendKV(StringBuilder sb, String key, long val) {
        sb.append('"').append(key).append("\":").append(val);
    }

    private static void appendKV(StringBuilder sb, String key, int val) {
        sb.append('"').append(key).append("\":").append(val);
    }

    private static void appendKV(StringBuilder sb, String key, boolean val) {
        sb.append('"').append(key).append("\":").append(val);
    }

    private static void appendKVStr(StringBuilder sb, String key, String val) {
        sb.append('"').append(key).append("\":\"").append(val).append('"');
    }

    private static String feeTier(int tier, long vol, double maker, double taker) {
        return String.format(
            "{\"tier\":%d,\"monthlyVolume\":%d,\"makerFee\":%.4f,\"takerFee\":%.4f}",
            tier, vol, maker, taker);
    }

    private static void appendIndex(StringBuilder sb, String name, double last, Random rng) {
        double change = (rng.nextDouble() - 0.5) * last * 0.02;
        double chgPct = change / last * 100;
        double ytd    = (rng.nextDouble() - 0.3) * 15;
        sb.append('"').append(name).append("\":{");
        appendKV(sb, "last",             last);   sb.append(",");
        appendKV(sb, "change",           change); sb.append(",");
        appendKV(sb, "changePercent",    chgPct); sb.append(",");
        appendKV(sb, "ytdChangePercent", ytd);
        sb.append("}");
    }

    private static <T> T pick(T[] arr, Random rng) {
        return arr[rng.nextInt(arr.length)];
    }

    // ============================================================= parseArgs
    private static void parseArgs(String[] args) {
        if (args.length % 2 != 0) usage("Arguments must be key-value pairs.");

        Map<String, String> map = new LinkedHashMap<>();
        for (int i = 0; i < args.length; i += 2)
            map.put(args[i], args[i + 1]);

        url       = require(map, "-url");
        threads   = requireInt(map, "-threads",   1, Integer.MAX_VALUE);
        rows      = requireInt(map, "-rows",      1, Integer.MAX_VALUE);
        batchSize = requireInt(map, "-batchsize", 1, Integer.MAX_VALUE);
    }

    private static String require(Map<String, String> m, String key) {
        String v = m.get(key);
        if (v == null) usage("Missing required option: " + key);
        return v;
    }

    private static int requireInt(Map<String, String> m, String key, int min, int max) {
        String v = require(m, key);
        int n;
        try { n = Integer.parseInt(v); }
        catch (NumberFormatException e) { usage(key + " must be an integer, got: " + v); return 0; }
        if (n < min || n > max) usage(key + " must be between " + min + " and " + max + ", got: " + n);
        return n;
    }

    private static void usage(String msg) {
        System.err.println("Error: " + msg);
        System.err.println();
        System.err.println("Usage:");
        System.err.println("  java JsonBatch -url <jdbc-url> -threads <n> -rows <n> -batchsize <n>");
        System.err.println();
        System.err.println("Options:");
        System.err.println("  -url       JDBC connection URL");
        System.err.println("  -threads   Number of concurrent writer threads");
        System.err.println("  -rows      Total rows to insert across all threads");
        System.err.println("  -batchsize Number of rows per JDBC batch / commit");
        System.err.println();
        System.err.println("Example (TimesTen direct connection):");
        System.err.println("  java -cp .:/opt/TimesTen/tt221/lib/ttjdbc8.jar JsonBatch \\");
        System.err.println("       -url \"jdbc:timesten:direct:sampledb\" \\");
        System.err.println("       -threads 4 -rows 100000 -batchsize 500");
        System.exit(1);
    }
}
