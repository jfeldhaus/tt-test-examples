-- ============================================================
-- trading_app.sql
-- Drop, create, and populate trade_documents for TimesTen
-- ============================================================

DROP TABLE trade_documents;

CREATE TABLE trade_documents (
    id   INTEGER      NOT NULL PRIMARY KEY,
    doc  JSON
);

INSERT INTO trade_documents (id, doc) VALUES (
    1,
    '{
  "application": {
    "name": "QuantEdge Trading Platform",
    "version": "4.2.1",
    "build": 20260307,
    "isLive": true,
    "maintenanceMode": false,
    "debugLevel": null,
    "supportedMarkets": ["NYSE", "NASDAQ", "LSE", "TSX", "ASX"],
    "config": {
      "maxOrderSize": 1000000,
      "defaultCurrency": "USD",
      "sessionTimeoutSeconds": 1800,
      "enableDarkPool": false,
      "enableAlgoTrading": true,
      "riskLimits": {
        "maxDailyLoss": 50000.00,
        "maxPositionSize": 250000.00,
        "maxLeverage": 4.5,
        "stopLossRequired": true
      },
      "feeTiers": [
        { "tier": 1, "monthlyVolume": 0,        "makerFee": 0.0020, "takerFee": 0.0035 },
        { "tier": 2, "monthlyVolume": 100000,   "makerFee": 0.0015, "takerFee": 0.0025 },
        { "tier": 3, "monthlyVolume": 1000000,  "makerFee": 0.0010, "takerFee": 0.0018 },
        { "tier": 4, "monthlyVolume": 10000000, "makerFee": 0.0005, "takerFee": 0.0010 }
      ]
    }
  },
  "user": {
    "id": "USR-00482901",
    "username": "jfeldhaus",
    "email": "j.feldhaus@quantedge.io",
    "fullName": "Jan Feldhaus",
    "phone": "+1-416-555-0193",
    "kycVerified": true,
    "twoFactorEnabled": true,
    "referralCode": "QE-REF-7721",
    "referredBy": null,
    "createdAt": "2024-01-15T09:23:11Z",
    "lastLoginAt": "2026-03-07T08:04:55Z",
    "roles": ["trader", "analyst"],
    "preferences": {
      "theme": "dark",
      "defaultChart": "candlestick",
      "timezone": "America/Toronto",
      "currency": "CAD",
      "notifications": {
        "email": true,
        "sms": false,
        "push": true,
        "priceAlerts": true,
        "orderFills": true,
        "newsDigest": false
      },
      "chartDefaults": {
        "period": "1D",
        "indicators": ["SMA_20", "SMA_50", "MACD", "RSI_14"],
        "showVolume": true,
        "showGrid": true,
        "logScale": false
      }
    }
  },
  "accounts": [
    {
      "id": "ACC-CASH-00128",
      "type": "cash",
      "currency": "USD",
      "balance": 84231.57,
      "availableBalance": 61480.00,
      "reservedForOrders": 22751.57,
      "totalDeposited": 150000.00,
      "totalWithdrawn": 72000.00,
      "totalRealizedPnL": 6231.57,
      "isDefault": true,
      "isFrozen": false,
      "frozenReason": null,
      "marginUsed": 0.00,
      "openedAt": "2024-01-15T09:30:00Z"
    },
    {
      "id": "ACC-MRGN-00129",
      "type": "margin",
      "currency": "USD",
      "balance": 32000.00,
      "availableBalance": 18400.00,
      "reservedForOrders": 13600.00,
      "totalDeposited": 40000.00,
      "totalWithdrawn": 12000.00,
      "totalRealizedPnL": 4000.00,
      "isDefault": false,
      "isFrozen": false,
      "frozenReason": null,
      "marginUsed": 27200.00,
      "openedAt": "2024-06-01T14:00:00Z"
    }
  ],
  "portfolio": {
    "accountId": "ACC-CASH-00128",
    "asOf": "2026-03-07T15:30:00Z",
    "totalValue": 146003.47,
    "cashBalance": 84231.57,
    "investedValue": 61771.90,
    "unrealizedPnL": 4382.15,
    "unrealizedPnLPercent": 7.63,
    "dayPnL": -312.44,
    "dayPnLPercent": -0.21,
    "positions": [
      {
        "positionId": "POS-00019922",
        "symbol": "AAPL",
        "exchange": "NASDAQ",
        "assetClass": "equity",
        "quantity": 85,
        "avgEntryPrice": 178.42,
        "currentPrice": 194.11,
        "marketValue": 16499.35,
        "costBasis": 15165.70,
        "unrealizedPnL": 1333.65,
        "unrealizedPnLPercent": 8.79,
        "dayChange": -1.23,
        "dayChangePercent": -0.63,
        "isShort": false,
        "openedAt": "2025-09-12T13:45:22Z",
        "lastUpdated": "2026-03-07T15:30:00Z"
      },
      {
        "positionId": "POS-00021103",
        "symbol": "MSFT",
        "exchange": "NASDAQ",
        "assetClass": "equity",
        "quantity": 40,
        "avgEntryPrice": 389.75,
        "currentPrice": 412.30,
        "marketValue": 16492.00,
        "costBasis": 15590.00,
        "unrealizedPnL": 902.00,
        "unrealizedPnLPercent": 5.79,
        "dayChange": 2.87,
        "dayChangePercent": 0.70,
        "isShort": false,
        "openedAt": "2025-11-03T10:12:08Z",
        "lastUpdated": "2026-03-07T15:30:00Z"
      },
      {
        "positionId": "POS-00022871",
        "symbol": "SPY",
        "exchange": "NYSE",
        "assetClass": "etf",
        "quantity": 60,
        "avgEntryPrice": 475.10,
        "currentPrice": 481.35,
        "marketValue": 28881.00,
        "costBasis": 28506.00,
        "unrealizedPnL": 375.00,
        "unrealizedPnLPercent": 1.32,
        "dayChange": -0.95,
        "dayChangePercent": -0.20,
        "isShort": false,
        "openedAt": "2026-01-08T09:31:00Z",
        "lastUpdated": "2026-03-07T15:30:00Z"
      }
    ],
    "allocation": {
      "byAssetClass": {
        "equity": 53.00,
        "etf": 47.00,
        "fixedIncome": 0.00,
        "crypto": 0.00,
        "cash": 0.00
      },
      "bySector": {
        "technology": 79.47,
        "financials": 0.00,
        "healthcare": 0.00,
        "energy": 0.00,
        "other": 20.53
      }
    }
  },
  "orders": [
    {
      "orderId": "ORD-20260307-88412",
      "accountId": "ACC-CASH-00128",
      "symbol": "NVDA",
      "exchange": "NASDAQ",
      "side": "buy",
      "type": "limit",
      "status": "open",
      "quantity": 20,
      "filledQuantity": 0,
      "remainingQuantity": 20,
      "limitPrice": 875.00,
      "stopPrice": null,
      "trailingStopPercent": null,
      "avgFillPrice": null,
      "estimatedValue": 17500.00,
      "commission": null,
      "timeInForce": "GTC",
      "isExtendedHours": false,
      "notes": "Accumulate on dip below 875",
      "tags": ["swing-trade", "ai-sector"],
      "createdAt": "2026-03-07T11:02:33Z",
      "updatedAt": "2026-03-07T11:02:33Z",
      "filledAt": null,
      "cancelledAt": null,
      "cancelReason": null
    },
    {
      "orderId": "ORD-20260305-77301",
      "accountId": "ACC-CASH-00128",
      "symbol": "TSLA",
      "exchange": "NASDAQ",
      "side": "sell",
      "type": "market",
      "status": "filled",
      "quantity": 15,
      "filledQuantity": 15,
      "remainingQuantity": 0,
      "limitPrice": null,
      "stopPrice": null,
      "trailingStopPercent": null,
      "avgFillPrice": 263.44,
      "estimatedValue": 3951.60,
      "commission": 0.00,
      "timeInForce": "DAY",
      "isExtendedHours": false,
      "notes": null,
      "tags": ["profit-take"],
      "createdAt": "2026-03-05T14:28:10Z",
      "updatedAt": "2026-03-05T14:28:19Z",
      "filledAt": "2026-03-05T14:28:19Z",
      "cancelledAt": null,
      "cancelReason": null
    }
  ],
  "watchlists": [
    {
      "id": "WL-001",
      "name": "AI & Semiconductors",
      "isDefault": true,
      "symbols": ["NVDA", "AMD", "INTC", "QCOM", "AVGO", "TSM", "ARM"],
      "createdAt": "2025-02-20T10:00:00Z"
    },
    {
      "id": "WL-002",
      "name": "Dividend Income",
      "isDefault": false,
      "symbols": ["JNJ", "KO", "PG", "VZ", "T", "MO", "ABBV"],
      "createdAt": "2025-05-14T08:30:00Z"
    }
  ],
  "alerts": [
    {
      "alertId": "ALT-00771",
      "symbol": "NVDA",
      "condition": "price_below",
      "threshold": 875.00,
      "currentValue": 891.32,
      "isActive": true,
      "isTriggered": false,
      "triggeredAt": null,
      "notifyVia": ["push", "email"],
      "message": "NVDA dropped below buy target",
      "createdAt": "2026-03-07T11:05:00Z"
    },
    {
      "alertId": "ALT-00655",
      "symbol": "AAPL",
      "condition": "price_above",
      "threshold": 200.00,
      "currentValue": 194.11,
      "isActive": true,
      "isTriggered": false,
      "triggeredAt": null,
      "notifyVia": ["push"],
      "message": "AAPL breakout above 200",
      "createdAt": "2026-02-18T09:15:00Z"
    }
  ],
  "marketData": {
    "asOf": "2026-03-07T15:30:00Z",
    "sessionStatus": "regular",
    "indices": {
      "SPX": { "last": 5412.73, "change": -11.42, "changePercent": -0.21, "ytdChangePercent": 3.87 },
      "NDX": { "last": 18943.10, "change": 42.18,  "changePercent": 0.22,  "ytdChangePercent": 5.21 },
      "DJI": { "last": 41882.55, "change": -98.33, "changePercent": -0.23, "ytdChangePercent": 2.14 },
      "VIX": { "last": 18.42,   "change": 0.77,   "changePercent": 4.36,  "ytdChangePercent": null }
    },
    "forex": {
      "USDCAD": 1.3621,
      "EURUSD": 1.0844,
      "GBPUSD": 1.2733,
      "USDJPY": 148.92
    },
    "commodities": {
      "goldUSDPerOz": 2914.50,
      "silverUSDPerOz": 32.17,
      "crudeoilWTIUSD": 68.44,
      "naturalGasUSD": 3.82
    },
    "treasury": {
      "yield2Y": 4.21,
      "yield10Y": 4.48,
      "yield30Y": 4.71,
      "yieldCurveInverted": false
    }
  },
  "auditLog": [
    {
      "eventId": "EVT-20260307-001",
      "userId": "USR-00482901",
      "action": "LOGIN",
      "ipAddress": "142.113.88.201",
      "userAgent": "QuantEdge-Desktop/4.2.1 (Windows 11)",
      "success": true,
      "detail": null,
      "timestamp": "2026-03-07T08:04:55Z"
    },
    {
      "eventId": "EVT-20260307-002",
      "userId": "USR-00482901",
      "action": "ORDER_PLACED",
      "ipAddress": "142.113.88.201",
      "userAgent": "QuantEdge-Desktop/4.2.1 (Windows 11)",
      "success": true,
      "detail": { "orderId": "ORD-20260307-88412", "symbol": "NVDA", "quantity": 20, "limitPrice": 875.00 },
      "timestamp": "2026-03-07T11:02:33Z"
    },
    {
      "eventId": "EVT-20260307-003",
      "userId": "USR-00482901",
      "action": "ALERT_CREATED",
      "ipAddress": "142.113.88.201",
      "userAgent": "QuantEdge-Desktop/4.2.1 (Windows 11)",
      "success": true,
      "detail": { "alertId": "ALT-00771", "symbol": "NVDA", "condition": "price_below", "threshold": 875.00 },
      "timestamp": "2026-03-07T11:05:00Z"
    }
  ]
}'
);

