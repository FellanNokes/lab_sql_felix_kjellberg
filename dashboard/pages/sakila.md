# Analytics for stakeholders


## Top 5 customers
<BarChart
    data={top_customer}
    title="Top spenders"
    x=customer
    y=total_spent
    swapXY=true
    labels=true
/>

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

## Total revenue by category
This is the total amount of revenue per category

```sql revenue_category
SELECT
    name as category,
    SUM(amount) as total_revenue,
FROM sakila.category_revenue
GROUP BY category
ORDER BY total_revenue DESC;
```

<BarChart
    data={revenue_category}
    title="Revenue by category"
    x=category
    y=total_revenue
    series=category
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
WHERE rental_date IS NOT NULL AND category LIKE '${inputs.category.value}'
GROUP BY all
ORDER BY revenue DESC;
```
<Dropdown data={revenue_category_month} name=category value=category>
    <DropdownOption value="%" valueLabel="All Categories"/>
</Dropdown>

<!-- <Dropdown name=year>
    <DropdownOption value=% valueLabel="All Years"/>
    <DropdownOption value=2019/>
    <DropdownOption value=2020/>
    <DropdownOption value=2021/>
</Dropdown> -->
<BarChart
    data={revenue_category_month}
    title="Revenue by category, {inputs.category.label}"
    x=month
    y=revenue
    series=category
    labels=true
    seriesLabels=false
    labelFmt="#### $"
/>