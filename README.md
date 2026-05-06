
#  Proyecto: Flujo de datos de SQL a Python (Sakila)
Proyecto que trata sobre conectar python con base de datos SQL.

---

## Autores
### Proyecto 3 - Grupo 3
- Rita Isabel Romero Ruiz  
- Marco Ohimai Imouokhome 
- Irene Condado Alcantarilla 

---

## Descripción
Este proyecto consiste en extraer, limpiar y analizar datos de la base de datos **Sakila**, siguiendo un flujo completo de trabajo desde SQL hasta Python.

Se generan varios dataframes mediante consultas SQL, se selecciona uno para limpieza, y posteriormente se analiza en **Google Colab**.

---

## Flujo del proyecto

1. Preparación del entorno  
2. Extracción de datos en SQL  
3. Limpieza de datos en SQL  
4. Exportación del dataset  
5. Procesamiento en Python (Colab)  
6. Visualización y análisis  

---

## Preparación del entorno

### Base de datos 
- Importación de la base de datos **Sakila**  
- Exploración de tablas y relaciones  


### Extracción de datos en SQL

Se generaron tres dataframes mediante JOIN:

- Dataframe 1: Actividad de clientes ✅ (seleccionado)
customer, address, city, country, rental, payment

- Dataframe 2: Catálogo de películas
film, film_category, category, language, inventory

- Dataframe 3: Elenco y popularidad
film, actor, film_actor

### Limpieza en SQL (Dataframe seleccionado)

Se trabajó con Dataframe 1: Actividad de clientes

- Reglas aplicadas:
Eliminación de registros con rental_id o payment_id nulos
Filtrado de pagos (amount > 0)
Solo alquileres completados (return_date IS NOT NULL)
Validación de fechas (rental_date < return_date)
Normalización de texto (LOWER(), TRIM())
Joins consistentes evitando duplicados

- Columna derivada:
DATEDIFF(return_date, rental_date) AS rental_duration

### Exportación de datos

El dataset limpio se exporta desde la base de datos SQL a un archivo en formato CSV.

Para generar el archivo, ejecuta el script principal del proyecto:

```bash
python main.py
```

Una vez ejecutado, el archivo resultante se guardará automáticamente en la carpeta data/.
Para su uso posterior en Python.

### Procesamiento en Google Colab

- Pasos realizados:

### Python / Análisis
- Uso de **Google Colab**
- Librerías principales:

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

Carga del dataset:

df = pd.read_csv('Dataframe1.csv')
```

Procesamiento:

Conversión de fechas a datetime
Revisión y eliminación de duplicados
Tratamiento de valores nulos
Corrección de tipos de datos
Normalización de strings

### Visualización de datos en Colab

Se realizaron gráficos para explorar y validar los datos.

- Histogramas

Distribución de variables numéricas:

df['rental_duration'].hist()
plt.title('Distribución de duración de alquiler')
plt.show()

- Boxplots

Detección de outliers:

sns.boxplot(x=df['amount'])
plt.title('Outliers en pagos')
plt.show()

- Gráficos de barras

Análisis de variables categóricas:

df['city'].value_counts().head(10).plot(kind='bar')
plt.title('Top ciudades')
plt.show()

- Scatter plots

Relaciones entre variables:

plt.scatter(df['rental_duration'], df['amount'])
plt.xlabel('Duración')
plt.ylabel('Pago')
plt.show()

### Objetivo de las visualizaciones
Validar la calidad de los datos tras la limpieza
Detectar patrones de comportamiento
Identificar outliers o anomalías
Apoyar el análisis exploratorio (EDA)

### Decisiones del proyecto
Se seleccionó el Dataframe 1 por su valor analítico (clientes + pagos)
Se realizó limpieza inicial en SQL para reducir ruido
Se completó la limpieza en Python para mayor control
Se priorizó la integridad de los datos en los joins

### Tecnologías utilizadas
MySQL / Workbench
Python (Pandas, NumPy, Matplotlib, Seaborn)
Google Colab
GitHub

´´´
📦 Estructura del repositorio
├── data/
├── notebooks/
├────── Dataframe_final.ipynb
├── sql/
├────── DataFrame2.sql
├────── DataFrame3.sql
├────── Dataframe1.sql
├── src/
├────── config.py
├────── main.py
├── .env_example
├── .gitignore
├── LICENSE
├── README.md
├── requirements.txt
´´´


### Cómo ejecutar el proyecto

Clonar el repositorio:
```
git clone https://github.com/Bootcamp-DA-P2/flujo_de_datos_SQL_Python1_Grupo3.git
```

Ejecutar las queries SQL
Exportar el dataset limpio
Abrir el notebook en Google Colab
Ejecutar las celdas en orden

### Notas finales

Este proyecto permite aplicar un flujo completo de trabajo en análisis de datos, desde la extracción en SQL hasta la exploración y visualización en Python, generando un dataset limpio y preparado para futuras fases analíticas.
