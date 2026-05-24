{\rtf1\ansi\ansicpg1252\cocoartf2868
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww29200\viewh18460\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 \'97 Query to identify peak swapping volume by Day of the Month (1-30)\
SELECT \
  DAYOFMONTH(swap_timestamp) AS day_of_month,\
  COUNT(transaction_id) AS total_swaps,\
  ROUND(SUM(fee_paid), 2) AS total_revenue\
FROM transactions\
GROUP BY day_of_month\
ORDER BY day_of_month ASC; \
\'97 STATION UTILIZATION RATES\
SELECT \
  s.station_name,\
  s.total_slots,\
  COUNT(t.transaction_id) AS total_swaps,\
  ROUND(COUNT(t.transaction_id) / s.total_slots / 30, 2) AS daily_swaps_per_slot,\
  ROUND(SUM(t.fee_paid), 2) AS total_revenue\
FROM transactions t\
JOIN stations s ON t.station_id = s.station_id\
GROUP BY s.station_name, s.total_slots\
ORDER BY daily_swaps_per_slot DESC;\
\
\'97 LOW HEALTH BATTERIES IN HIGH USAGE ROTATION\
SELECT \
  b.battery_id,\
  b.health_pct,\
  b.total_cycles,\
  COUNT(t.transaction_id) AS swaps_in_past_month\
FROM \
  batteries b\
JOIN \
  transactions t ON b.battery_id = t.battery_id\
WHERE \
  b.health_pct < 75\
GROUP BY \
  b.battery_id, b.health_pct, b.total_cycles\
HAVING \
  COUNT(t.transaction_id) > 10\
ORDER BY \
  b.health_pct ASC;}