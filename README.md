# E-commerce Funnel & User Behavior Analysis (SQL)

## Objective
To analyze user behavior across an e-commerce platform and identify drop-offs, conversion rates, and retention patterns using SQL.

---

## Dataset
- Source: Online Retail Dataset
- Rows: ~541,909 transactions
- Columns:
  InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country

---

## Funnel Definition
User journey modeled as:
View → Purchase → Repeat Purchase

---

## Key Metrics

- Total Users: 4,373
- First-Time Buyers: 4,373
- Repeat Users: 3,060
- Retention Rate: 69.97%
- Drop-offs: 1,313 users
- Avg Time to Second Purchase: 191.17 days

---

## Customer Segmentation

- High Value: 2,540 users
- Medium Value: 1,618 users
- Low Value: 215 users

---

## Cohort Analysis

User retention trend (monthly cohorts):
949, 421, 380, 440, 299, 279, 235, 191, 167, 298, 352, 321, 41

---

## Revenue Insights

- Repeat User Revenue: 9,313,963

---

## Key Insights

- Around 30% of users do not return after first purchase
- High-value customers contribute the majority of revenue
- Significant drop-off occurs after first purchase
- Retention declines steadily across cohorts
- Repeat purchases take a long time (191 days on average)

---

## Recommendations

- Improve onboarding and first purchase experience
- Introduce retention strategies like offers and reminders
- Target high-value users with personalized campaigns
- Reduce time to repeat purchase through engagement strategies
- Optimize post-purchase journey to increase retention

---

## Tools Used

- MySQL
- SQL (Aggregation, Joins, Cohort Analysis)

## Dataset

Due to file size limitations, the dataset is not uploaded here.

Dataset used: Online Retail II (UCI)

Source:
https://www.kaggle.com/datasets/ulrikthygepedersen/online-retail-dataset