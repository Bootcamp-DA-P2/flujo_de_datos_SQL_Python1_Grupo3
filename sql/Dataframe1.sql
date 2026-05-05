SELECT
c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.active,
    a.address,
    a.district,
    a.postal_code
FROM customer c
JOIN address a ON c.address_id = a.address_id;

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.active,
    a.address,
    a.district,
    a.postal_code,
    ci.city,
    co.country
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.active,
    a.address,
    a.district,
    a.postal_code,
    ci.city,
    co.country,
    r.rental_date,
    r.return_date
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
JOIN rental r ON c.customer_id = r.customer_id;

CREATE VIEW vista_customer_activity AS
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.active,
    a.address,
    a.district,
    a.postal_code,
    ci.city,
    co.country,
    r.rental_date,
    r.return_date,
     p.amount,
    p.payment_date
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON p.rental_id = r.rental_id;

-- Eliminar registros con rental_id o payment_id nulos.

DELETE FROM rental 
WHERE rental_id IN (
    SELECT rental_id FROM (
        SELECT rental_id FROM rental WHERE return_date IS NULL
    ) AS temp
);

-- Asegurar que amount > 0 en payment.

SELECT * FROM payment WHERE amount <= 0;

-- Filtrar registros donde rental.return_date no sea nula (alquiler completado).

SELECT * 
FROM rental
WHERE return_date IS NOT NULL;

-- Estandarizar textos: nombres, apellidos, emails, ciudades → LOWER()

SELECT 
    customer_id, 
    LOWER(first_name) AS first_name,
    LOWER(last_name) AS last_name,
    LOWER(email) AS email,
    LOWER(city) AS city,
    LOWER(country) AS country
FROM vista_customer_activity  
LIMIT 50000;

-- Asegurar consistencia de fechas (rental_date < return_date).

-- Eliminar registros inconsistentes (con truco de PK para evitar modo seguro)
DELETE FROM rental 
WHERE return_date <= rental_date 
AND rental_id > 0;

ALTER TABLE rental
ADD CONSTRAINT chk_rental_dates
CHECK (return_date > rental_date);
