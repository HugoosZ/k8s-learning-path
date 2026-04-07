FROM python:3.9-slim

# directorio dentro del contenedor
WORKDIR /app


# flask: para el servidor web
# psycopg2-binary: para conectar a Postgres sin dramas
RUN pip install --no-cache-dir flask psycopg2-binary

# main.py en el contenedor
COPY main.py .

# puerto 5000 (el que usa Flask)
EXPOSE 5000

# 6. Comando para arrancar la app
CMD ["python", "main.py"]