COMMIT;










-- ============================================================
-- Full Document Scalar Extraction  (TimesTen dialect)
--
-- Uses JSON_VALUE to read every scalar leaf from the JSON
-- document stored in trade_documents (id = 1) as a single
-- flat row.  One column is produced per leaf, grouped and
-- labelled by top-level section:
--   application      – app metadata and configuration
--   user             – profile, preferences, and notifications
--   portfolio        – summary metrics and each position
--                      (arrays addressed by index 0-N)
--   orders           – each order record (index 0-N)
--   accounts         – each account record (index 0-N)
--   riskManagement   – limits and margin settings
--   marketData       – watchlist and price alerts
--   auditLog         – the three most recent audit entries
-- ============================================================
SELECT
    -- application
    JSON_VALUE(doc, '$.application.name')                                AS app_name,
    JSON_VALUE(doc, '$.application.version')                             AS app_version,
    JSON_VALUE(doc, '$.application.build')                               AS app_build,
    JSON_VALUE(doc, '$.application.isLive')                              AS app_is_live,
    JSON_VALUE(doc, '$.application.maintenanceMode')                     AS app_maintenance_mode,
    JSON_VALUE(doc, '$.application.debugLevel')                          AS app_debug_level,
    JSON_VALUE(doc, '$.application.supportedMarkets[0]')                 AS market_0,
    JSON_VALUE(doc, '$.application.supportedMarkets[1]')                 AS market_1,
    JSON_VALUE(doc, '$.application.supportedMarkets[2]')                 AS market_2,
    JSON_VALUE(doc, '$.application.supportedMarkets[3]')                 AS market_3,
    JSON_VALUE(doc, '$.application.supportedMarkets[4]')                 AS market_4,
    -- application.config
    JSON_VALUE(doc, '$.application.config.maxOrderSize')                 AS cfg_max_order_size,
    JSON_VALUE(doc, '$.application.config.defaultCurrency')              AS cfg_default_currency,
    JSON_VALUE(doc, '$.application.config.sessionTimeoutSeconds')        AS cfg_session_timeout,
    JSON_VALUE(doc, '$.application.config.enableDarkPool')               AS cfg_enable_dark_pool,
    JSON_VALUE(doc, '$.application.config.enableAlgoTrading')            AS cfg_enable_algo_trading,
    -- application.config.riskLimits
    JSON_VALUE(doc, '$.application.config.riskLimits.maxDailyLoss')      AS risk_max_daily_loss,
    JSON_VALUE(doc, '$.application.config.riskLimits.maxPositionSize')   AS risk_max_position_size,
    JSON_VALUE(doc, '$.application.config.riskLimits.maxLeverage')       AS risk_max_leverage,
    JSON_VALUE(doc, '$.application.config.riskLimits.stopLossRequired')  AS risk_stop_loss_required,
    -- application.config.feeTiers[0]
    JSON_VALUE(doc, '$.application.config.feeTiers[0].tier')             AS fee_tier_0,
    JSON_VALUE(doc, '$.application.config.feeTiers[0].monthlyVolume')    AS fee_monthly_vol_0,
    JSON_VALUE(doc, '$.application.config.feeTiers[0].makerFee')         AS fee_maker_0,
    JSON_VALUE(doc, '$.application.config.feeTiers[0].takerFee')         AS fee_taker_0,
    -- application.config.feeTiers[1]
    JSON_VALUE(doc, '$.application.config.feeTiers[1].tier')             AS fee_tier_1,
    JSON_VALUE(doc, '$.application.config.feeTiers[1].monthlyVolume')    AS fee_monthly_vol_1,
    JSON_VALUE(doc, '$.application.config.feeTiers[1].makerFee')         AS fee_maker_1,
    JSON_VALUE(doc, '$.application.config.feeTiers[1].takerFee')         AS fee_taker_1,
    -- application.config.feeTiers[2]
    JSON_VALUE(doc, '$.application.config.feeTiers[2].tier')             AS fee_tier_2,
    JSON_VALUE(doc, '$.application.config.feeTiers[2].monthlyVolume')    AS fee_monthly_vol_2,
    JSON_VALUE(doc, '$.application.config.feeTiers[2].makerFee')         AS fee_maker_2,
    JSON_VALUE(doc, '$.application.config.feeTiers[2].takerFee')         AS fee_taker_2,
    -- application.config.feeTiers[3]
    JSON_VALUE(doc, '$.application.config.feeTiers[3].tier')             AS fee_tier_3,
    JSON_VALUE(doc, '$.application.config.feeTiers[3].monthlyVolume')    AS fee_monthly_vol_3,
    JSON_VALUE(doc, '$.application.config.feeTiers[3].makerFee')         AS fee_maker_3,
    JSON_VALUE(doc, '$.application.config.feeTiers[3].takerFee')         AS fee_taker_3,
    -- user
    JSON_VALUE(doc, '$.user.id')                                         AS user_id,
    JSON_VALUE(doc, '$.user.username')                                   AS user_username,
    JSON_VALUE(doc, '$.user.email')                                      AS user_email,
    JSON_VALUE(doc, '$.user.fullName')                                   AS user_full_name,
    JSON_VALUE(doc, '$.user.phone')                                      AS user_phone,
    JSON_VALUE(doc, '$.user.kycVerified')                                AS user_kyc_verified,
    JSON_VALUE(doc, '$.user.twoFactorEnabled')                           AS user_two_factor,
    JSON_VALUE(doc, '$.user.referralCode')                               AS user_referral_code,
    JSON_VALUE(doc, '$.user.referredBy')                                 AS user_referred_by,
    JSON_VALUE(doc, '$.user.createdAt')                                  AS user_created_at,
    JSON_VALUE(doc, '$.user.lastLoginAt')                                AS user_last_login_at,
    JSON_VALUE(doc, '$.user.roles[0]')                                   AS user_role_0,
    JSON_VALUE(doc, '$.user.roles[1]')                                   AS user_role_1,
    -- user.preferences
    JSON_VALUE(doc, '$.user.preferences.theme')                          AS pref_theme,
    JSON_VALUE(doc, '$.user.preferences.defaultChart')                   AS pref_default_chart,
    JSON_VALUE(doc, '$.user.preferences.timezone')                       AS pref_timezone,
    JSON_VALUE(doc, '$.user.preferences.currency')                       AS pref_currency,
    -- user.preferences.notifications
    JSON_VALUE(doc, '$.user.preferences.notifications.email')            AS notif_email,
    JSON_VALUE(doc, '$.user.preferences.notifications.sms')              AS notif_sms,
    JSON_VALUE(doc, '$.user.preferences.notifications.push')             AS notif_push,
    JSON_VALUE(doc, '$.user.preferences.notifications.priceAlerts')      AS notif_price_alerts,
    JSON_VALUE(doc, '$.user.preferences.notifications.orderFills')       AS notif_order_fills,
    JSON_VALUE(doc, '$.user.preferences.notifications.newsDigest')       AS notif_news_digest,
    -- user.preferences.chartDefaults
    JSON_VALUE(doc, '$.user.preferences.chartDefaults.period')           AS chart_period,
    JSON_VALUE(doc, '$.user.preferences.chartDefaults.indicators[0]')    AS chart_indicator_0,
    JSON_VALUE(doc, '$.user.preferences.chartDefaults.indicators[1]')    AS chart_indicator_1,
    JSON_VALUE(doc, '$.user.preferences.chartDefaults.indicators[2]')    AS chart_indicator_2,
    JSON_VALUE(doc, '$.user.preferences.chartDefaults.indicators[3]')    AS chart_indicator_3,
    JSON_VALUE(doc, '$.user.preferences.chartDefaults.showVolume')       AS chart_show_volume,
    JSON_VALUE(doc, '$.user.preferences.chartDefaults.showGrid')         AS chart_show_grid,
    JSON_VALUE(doc, '$.user.preferences.chartDefaults.logScale')         AS chart_log_scale,
    -- accounts[0]
    JSON_VALUE(doc, '$.accounts[0].id')                                  AS acct0_id,
    JSON_VALUE(doc, '$.accounts[0].type')                                AS acct0_type,
    JSON_VALUE(doc, '$.accounts[0].currency')                            AS acct0_currency,
    JSON_VALUE(doc, '$.accounts[0].balance')                             AS acct0_balance,
    JSON_VALUE(doc, '$.accounts[0].availableBalance')                    AS acct0_available_balance,
    JSON_VALUE(doc, '$.accounts[0].reservedForOrders')                   AS acct0_reserved,
    JSON_VALUE(doc, '$.accounts[0].totalDeposited')                      AS acct0_total_deposited,
    JSON_VALUE(doc, '$.accounts[0].totalWithdrawn')                      AS acct0_total_withdrawn,
    JSON_VALUE(doc, '$.accounts[0].totalRealizedPnL')                    AS acct0_realized_pnl,
    JSON_VALUE(doc, '$.accounts[0].isDefault')                           AS acct0_is_default,
    JSON_VALUE(doc, '$.accounts[0].isFrozen')                            AS acct0_is_frozen,
    JSON_VALUE(doc, '$.accounts[0].frozenReason')                        AS acct0_frozen_reason,
    JSON_VALUE(doc, '$.accounts[0].marginUsed')                          AS acct0_margin_used,
    JSON_VALUE(doc, '$.accounts[0].openedAt')                            AS acct0_opened_at,
    -- accounts[1]
    JSON_VALUE(doc, '$.accounts[1].id')                                  AS acct1_id,
    JSON_VALUE(doc, '$.accounts[1].type')                                AS acct1_type,
    JSON_VALUE(doc, '$.accounts[1].currency')                            AS acct1_currency,
    JSON_VALUE(doc, '$.accounts[1].balance')                             AS acct1_balance,
    JSON_VALUE(doc, '$.accounts[1].availableBalance')                    AS acct1_available_balance,
    JSON_VALUE(doc, '$.accounts[1].reservedForOrders')                   AS acct1_reserved,
    JSON_VALUE(doc, '$.accounts[1].totalDeposited')                      AS acct1_total_deposited,
    JSON_VALUE(doc, '$.accounts[1].totalWithdrawn')                      AS acct1_total_withdrawn,
    JSON_VALUE(doc, '$.accounts[1].totalRealizedPnL')                    AS acct1_realized_pnl,
    JSON_VALUE(doc, '$.accounts[1].isDefault')                           AS acct1_is_default,
    JSON_VALUE(doc, '$.accounts[1].isFrozen')                            AS acct1_is_frozen,
    JSON_VALUE(doc, '$.accounts[1].frozenReason')                        AS acct1_frozen_reason,
    JSON_VALUE(doc, '$.accounts[1].marginUsed')                          AS acct1_margin_used,
    JSON_VALUE(doc, '$.accounts[1].openedAt')                            AS acct1_opened_at,
    -- portfolio
    JSON_VALUE(doc, '$.portfolio.accountId')                             AS port_account_id,
    JSON_VALUE(doc, '$.portfolio.asOf')                                  AS port_as_of,
    JSON_VALUE(doc, '$.portfolio.totalValue')                            AS port_total_value,
    JSON_VALUE(doc, '$.portfolio.cashBalance')                           AS port_cash_balance,
    JSON_VALUE(doc, '$.portfolio.investedValue')                         AS port_invested_value,
    JSON_VALUE(doc, '$.portfolio.unrealizedPnL')                         AS port_unrealized_pnl,
    JSON_VALUE(doc, '$.portfolio.unrealizedPnLPercent')                  AS port_unrealized_pnl_pct,
    JSON_VALUE(doc, '$.portfolio.dayPnL')                                AS port_day_pnl,
    JSON_VALUE(doc, '$.portfolio.dayPnLPercent')                         AS port_day_pnl_pct,
    -- portfolio.positions[0] - AAPL
    JSON_VALUE(doc, '$.portfolio.positions[0].positionId')               AS pos0_id,
    JSON_VALUE(doc, '$.portfolio.positions[0].symbol')                   AS pos0_symbol,
    JSON_VALUE(doc, '$.portfolio.positions[0].exchange')                 AS pos0_exchange,
    JSON_VALUE(doc, '$.portfolio.positions[0].assetClass')               AS pos0_asset_class,
    JSON_VALUE(doc, '$.portfolio.positions[0].quantity')                 AS pos0_quantity,
    JSON_VALUE(doc, '$.portfolio.positions[0].avgEntryPrice')            AS pos0_avg_entry_price,
    JSON_VALUE(doc, '$.portfolio.positions[0].currentPrice')             AS pos0_current_price,
    JSON_VALUE(doc, '$.portfolio.positions[0].marketValue')              AS pos0_market_value,
    JSON_VALUE(doc, '$.portfolio.positions[0].costBasis')                AS pos0_cost_basis,
    JSON_VALUE(doc, '$.portfolio.positions[0].unrealizedPnL')            AS pos0_unrealized_pnl,
    JSON_VALUE(doc, '$.portfolio.positions[0].unrealizedPnLPercent')     AS pos0_unrealized_pnl_pct,
    JSON_VALUE(doc, '$.portfolio.positions[0].dayChange')                AS pos0_day_change,
    JSON_VALUE(doc, '$.portfolio.positions[0].dayChangePercent')         AS pos0_day_change_pct,
    JSON_VALUE(doc, '$.portfolio.positions[0].isShort')                  AS pos0_is_short,
    JSON_VALUE(doc, '$.portfolio.positions[0].openedAt')                 AS pos0_opened_at,
    JSON_VALUE(doc, '$.portfolio.positions[0].lastUpdated')              AS pos0_last_updated,
    -- portfolio.positions[1] - MSFT
    JSON_VALUE(doc, '$.portfolio.positions[1].positionId')               AS pos1_id,
    JSON_VALUE(doc, '$.portfolio.positions[1].symbol')                   AS pos1_symbol,
    JSON_VALUE(doc, '$.portfolio.positions[1].exchange')                 AS pos1_exchange,
    JSON_VALUE(doc, '$.portfolio.positions[1].assetClass')               AS pos1_asset_class,
    JSON_VALUE(doc, '$.portfolio.positions[1].quantity')                 AS pos1_quantity,
    JSON_VALUE(doc, '$.portfolio.positions[1].avgEntryPrice')            AS pos1_avg_entry_price,
    JSON_VALUE(doc, '$.portfolio.positions[1].currentPrice')             AS pos1_current_price,
    JSON_VALUE(doc, '$.portfolio.positions[1].marketValue')              AS pos1_market_value,
    JSON_VALUE(doc, '$.portfolio.positions[1].costBasis')                AS pos1_cost_basis,
    JSON_VALUE(doc, '$.portfolio.positions[1].unrealizedPnL')            AS pos1_unrealized_pnl,
    JSON_VALUE(doc, '$.portfolio.positions[1].unrealizedPnLPercent')     AS pos1_unrealized_pnl_pct,
    JSON_VALUE(doc, '$.portfolio.positions[1].dayChange')                AS pos1_day_change,
    JSON_VALUE(doc, '$.portfolio.positions[1].dayChangePercent')         AS pos1_day_change_pct,
    JSON_VALUE(doc, '$.portfolio.positions[1].isShort')                  AS pos1_is_short,
    JSON_VALUE(doc, '$.portfolio.positions[1].openedAt')                 AS pos1_opened_at,
    JSON_VALUE(doc, '$.portfolio.positions[1].lastUpdated')              AS pos1_last_updated,
    -- portfolio.positions[2] - SPY
    JSON_VALUE(doc, '$.portfolio.positions[2].positionId')               AS pos2_id,
    JSON_VALUE(doc, '$.portfolio.positions[2].symbol')                   AS pos2_symbol,
    JSON_VALUE(doc, '$.portfolio.positions[2].exchange')                 AS pos2_exchange,
    JSON_VALUE(doc, '$.portfolio.positions[2].assetClass')               AS pos2_asset_class,
    JSON_VALUE(doc, '$.portfolio.positions[2].quantity')                 AS pos2_quantity,
    JSON_VALUE(doc, '$.portfolio.positions[2].avgEntryPrice')            AS pos2_avg_entry_price,
    JSON_VALUE(doc, '$.portfolio.positions[2].currentPrice')             AS pos2_current_price,
    JSON_VALUE(doc, '$.portfolio.positions[2].marketValue')              AS pos2_market_value,
    JSON_VALUE(doc, '$.portfolio.positions[2].costBasis')                AS pos2_cost_basis,
    JSON_VALUE(doc, '$.portfolio.positions[2].unrealizedPnL')            AS pos2_unrealized_pnl,
    JSON_VALUE(doc, '$.portfolio.positions[2].unrealizedPnLPercent')     AS pos2_unrealized_pnl_pct,
    JSON_VALUE(doc, '$.portfolio.positions[2].dayChange')                AS pos2_day_change,
    JSON_VALUE(doc, '$.portfolio.positions[2].dayChangePercent')         AS pos2_day_change_pct,
    JSON_VALUE(doc, '$.portfolio.positions[2].isShort')                  AS pos2_is_short,
    JSON_VALUE(doc, '$.portfolio.positions[2].openedAt')                 AS pos2_opened_at,
    JSON_VALUE(doc, '$.portfolio.positions[2].lastUpdated')              AS pos2_last_updated,
    -- portfolio.allocation.byAssetClass
    JSON_VALUE(doc, '$.portfolio.allocation.byAssetClass.equity')        AS alloc_equity,
    JSON_VALUE(doc, '$.portfolio.allocation.byAssetClass.etf')           AS alloc_etf,
    JSON_VALUE(doc, '$.portfolio.allocation.byAssetClass.fixedIncome')   AS alloc_fixed_income,
    JSON_VALUE(doc, '$.portfolio.allocation.byAssetClass.crypto')        AS alloc_crypto,
    JSON_VALUE(doc, '$.portfolio.allocation.byAssetClass.cash')          AS alloc_cash,
    -- portfolio.allocation.bySector
    JSON_VALUE(doc, '$.portfolio.allocation.bySector.technology')        AS alloc_technology,
    JSON_VALUE(doc, '$.portfolio.allocation.bySector.financials')        AS alloc_financials,
    JSON_VALUE(doc, '$.portfolio.allocation.bySector.healthcare')        AS alloc_healthcare,
    JSON_VALUE(doc, '$.portfolio.allocation.bySector.energy')            AS alloc_energy,
    JSON_VALUE(doc, '$.portfolio.allocation.bySector.other')             AS alloc_other,
    -- orders[0] - NVDA open limit
    JSON_VALUE(doc, '$.orders[0].orderId')                               AS ord0_id,
    JSON_VALUE(doc, '$.orders[0].accountId')                             AS ord0_account_id,
    JSON_VALUE(doc, '$.orders[0].symbol')                                AS ord0_symbol,
    JSON_VALUE(doc, '$.orders[0].exchange')                              AS ord0_exchange,
    JSON_VALUE(doc, '$.orders[0].side')                                  AS ord0_side,
    JSON_VALUE(doc, '$.orders[0].type')                                  AS ord0_type,
    JSON_VALUE(doc, '$.orders[0].status')                                AS ord0_status,
    JSON_VALUE(doc, '$.orders[0].quantity')                              AS ord0_quantity,
    JSON_VALUE(doc, '$.orders[0].filledQuantity')                        AS ord0_filled_qty,
    JSON_VALUE(doc, '$.orders[0].remainingQuantity')                     AS ord0_remaining_qty,
    JSON_VALUE(doc, '$.orders[0].limitPrice')                            AS ord0_limit_price,
    JSON_VALUE(doc, '$.orders[0].stopPrice')                             AS ord0_stop_price,
    JSON_VALUE(doc, '$.orders[0].trailingStopPercent')                   AS ord0_trailing_stop_pct,
    JSON_VALUE(doc, '$.orders[0].avgFillPrice')                          AS ord0_avg_fill_price,
    JSON_VALUE(doc, '$.orders[0].estimatedValue')                        AS ord0_estimated_value,
    JSON_VALUE(doc, '$.orders[0].commission')                            AS ord0_commission,
    JSON_VALUE(doc, '$.orders[0].timeInForce')                           AS ord0_time_in_force,
    JSON_VALUE(doc, '$.orders[0].isExtendedHours')                       AS ord0_extended_hours,
    JSON_VALUE(doc, '$.orders[0].notes')                                 AS ord0_notes,
    JSON_VALUE(doc, '$.orders[0].tags[0]')                               AS ord0_tag_0,
    JSON_VALUE(doc, '$.orders[0].tags[1]')                               AS ord0_tag_1,
    JSON_VALUE(doc, '$.orders[0].createdAt')                             AS ord0_created_at,
    JSON_VALUE(doc, '$.orders[0].updatedAt')                             AS ord0_updated_at,
    JSON_VALUE(doc, '$.orders[0].filledAt')                              AS ord0_filled_at,
    JSON_VALUE(doc, '$.orders[0].cancelledAt')                           AS ord0_cancelled_at,
    JSON_VALUE(doc, '$.orders[0].cancelReason')                          AS ord0_cancel_reason,
    -- orders[1] - TSLA filled market
    JSON_VALUE(doc, '$.orders[1].orderId')                               AS ord1_id,
    JSON_VALUE(doc, '$.orders[1].accountId')                             AS ord1_account_id,
    JSON_VALUE(doc, '$.orders[1].symbol')                                AS ord1_symbol,
    JSON_VALUE(doc, '$.orders[1].exchange')                              AS ord1_exchange,
    JSON_VALUE(doc, '$.orders[1].side')                                  AS ord1_side,
    JSON_VALUE(doc, '$.orders[1].type')                                  AS ord1_type,
    JSON_VALUE(doc, '$.orders[1].status')                                AS ord1_status,
    JSON_VALUE(doc, '$.orders[1].quantity')                              AS ord1_quantity,
    JSON_VALUE(doc, '$.orders[1].filledQuantity')                        AS ord1_filled_qty,
    JSON_VALUE(doc, '$.orders[1].remainingQuantity')                     AS ord1_remaining_qty,
    JSON_VALUE(doc, '$.orders[1].limitPrice')                            AS ord1_limit_price,
    JSON_VALUE(doc, '$.orders[1].stopPrice')                             AS ord1_stop_price,
    JSON_VALUE(doc, '$.orders[1].trailingStopPercent')                   AS ord1_trailing_stop_pct,
    JSON_VALUE(doc, '$.orders[1].avgFillPrice')                          AS ord1_avg_fill_price,
    JSON_VALUE(doc, '$.orders[1].estimatedValue')                        AS ord1_estimated_value,
    JSON_VALUE(doc, '$.orders[1].commission')                            AS ord1_commission,
    JSON_VALUE(doc, '$.orders[1].timeInForce')                           AS ord1_time_in_force,
    JSON_VALUE(doc, '$.orders[1].isExtendedHours')                       AS ord1_extended_hours,
    JSON_VALUE(doc, '$.orders[1].notes')                                 AS ord1_notes,
    JSON_VALUE(doc, '$.orders[1].tags[0]')                               AS ord1_tag_0,
    JSON_VALUE(doc, '$.orders[1].createdAt')                             AS ord1_created_at,
    JSON_VALUE(doc, '$.orders[1].updatedAt')                             AS ord1_updated_at,
    JSON_VALUE(doc, '$.orders[1].filledAt')                              AS ord1_filled_at,
    JSON_VALUE(doc, '$.orders[1].cancelledAt')                           AS ord1_cancelled_at,
    JSON_VALUE(doc, '$.orders[1].cancelReason')                          AS ord1_cancel_reason,
    -- watchlists[0] - AI & Semiconductors
    JSON_VALUE(doc, '$.watchlists[0].id')                                AS wl0_id,
    JSON_VALUE(doc, '$.watchlists[0].name')                              AS wl0_name,
    JSON_VALUE(doc, '$.watchlists[0].isDefault')                         AS wl0_is_default,
    JSON_VALUE(doc, '$.watchlists[0].symbols[0]')                        AS wl0_symbol_0,
    JSON_VALUE(doc, '$.watchlists[0].symbols[1]')                        AS wl0_symbol_1,
    JSON_VALUE(doc, '$.watchlists[0].symbols[2]')                        AS wl0_symbol_2,
    JSON_VALUE(doc, '$.watchlists[0].symbols[3]')                        AS wl0_symbol_3,
    JSON_VALUE(doc, '$.watchlists[0].symbols[4]')                        AS wl0_symbol_4,
    JSON_VALUE(doc, '$.watchlists[0].symbols[5]')                        AS wl0_symbol_5,
    JSON_VALUE(doc, '$.watchlists[0].symbols[6]')                        AS wl0_symbol_6,
    JSON_VALUE(doc, '$.watchlists[0].createdAt')                         AS wl0_created_at,
    -- watchlists[1] - Dividend Income
    JSON_VALUE(doc, '$.watchlists[1].id')                                AS wl1_id,
    JSON_VALUE(doc, '$.watchlists[1].name')                              AS wl1_name,
    JSON_VALUE(doc, '$.watchlists[1].isDefault')                         AS wl1_is_default,
    JSON_VALUE(doc, '$.watchlists[1].symbols[0]')                        AS wl1_symbol_0,
    JSON_VALUE(doc, '$.watchlists[1].symbols[1]')                        AS wl1_symbol_1,
    JSON_VALUE(doc, '$.watchlists[1].symbols[2]')                        AS wl1_symbol_2,
    JSON_VALUE(doc, '$.watchlists[1].symbols[3]')                        AS wl1_symbol_3,
    JSON_VALUE(doc, '$.watchlists[1].symbols[4]')                        AS wl1_symbol_4,
    JSON_VALUE(doc, '$.watchlists[1].symbols[5]')                        AS wl1_symbol_5,
    JSON_VALUE(doc, '$.watchlists[1].symbols[6]')                        AS wl1_symbol_6,
    JSON_VALUE(doc, '$.watchlists[1].createdAt')                         AS wl1_created_at,
    -- alerts[0] - NVDA price_below
    JSON_VALUE(doc, '$.alerts[0].alertId')                               AS alt0_id,
    JSON_VALUE(doc, '$.alerts[0].symbol')                                AS alt0_symbol,
    JSON_VALUE(doc, '$.alerts[0].condition')                             AS alt0_condition,
    JSON_VALUE(doc, '$.alerts[0].threshold')                             AS alt0_threshold,
    JSON_VALUE(doc, '$.alerts[0].currentValue')                          AS alt0_current_value,
    JSON_VALUE(doc, '$.alerts[0].isActive')                              AS alt0_is_active,
    JSON_VALUE(doc, '$.alerts[0].isTriggered')                           AS alt0_is_triggered,
    JSON_VALUE(doc, '$.alerts[0].triggeredAt')                           AS alt0_triggered_at,
    JSON_VALUE(doc, '$.alerts[0].notifyVia[0]')                          AS alt0_notify_0,
    JSON_VALUE(doc, '$.alerts[0].notifyVia[1]')                          AS alt0_notify_1,
    JSON_VALUE(doc, '$.alerts[0].message')                               AS alt0_message,
    JSON_VALUE(doc, '$.alerts[0].createdAt')                             AS alt0_created_at,
    -- alerts[1] - AAPL price_above
    JSON_VALUE(doc, '$.alerts[1].alertId')                               AS alt1_id,
    JSON_VALUE(doc, '$.alerts[1].symbol')                                AS alt1_symbol,
    JSON_VALUE(doc, '$.alerts[1].condition')                             AS alt1_condition,
    JSON_VALUE(doc, '$.alerts[1].threshold')                             AS alt1_threshold,
    JSON_VALUE(doc, '$.alerts[1].currentValue')                          AS alt1_current_value,
    JSON_VALUE(doc, '$.alerts[1].isActive')                              AS alt1_is_active,
    JSON_VALUE(doc, '$.alerts[1].isTriggered')                           AS alt1_is_triggered,
    JSON_VALUE(doc, '$.alerts[1].triggeredAt')                           AS alt1_triggered_at,
    JSON_VALUE(doc, '$.alerts[1].notifyVia[0]')                          AS alt1_notify_0,
    JSON_VALUE(doc, '$.alerts[1].message')                               AS alt1_message,
    JSON_VALUE(doc, '$.alerts[1].createdAt')                             AS alt1_created_at,
    -- marketData
    JSON_VALUE(doc, '$.marketData.asOf')                                 AS mkt_as_of,
    JSON_VALUE(doc, '$.marketData.sessionStatus')                        AS mkt_session_status,
    -- marketData.indices
    JSON_VALUE(doc, '$.marketData.indices.SPX.last')                     AS idx_spx_last,
    JSON_VALUE(doc, '$.marketData.indices.SPX.change')                   AS idx_spx_change,
    JSON_VALUE(doc, '$.marketData.indices.SPX.changePercent')            AS idx_spx_change_pct,
    JSON_VALUE(doc, '$.marketData.indices.SPX.ytdChangePercent')         AS idx_spx_ytd_pct,
    JSON_VALUE(doc, '$.marketData.indices.NDX.last')                     AS idx_ndx_last,
    JSON_VALUE(doc, '$.marketData.indices.NDX.change')                   AS idx_ndx_change,
    JSON_VALUE(doc, '$.marketData.indices.NDX.changePercent')            AS idx_ndx_change_pct,
    JSON_VALUE(doc, '$.marketData.indices.NDX.ytdChangePercent')         AS idx_ndx_ytd_pct,
    JSON_VALUE(doc, '$.marketData.indices.DJI.last')                     AS idx_dji_last,
    JSON_VALUE(doc, '$.marketData.indices.DJI.change')                   AS idx_dji_change,
    JSON_VALUE(doc, '$.marketData.indices.DJI.changePercent')            AS idx_dji_change_pct,
    JSON_VALUE(doc, '$.marketData.indices.DJI.ytdChangePercent')         AS idx_dji_ytd_pct,
    JSON_VALUE(doc, '$.marketData.indices.VIX.last')                     AS idx_vix_last,
    JSON_VALUE(doc, '$.marketData.indices.VIX.change')                   AS idx_vix_change,
    JSON_VALUE(doc, '$.marketData.indices.VIX.changePercent')            AS idx_vix_change_pct,
    JSON_VALUE(doc, '$.marketData.indices.VIX.ytdChangePercent')         AS idx_vix_ytd_pct,
    -- marketData.forex
    JSON_VALUE(doc, '$.marketData.forex.USDCAD')                         AS fx_usdcad,
    JSON_VALUE(doc, '$.marketData.forex.EURUSD')                         AS fx_eurusd,
    JSON_VALUE(doc, '$.marketData.forex.GBPUSD')                         AS fx_gbpusd,
    JSON_VALUE(doc, '$.marketData.forex.USDJPY')                         AS fx_usdjpy,
    -- marketData.commodities
    JSON_VALUE(doc, '$.marketData.commodities.goldUSDPerOz')             AS cmd_gold,
    JSON_VALUE(doc, '$.marketData.commodities.silverUSDPerOz')           AS cmd_silver,
    JSON_VALUE(doc, '$.marketData.commodities.crudeoilWTIUSD')           AS cmd_crude_oil,
    JSON_VALUE(doc, '$.marketData.commodities.naturalGasUSD')            AS cmd_natural_gas,
    -- marketData.treasury
    JSON_VALUE(doc, '$.marketData.treasury.yield2Y')                     AS tsy_yield_2y,
    JSON_VALUE(doc, '$.marketData.treasury.yield10Y')                    AS tsy_yield_10y,
    JSON_VALUE(doc, '$.marketData.treasury.yield30Y')                    AS tsy_yield_30y,
    JSON_VALUE(doc, '$.marketData.treasury.yieldCurveInverted')          AS tsy_yield_curve_inverted,
    -- auditLog[0] - LOGIN
    JSON_VALUE(doc, '$.auditLog[0].eventId')                             AS audit0_event_id,
    JSON_VALUE(doc, '$.auditLog[0].userId')                              AS audit0_user_id,
    JSON_VALUE(doc, '$.auditLog[0].action')                              AS audit0_action,
    JSON_VALUE(doc, '$.auditLog[0].ipAddress')                           AS audit0_ip_address,
    JSON_VALUE(doc, '$.auditLog[0].userAgent')                           AS audit0_user_agent,
    JSON_VALUE(doc, '$.auditLog[0].success')                             AS audit0_success,
    JSON_VALUE(doc, '$.auditLog[0].detail')                              AS audit0_detail,
    JSON_VALUE(doc, '$.auditLog[0].timestamp')                           AS audit0_timestamp,
    -- auditLog[1] - ORDER_PLACED
    JSON_VALUE(doc, '$.auditLog[1].eventId')                             AS audit1_event_id,
    JSON_VALUE(doc, '$.auditLog[1].userId')                              AS audit1_user_id,
    JSON_VALUE(doc, '$.auditLog[1].action')                              AS audit1_action,
    JSON_VALUE(doc, '$.auditLog[1].ipAddress')                           AS audit1_ip_address,
    JSON_VALUE(doc, '$.auditLog[1].userAgent')                           AS audit1_user_agent,
    JSON_VALUE(doc, '$.auditLog[1].success')                             AS audit1_success,
    JSON_VALUE(doc, '$.auditLog[1].detail.orderId')                      AS audit1_detail_order_id,
    JSON_VALUE(doc, '$.auditLog[1].detail.symbol')                       AS audit1_detail_symbol,
    JSON_VALUE(doc, '$.auditLog[1].detail.quantity')                     AS audit1_detail_quantity,
    JSON_VALUE(doc, '$.auditLog[1].detail.limitPrice')                   AS audit1_detail_limit_price,
    JSON_VALUE(doc, '$.auditLog[1].timestamp')                           AS audit1_timestamp,
    -- auditLog[2] - ALERT_CREATED
    JSON_VALUE(doc, '$.auditLog[2].eventId')                             AS audit2_event_id,
    JSON_VALUE(doc, '$.auditLog[2].userId')                              AS audit2_user_id,
    JSON_VALUE(doc, '$.auditLog[2].action')                              AS audit2_action,
    JSON_VALUE(doc, '$.auditLog[2].ipAddress')                           AS audit2_ip_address,
    JSON_VALUE(doc, '$.auditLog[2].userAgent')                           AS audit2_user_agent,
    JSON_VALUE(doc, '$.auditLog[2].success')                             AS audit2_success,
    JSON_VALUE(doc, '$.auditLog[2].detail.alertId')                      AS audit2_detail_alert_id,
    JSON_VALUE(doc, '$.auditLog[2].detail.symbol')                       AS audit2_detail_symbol,
    JSON_VALUE(doc, '$.auditLog[2].detail.condition')                    AS audit2_detail_condition,
    JSON_VALUE(doc, '$.auditLog[2].detail.threshold')                    AS audit2_detail_threshold,
    JSON_VALUE(doc, '$.auditLog[2].timestamp')                           AS audit2_timestamp
