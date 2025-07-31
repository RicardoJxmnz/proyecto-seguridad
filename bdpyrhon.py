import numpy as np
import pyodbc

# Ejemplo: vector de 128 dimensiones
embedding = np.random.rand(128).astype(np.float32)

# Serializar a bytes
embedding_bytes = embedding.tobytes()


conn = pyodbc.connect(
    "DRIVER={ODBC Driver 18 for SQL Server};"
    "SERVER=RICARDO;"  # Usa el nombre exacto de tu servidor
    "DATABASE=SucursalesMVC;"
    "Trusted_Connection=yes;"
    "Encrypt=yes;"
    "TrustServerCertificate=yes;"
)

cursor = conn.cursor()

# Crear tabla si no existe
cursor.execute("""
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Embeddings' AND xtype='U')
CREATE TABLE Embeddings (
    id INT PRIMARY KEY IDENTITY,
    nombre NVARCHAR(100),
    embedding VARBINARY(MAX),
    imagen VARBINARY(MAX)
)
""")
conn.commit()
