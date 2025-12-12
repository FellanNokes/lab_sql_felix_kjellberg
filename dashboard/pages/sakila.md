# Analytics for stakeholders


## Top 5 customers
<BarChart
    data={top_customer}
    title="Top spenders"
    x=customer
    y=total_spent
    swapXY=true
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
GROUP BY customer, email, address, postal_code, city, country, active
ORDER BY total_spent DESC
LIMIT 5;
```