FROM trade_documents
WHERE id = 1;






-- ============================================================
-- Portfolio Performance Analytics  (TimesTen dialect)
--
-- Design rules to stay within TimesTen limitations:
--   1. Every JSON_TABLE CTE lists columns explicitly (no jt.*).
--   2. NO analytic/window functions inside any CTE.
--      All RANK / SUM OVER / AVG OVER / etc. appear only in
--      the final SELECT, applied to the fully-joined row set.
--   3. Intermediate CTEs reference only base JSON_TABLE CTEs
--      or pure GROUP BY / aggregate CTEs — never each other
--      through a window-function layer.
--   4. No scalar subqueries in the SELECT list.
--   5. Only the 10 TimesTen-supported analytic functions are
--      used: AVG, COUNT, DENSE_RANK, FIRST_VALUE, LAST_VALUE,
--      MAX, MIN, RANK, ROW_NUMBER, SUM.
-- ============================================================
WITH
    -- --------------------------------------------------------
    -- Base extractions via JSON_TABLE (explicit column lists)
    -- --------------------------------------------------------
    positions AS (
        SELECT
            jt.symbol,
            jt.exchange,
            jt.asset_class,
            jt.quantity,
            jt.avg_entry_price,
            jt.current_price,
            jt.market_value,
            jt.cost_basis,
            jt.unrealized_pnl,
            jt.unrealized_pnl_pct,
            jt.day_change_pct,
            jt.opened_at
        FROM trade_documents td,
             JSON_TABLE(td.doc, '$.portfolio.positions[*]' COLUMNS (
                 symbol             VARCHAR2(10) PATH '$.symbol',
                 exchange           VARCHAR2(10) PATH '$.exchange',
                 asset_class        VARCHAR2(20) PATH '$.assetClass',
                 quantity           NUMBER       PATH '$.quantity',
                 avg_entry_price    NUMBER       PATH '$.avgEntryPrice',
                 current_price      NUMBER       PATH '$.currentPrice',
                 market_value       NUMBER       PATH '$.marketValue',
                 cost_basis         NUMBER       PATH '$.costBasis',
                 unrealized_pnl     NUMBER       PATH '$.unrealizedPnL',
                 unrealized_pnl_pct NUMBER       PATH '$.unrealizedPnLPercent',
                 day_change_pct     NUMBER       PATH '$.dayChangePercent',
                 opened_at          VARCHAR2(30) PATH '$.openedAt'
             )) jt
        WHERE td.id = 1
    ),
    orders AS (
        SELECT
            jt.symbol,
            jt.side,
            jt.order_type,
            jt.status,
            jt.quantity,
            jt.est_value
        FROM trade_documents td,
             JSON_TABLE(td.doc, '$.orders[*]' COLUMNS (
                 symbol     VARCHAR2(10) PATH '$.symbol',
                 side       VARCHAR2(5)  PATH '$.side',
                 order_type VARCHAR2(10) PATH '$.type',
                 status     VARCHAR2(10) PATH '$.status',
                 quantity   NUMBER       PATH '$.quantity',
                 est_value  NUMBER       PATH '$.estimatedValue'
             )) jt
        WHERE td.id = 1
    ),
    fee_tiers AS (
        SELECT
            jt.tier,
            jt.monthly_volume,
            jt.maker_fee,
            jt.taker_fee
        FROM trade_documents td,
             JSON_TABLE(td.doc, '$.application.config.feeTiers[*]' COLUMNS (
                 tier           NUMBER PATH '$.tier',
                 monthly_volume NUMBER PATH '$.monthlyVolume',
                 maker_fee      NUMBER PATH '$.makerFee',
                 taker_fee      NUMBER PATH '$.takerFee'
             )) jt
        WHERE td.id = 1
    ),
    accounts AS (
        SELECT
            jt.account_id,
            jt.account_type,
            jt.balance,
            jt.total_deposited,
            jt.total_withdrawn,
            jt.realized_pnl,
            jt.margin_used
        FROM trade_documents td,
             JSON_TABLE(td.doc, '$.accounts[*]' COLUMNS (
                 account_id      VARCHAR2(20) PATH '$.id',
                 account_type    VARCHAR2(10) PATH '$.type',
                 balance         NUMBER       PATH '$.balance',
                 total_deposited NUMBER       PATH '$.totalDeposited',
                 total_withdrawn NUMBER       PATH '$.totalWithdrawn',
                 realized_pnl    NUMBER       PATH '$.totalRealizedPnL',
                 margin_used     NUMBER       PATH '$.marginUsed'
             )) jt
        WHERE td.id = 1
    ),

    -- --------------------------------------------------------
    -- Asset-class rollup: GROUP BY only, no window functions
    -- --------------------------------------------------------
    asset_class_summary AS (
        SELECT
            p.asset_class,
            COUNT(*)                                                    AS num_positions,
            SUM(p.market_value)                                         AS class_total_value,
            SUM(p.unrealized_pnl)                                       AS class_total_pnl,
            AVG(p.unrealized_pnl_pct)                                   AS class_avg_pnl_pct,
            SUM(p.day_change_pct * p.market_value) / SUM(p.market_value) AS class_wtd_day_chg_pct
        FROM positions p
        GROUP BY p.asset_class
    ),

    -- --------------------------------------------------------
    -- Single-row aggregates for CROSS JOIN
    -- --------------------------------------------------------
    account_totals AS (
        SELECT
            ROUND(SUM(a.balance),      2) AS combined_balance,
            ROUND(SUM(a.realized_pnl), 2) AS combined_realized_pnl
        FROM accounts a
    ),
    fee_summary AS (
        SELECT
            MIN(ft.taker_fee) AS best_taker_fee
        FROM fee_tiers ft
    ),

    -- --------------------------------------------------------
    -- Per-position fee tier: highest tier whose volume
    -- threshold the position's market value meets or exceeds.
    -- Joins only base CTEs (no window-function CTEs).
    -- --------------------------------------------------------
    applicable_tiers AS (
        SELECT
            p.symbol,
            MAX(ft.tier) AS applicable_fee_tier
        FROM positions p
        JOIN fee_tiers ft ON ft.monthly_volume <= p.market_value
        GROUP BY p.symbol
    ),
    fee_context AS (
        SELECT
            at2.symbol,
            at2.applicable_fee_tier,
            ft.taker_fee                     AS applicable_taker_fee,
            ft.taker_fee - ft_base.taker_fee AS taker_delta_vs_base
        FROM applicable_tiers at2
        JOIN fee_tiers ft      ON ft.tier      = at2.applicable_fee_tier
        JOIN fee_tiers ft_base ON ft_base.tier = 1
    ),

    -- --------------------------------------------------------
    -- First open order per symbol (LEFT JOIN target)
    -- --------------------------------------------------------
    open_orders AS (
        SELECT
            o.symbol,
            o.order_type || ' ' || o.side
                || ' x' || o.quantity
                || ' (~$' || o.est_value || ')' AS order_summary
        FROM orders o
        WHERE o.status = 'open'
    )

