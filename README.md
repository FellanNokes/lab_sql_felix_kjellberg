# Sql lab Felix Kjellberg

## 📘 Analysis (`analysis.ipynb`)

The analysis notebook performs an exploratory data analysis (EDA) of the **Sakila DVD rental database** using **DuckDB**, **SQL**, and **pandas**. The database is first loaded into a dictionary of pandas DataFrames to allow flexible querying and analysis directly from Python.

### Task 1 — Exploratory Data Analysis

The EDA focuses on understanding the film catalog, actors, rentals, and customer behavior:

- **Film characteristics**
  - Identified all movies longer than 3 hours (180 minutes).
  - Searched for films containing the word *“LOVE”* in the title using regular expressions.
  - Computed descriptive statistics for movie length, including shortest, average, median, and longest films.
  - Calculated rental cost per day to identify the most expensive movies to rent.
  - Finding the average ratings in different categories.

- **Actors and films**
  - Determined the top 10 actors based on the number of films they have appeared in.
  - Analyzed average film length per actor to identify which actors appear in the longest films on average.

- **Custom exploration**
  - Compared film categories by **average MPAA rating** (numerically encoded) and **average film length**.
  - Identified the **top 5 most rented films** across the entire catalog.

All analysis is performed using SQL queries executed through DuckDB, with results returned as pandas DataFrames for inspection.

### Task 2 — Visual Analysis

Two business-focused visualizations were created using pandas and Matplotlib:

- **Top 5 customers by total spending**, highlighting high-value customers for potential rewards.
- **Total revenue per film category**, showing which genres generate the most income for the rental store.

The visualizations are kept minimal and readable, with annotated values to clearly communicate results.

## 📊 Dashboard (`dashboard/pages/index.md`)

The dashboard extends the exploratory analysis by focusing on **business- and stakeholder-oriented insights**. It is designed to support decision-making by management through aggregated metrics, rankings, and category-level monitoring.

### Top Rented Movies

Two complementary views are provided to highlight film performance:

- **Most rented films by volume**, showing which movies are rented out most frequently.
- **Top rented films by total revenue**, combining rental frequency with rental price and rental duration.

These views help distinguish between films that are popular and those that generate the most revenue.

### Top 5 Customers

The dashboard identifies the **top 5 customers by total spending**, including:

- Total amount spent
- Contact information (email and address)
- Location details (city, country, and postal code)
- Customer activity status

This information enables targeted marketing actions such as loyalty rewards and personalized offers.

### Revenue by Category

Category-level revenue is analyzed in two ways:

- **Total revenue per film category**, showing which genres generate the most income overall.
- **Monthly revenue per category**, allowing stakeholders to observe trends over time by selecting a category interactively.

These insights support strategic decisions related to inventory management, promotions, and content focus.

### Children’s Movies Content Review

A dedicated section highlights a potential **content classification issue**:

- Lists children’s movies rated **PG-13, R, and NC-17**.
- Summarizes the distribution of movie ratings within the *Children* category, grouped into:
  - *Safe*
  - *Caution*
  - *Restricted*

This analysis helps identify movies that may require further review or reclassification.

### Dashboard Purpose

The dashboard complements the analysis notebook by translating technical findings into **clear and actionable insights**. While the notebook emphasizes methodology and exploration, the dashboard focuses on **presentation, prioritization, and business relevance** for non-technical stakeholders.
