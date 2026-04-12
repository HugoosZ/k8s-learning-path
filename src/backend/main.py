import os
import psycopg2
from flask import Flask 

# Librerias de monitoreo
from prometheus_client import make_wsgi_app, Counter # Counter es literal un contador
# make_wsgi_app es un servidor que responde con metricas en texto para prometheus
from werkzeug.middleware.dispatcher import DispatcherMiddleware # Un segmentador de trafico. Si declaramos una ruta con este metodo, flask lo ignorará.

app = Flask(__name__)

REQUEST_COUNT = Counter('backend_requests_total', 'Total de peticiones al backend')

@app.route('/') 
def test_db():
    REQUEST_COUNT.inc()

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
        return "<h1>Conexión exitosa a la DB desde el Backend</h1>"
    except Exception as e:
        return f"<h1>Error de conexión: {e}</h1>", 500


app.wsgi_app = DispatcherMiddleware(app.wsgi_app, {
    '/metrics': make_wsgi_app()
})

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)