import os
import psycopg2
from flask import Flask 

app = Flask(__name__)

@app.route('/') 
def test_db():
    db_host = os.getenv('DB_HOST')
    db_pass = os.getenv('DB_PASSWORD')
    
    try:
        conn = psycopg2.connect(
            host=db_host, 
            password=db_pass, 
            user="postgres", 
            dbname="postgres",
            connect_timeout=5 # Para que no se quede pegado si falla
        )
        return "<h1>Conexión exitosa a la DB desde el Backend!</h1>"
    except Exception as e:
        return f"<h1>Error de conexión: {e}</h1>", 500

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)