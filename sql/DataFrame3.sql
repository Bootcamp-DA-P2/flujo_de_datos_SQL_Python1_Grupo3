 -- Autor: Irene Condado Alcantarilla
 --------------------------------------------------------------------------------------
 --  Dataframe 3: Elenco y popularidad
	-- Tablas: film, actor, film_actor
    -- Objetivo: analizar el elenco por película y frecuencia de aparición de actores.
--------------------------------------------------------------------------------------

DROP TABLE IF EXISTS elenco_final;
DROP TABLE IF EXISTS actores_unicos;
DROP TABLE IF EXISTS actores_limpios;

USE sakila;

show tables;

SELECT *
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id;

-- Limpieza ----------------------------------
-- Estandarizar nombres de actores (LOWER(first_name) y LOWER(last_name)).

CREATE TEMPORARY TABLE tmp_actores_limpios AS
SELECT 
    actor_id,
    LOWER(TRIM(first_name)) AS first_name,
    LOWER(TRIM(last_name)) AS last_name
FROM actor;

-- Eliminar actores duplicados (verificando combinaciones de nombre + apellido).

CREATE TEMPORARY TABLE tmp_actores_unicos AS
SELECT 
    MIN(actor_id) AS actor_id, -- Nos quedamos con un solo ID por nombre
    first_name,
    last_name,
    first_name || ' ' || last_name AS actor_full_name -- Creamos el nombre completo
FROM tmp_actores_limpios
GROUP BY first_name, last_name;

-- Asegurar que film.film_id y actor.actor_id existan (joins consistentes).
-- Filtrar películas sin actores asociados.
CREATE TEMPORARY TABLE tmp_elenco_final AS
SELECT 
    f.film_id,
    f.title,
    au.actor_id,
    au.actor_full_name
FROM film f
INNER JOIN film_actor fa ON f.film_id = fa.film_id
INNER JOIN tmp_actores_unicos au ON fa.actor_id = au.actor_id;

