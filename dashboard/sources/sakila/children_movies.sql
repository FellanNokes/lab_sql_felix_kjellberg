SELECT
    f.title,
    f.rating,
    c.name,
FROM staging.film f 
LEFT JOIN staging.film_category fc ON f.film_id = fc.film_id
LEFT JOIN staging.category c ON fc.category_id = c.category_id