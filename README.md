# EV Station Performance Analytics ⚡🔋

## Project Overview
This project simulates real-world business intelligence reporting for an electric vehicle (EV) battery swapping startup. Working with a relational dataset of 1,000 transactions, I mapped operations across physical swap stations and battery health lifecycle metrics to identify critical throughput bottlenecks and maximize asset utilization.

## Tech Stack
* **Database Engine:** MySQL (Local Server Setup)
* **Analytics Platform:** Tableau Public (macOS Native)
* **Data Synthesis:** Mockaroo

## Database Schema & Architecture
The project utilizes a 3-table relational star schema optimized for rapid analytical querying:
* `stations`: Metadata for location capacity (`station_id`, `station_name`, `total_slots`)
* `batteries`: Lifecycle and health tracking data (`battery_id`, `purchase_date`, `health_pct`, `total_cycles`)
* `transactions`: Fact table recording operational events (`transaction_id`, `station_id`, `battery_id`, `swap_timestamp`, `fee_paid`)

## Key Insights Uncovered
* **Peak Demand Windows (Monthly Day-by-Day):** Aggregating transactional history across the days of the month revealed distinct behavioral cycles. Swapping volume exhibits sharp spikes during the first week of the month and around mid-month milestones, aligning directly with user subscription renewals and local commercial payout cycles.
* **Underutilized Infrastructure:** Cross-referencing transaction frequency against station hardware sizes identified that certain stations maintained high slot capacities but operated at low daily utilization rates, presenting a clear optimization opportunity to redeploy assets to higher-demand zones.

## Dashboard Preview
![Executive Dashboard Preview](dashboard_preview.png)

## How to Run the Queries
1. Import the source CSV tables located in this repository into your local MySQL schema.
2. Execute the optimized analytical scripts found in `queries.sql` to generate the raw operational performance metrics.
## Dataset Availability
The 1,000-row synthetic relational dataset used to power this project is included directly in this repository:
* `dataset_stations.csv` (Station dimension data)
* `dataset_batteries.csv` (Battery asset dimension data)
* `dataset_transactions.csv` (Core transaction fact data)
