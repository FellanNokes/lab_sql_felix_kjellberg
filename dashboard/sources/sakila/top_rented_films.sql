SELECT
    f.title,
    f.rental_rate,
    f.rental_duration,
    c.name,
    p.amount,
    r.rental_date
FROM staging.film f 
LEFT JOIN staging.film_category fc ON f.film_id = fc.film_id
LEFT JOIN staging.category c ON fc.category_id = c.category_id
LEFT JOIN staging.inventory i ON f.film_id = i.film_id
LEFT JOIN staging.rental r ON i.inventory_id = r.inventory_id
LEFT JOIN staging.payment p ON r.rental_id = p.rental_id;