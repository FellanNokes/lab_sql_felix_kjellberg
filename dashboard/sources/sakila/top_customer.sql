SELECT
    r.rental_id,
    r.rental_date,
    r.return_date,
    p.amount,
    p.payment_date,
    c.first_name || ' ' || c.last_name AS customer,
    c.email,
    c.active,
    a.address,
    a.postal_code,
    ci.city,
    co.country
FROM staging.rental r
LEFT JOIN staging.payment p ON r.rental_id = p.rental_id
LEFT JOIN staging.customer c ON p.customer_id = c.customer_id
LEFT JOIN staging.address a ON c.address_id = a.address_id
LEFT JOIN staging.city ci ON a.city_id = ci.city_id
LEFT JOIN staging.country co ON ci.country_id = co.country_id;