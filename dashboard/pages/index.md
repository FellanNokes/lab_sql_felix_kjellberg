# Analytics for stakeholders

This dashboard is a deepdive in some of the analytics that I was tasked to do with some of my own findings.

## Subject 1: Top rented movies

```sql top_rented_films_amount
SELECT
    title,
    COUNT(rental_date) as times_rented,
    SUM(amount) as total_revenue
FROM sakila.top_rented_films
GROUP BY title
ORDER BY
    times_rented DESC,
    total_revenue DESC
LIMIT 5;
```

The rop rented movies by the amount of times it has been rented out.

<BarChart
    data={top_rented_films_amount}
    title="Movies times rented amount"
    x=title
    y=times_rented
    swapXY=true
    labels=true
    xAxisLabels="Movie title"
    yAxisLabels="Times rented"
/>

### Revenue

```sql top_rented_films_revenue
SELECT
    title,
    name AS category,
    rental_rate AS rental_cost,
    COUNT(rental_date) AS times_rented,
    COUNT(rental_date) * rental_rate AS rent_revenue
FROM sakila.top_rented_films
GROUP BY
    title,
    name,
    rental_rate
ORDER BY
    rent_revenue DESC,
    times_rented DESC
LIMIT 5;
```

Top rented movies by means of only rental cost, penalty fees exluded.

<BarChart
    data={top_rented_films_revenue}
    title="Movies revenue amount, penalty fees exluded"
    x=title
    y=rent_revenue
    swapXY=true
    labels=true
    xAxisLabels="Movie title"
    yAxisLabels="Revenue amount"
    labelFmt="#### $"
/>

```sql top_rented
SELECT
    title,
    name as category,
    rental_rate AS rental_cost,
    COUNT(rental_date) AS times_rented,
    SUM(amount) AS total_revenue
FROM sakila.top_rented_films
GROUP BY
    title,
    name,
    rental_rate
ORDER BY
    total_revenue DESC,
    times_rented DESC
LIMIT 5;
```

Top rented movies by the amount of total revenue, pentalty fees included.

<BarChart
    data={top_rented}
    title="Movies total revenue amount, penalty fees included"
    x=title
    y=total_revenue
    swapXY=true
    labels=true
    xAxisLabels="Movie title"
    yAxisLabels="Revenue amount"
    labelFmt="#### $"
/>

```sql top_movies_late_fee
SELECT
    title,
    COUNT(rental_date) AS times_rented,
    rental_rate,
    COUNT(rental_date) * rental_rate AS expected_revenue,
    SUM(amount) AS actual_revenue,
    SUM(amount) - COUNT(rental_date) * rental_rate AS late_fee_revenue
FROM sakila.top_rented_films
WHERE title IN ('TELEGRAPH VOYAGE', 'WIFE TURN', 'ZORRO ARK', 'GOODFELLAS SALUTE', 'SATURDAY LAMBS')
GROUP BY
    title,
    rental_rate
ORDER BY late_fee_revenue DESC;
```

### Penalty fees

Top movies penalty fee amount only

<BarChart
    data={top_movies_late_fee}
    title="Top movies penalty fee amount"
    x=title
    y=late_fee_revenue
    swapXY=true
    labels=true
    xAxisLabels="Movie title"
    yAxisLabels="Revenue amount"
    labelFmt="#### $"
/>

```sql top_late_fee
SELECT
    title,
    COUNT(rental_date) AS times_rented,
    rental_rate,
    COUNT(rental_date) * rental_rate AS expected_revenue,
    SUM(amount) AS actual_revenue,
    SUM(amount) - COUNT(rental_date) * rental_rate AS late_fee_revenue
FROM sakila.top_rented_films
GROUP BY 
    title, 
    rental_rate
ORDER BY late_fee_revenue DESC
LIMIT 5;
```

Top rented movies by the amount of penalty fees.

<BarChart
    data={top_late_fee}
    title="Movies penalty fee amount"
    x=title
    y=late_fee_revenue
    swapXY=true
    labels=true
    xAxisLabels="Movie title"
    yAxisLabels="Revenue amount"
    labelFmt="#### $"
/>

## Subject 2: Top 5 customers

Addresses for each customer so we know where to contact each winner

```sql top_customer
SELECT
    customer,
    SUM(amount) AS total_spent,
    email,
    address,
    postal_code,
    city,
    country,
    active
FROM sakila.top_customer
GROUP BY all
ORDER BY total_spent DESC
LIMIT 5;
```

<BarChart
    data={top_customer}
    title="Top spenders"
    x=customer
    y=total_spent
    swapXY=true
    labels=true
    labelFmt="#### $"
/>

## Subject 3: Total revenue by category

```sql revenue_category
SELECT
    name as category,
    SUM(amount) as total_revenue,
FROM sakila.category_revenue
GROUP BY category
ORDER BY total_revenue DESC;
```

Total amount of revenue per category

<BarChart
    data={revenue_category}
    title="Revenue by category"
    x=category
    y=total_revenue
    swapXY=true
    labels=true
    labelFmt="#### $"
/>

```sql revenue_category_month
SELECT
    name as category,
    SUM(amount) as revenue,
    date_trunc('month', rental_date) as month
FROM sakila.category_revenue
WHERE rental_date IS NOT null AND name LIKE '${inputs.category.value}'
GROUP BY all
ORDER BY revenue DESC;
```

Select a category to se how much revenue it brings in per month

<Dropdown data={revenue_category_month} name=category value=category>
    <DropdownOption value="%" valueLabel="All Categories"/>
</Dropdown>

<LineChart
    data={revenue_category_month}
    title="Revenue by category, {inputs.category.label}"
    x=month
    y=revenue
    series=category
    handleMissing=connect
    markers=true
/>

## Subject 4: Children movies that are rated R and NC-17

List of all the childrens movies rated PG-13, R and NC-17 this is very concering and maybe we should look through this list to see if they belong in a different category

```sql children_category_ratings
SELECT
    title,
    rating,
    name AS category,
FROM sakila.children_movies
WHERE category = 'Children' AND rating IN ('PG-13', 'R', 'NC-17');
```

```sql children_category_ratings_amount
SELECT
    rating,
    COUNT(*) as number_rating,
    CASE
        WHEN rating IN ('G', 'PG') THEN 'Safe'
        WHEN rating = 'PG-13' THEN 'Caution'
        WHEN rating IN ('R', 'NC-17') THEN 'Restricted'
    END AS rating_group
FROM sakila.children_movies
WHERE name = 'Children'
GROUP BY rating
ORDER BY
    CASE rating
        WHEN 'G' THEN 1
        WHEN 'PG' THEN 2
        WHEN 'PG-13' THEN 3
        WHEN 'R' THEN 4
        WHEN 'NC-17' THEN 5
    END;
```

How many children movies there are in every different rating, this is very concering

<BarChart 
    data={children_category_ratings_amount} 
    x=rating
    y=number_rating
    swapXY=true
    labels=true
    sort=false
/>
