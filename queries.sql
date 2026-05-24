-- ==============================================================================
-- EV Station Performance Analytics - Core Analytical Queries
-- Database Engine: MySQL (Local Server Setup)
-- Dataset: 1,000 Transactonal Records (Relational Star Schema)
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- QUERY 1: Peak Demand Windows (Monthly Day-by-Day)
-- Objective: Identify monthly volume fluctuations to align logistics, battery
--            charging cycles, and subscription payout timelines.
-- ------------------------------------------------------------------------------
SELECT 
  DAYOFMONTH(swap_timestamp) AS day_of_month,
  COUNT(transaction_id) AS total_swaps,
  ROUND(SUM(fee_paid), 2) AS total_revenue
FROM 
  transactions
GROUP BY 
  day_of_month
ORDER BY 
  day_of_month ASC;


-- ------------------------------------------------------------------------------
-- QUERY 2: Station Utilization Rates & Revenue Generation
-- Objective: Measure individual station throughput performance against physical 
--            slot capacity over a standard 30-day operational cycle.
-- ------------------------------------------------------------------------------
SELECT 
  s.station_name,
  s.total_slots,
  COUNT(t.transaction_id) AS total_swaps,
  -- Calculates average swaps per physical slot per day over the 30-day pilot
  ROUND(COUNT(t.transaction_id) / s.total_slots / 30, 2) AS daily_swaps_per_slot,
  ROUND(SUM(t.fee_paid), 2) AS total_revenue
FROM 
  transactions t
JOIN 
  stations s ON t.station_id = s.station_id
GROUP BY 
  s.station_name, 
  s.total_slots
ORDER BY 
  daily_swaps_per_slot DESC;


-- ------------------------------------------------------------------------------
-- QUERY 3: High-Risk Asset Identification (Maintenance Bottlenecks)
-- Objective: Proactively flag heavily degraded batteries (Health below 75%) 
--            that are actively rotating through high-traffic operations.
-- ------------------------------------------------------------------------------
SELECT 
  b.battery_id,
  b.health_pct,
  b.total_cycles,
  COUNT(t.transaction_id) AS swaps_this_month
FROM 
  batteries b
JOIN 
  transactions t ON b.battery_id = t.battery_id
WHERE 
  b.health_pct < 75
GROUP BY 
  b.battery_id, 
  b.health_pct, 
  b.total_cycles
HAVING 
  COUNT(t.transaction_id) > 5
ORDER BY 
  b.health_pct ASC;
