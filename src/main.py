from sqlalchemy import create_engine, text
from config import *
import pandas as pd
import os

# Create a database connection
def conection_bd():
    """Establece conexión con la base de datos Sakila"""
    # 1. Construir la URL de conexión completa
    url_db = f"mysql+mysqlconnector://{DB_USER}:{DB_PASSWORD}@{DB_HOST}/{DB_NAME}"
    # 2. Crear el objeto 'motor' (engine) usando la URL
    engine = create_engine(url_db)
    return engine.connect()

def test_connection():
    """Probar la conexión a la base de datos"""
    connection = conection_bd()
    try:
        with connection:
            print("✅ Conexión exitosa a Sakila.")
            # Probamos con la tabla film que siempre existe
            result = connection.execute(text("SELECT * FROM film;"))
            print(result.fetchone())

    except Exception as e:
        print(f"❌ Error al conectar a la base de datos: {e}")
        

# 3. Función principal para extraer el Dataframe Elegido: DataFrame1
def get_data_list_from_join():
    """Obtener datos DA"""
    connection = conection_bd()
    with connection:
        join_query_sql = """ SELECT 
                c.customer_id,
                c.first_name,
                c.last_name,
                c.email,
                a.address,
                ci.city,
                co.country,
                r.rental_id,
                r.rental_date,
                r.return_date,
                p.payment_id,
                p.amount
            FROM customer AS c
            JOIN address AS a ON c.address_id = a.address_id
            JOIN city AS ci ON a.city_id = ci.city_id
            JOIN country AS co ON ci.country_id = co.country_id
            JOIN rental AS r ON c.customer_id = r.customer_id
            JOIN payment AS p ON r.rental_id = p.rental_id; """

        # Ejecutar la consulta y capturar datos
        result = connection.execute(text(join_query_sql))
        rows = result.fetchall()
        columns = result.keys()

            # 2. Create the Pandas DataFrame
        df = pd.DataFrame(rows, columns=columns)

            # --- EXPORTAR A CSV ---
            # Verificamos si existe la carpeta 'data', si no, la creamos
        if not os.path.exists('data'):
            os.makedirs('data')
            
            # --- 3. EXPORTAR A CSV (Paso Nuevo) ---
        file_path = "data/DataFrame1.csv"
        df.to_csv(file_path, index=False, encoding='utf-8')

        print(f"✅ DataFrame creado con éxito y guardado en: {file_path}")
        print(f"📈 Total de registros: {len(df)}")

        return df
        
# 4. Bloque de ejecución
if __name__ == "__main__":
    test_connection()           # Paso 1: Validar conexión
    get_data_list_from_join()   # Paso 2: Extraer y guardar