-- --------------------------------------------------------
-- Final result: one row per position, fully annotated.
-- All window/analytic functions are applied here, against
-- the joined row set, so no CTE references a window CTE.
-- --------------------------------------------------------
SELECT
    -- Position identity
    p.symbol,
    p.exchange,
    p.asset_class,

    -- Sizing and pricing
    p.quantity,
    p.avg_entry_price,
    p.current_price,
    ROUND(p.market_value,       2)  AS market_value,
    ROUND(p.cost_basis,         2)  AS cost_basis,

    -- P&L metrics
    ROUND(p.unrealized_pnl,     2)  AS unrealized_pnl,
    ROUND(p.unrealized_pnl_pct, 2)  AS unrealized_pnl_pct,
    ROUND(p.day_change_pct,     2)  AS day_change_pct,

    -- Window: rank positions across the portfolio
    RANK() OVER (ORDER BY p.unrealized_pnl     DESC)  AS pnl_rank,
    RANK() OVER (ORDER BY p.unrealized_pnl_pct DESC)  AS pnl_pct_rank,
    RANK() OVER (ORDER BY p.day_change_pct     DESC)  AS day_chg_rank,

    -- Window: running totals ordered by best absolute P&L first
    ROUND(SUM(p.market_value) OVER (
              ORDER BY p.unrealized_pnl DESC
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2)  AS running_mkt_value,
    ROUND(SUM(p.unrealized_pnl) OVER (
              ORDER BY p.unrealized_pnl DESC
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2)  AS running_pnl,

    -- Window: share of total portfolio value and P&L
    ROUND(p.market_value   / SUM(p.market_value)   OVER () * 100, 2) AS portfolio_weight_pct,
    ROUND(p.unrealized_pnl / SUM(p.unrealized_pnl) OVER () * 100, 2) AS pnl_contribution_pct,

    -- Window: alpha relative to portfolio average P&L%
    ROUND(AVG(p.unrealized_pnl_pct) OVER (), 2)                       AS portfolio_avg_pnl_pct,
    ROUND(p.unrealized_pnl_pct - AVG(p.unrealized_pnl_pct) OVER (), 2) AS alpha_vs_avg,
    CASE
        WHEN p.unrealized_pnl_pct >= AVG(p.unrealized_pnl_pct) OVER ()
        THEN 'Outperformer'
        ELSE 'Underperformer'
    END                                                                AS performance_tier,

    -- Asset-class context (pure GROUP BY CTE)
    acs.num_positions                     AS class_num_positions,
    ROUND(acs.class_total_value,      2)  AS class_total_value,
    ROUND(acs.class_total_pnl,        2)  AS class_total_pnl,
    ROUND(acs.class_avg_pnl_pct,      2)  AS class_avg_pnl_pct,
    ROUND(acs.class_wtd_day_chg_pct,  4)  AS class_wtd_day_chg_pct,

    -- Fee context (no window CTEs in the join chain)
    fc.applicable_fee_tier,
    ROUND(fc.applicable_taker_fee, 4)     AS applicable_taker_fee,
    ROUND(fc.taker_delta_vs_base,  4)     AS taker_fee_delta_vs_base,
    ROUND(fs.best_taker_fee,       4)     AS best_available_taker_fee,

    -- Open order for this symbol, if any
    oo.order_summary                      AS pending_order,

    -- Consolidated account standing (same on every row via CROSS JOIN)
    at2.combined_balance                  AS total_account_balance,
    at2.combined_realized_pnl             AS total_realized_pnl,

    p.opened_at

FROM positions p
JOIN  asset_class_summary acs ON acs.asset_class = p.asset_class
LEFT JOIN fee_context      fc  ON fc.symbol       = p.symbol
LEFT JOIN open_orders      oo  ON oo.symbol       = p.symbol
CROSS JOIN account_totals  at2
CROSS JOIN fee_summary     fs
ORDER BY p.unrealized_pnl DESC;



