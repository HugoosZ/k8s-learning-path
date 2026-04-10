FROM python:3.9-slim

# directorio dentro del contenedor
WORKDIR /app


COPY requirements.txt .
RUN pip install -r requirements.txt

# main.py en el contenedor
COPY main.py .

# puerto 5000 (el que usa Flask)
EXPOSE 5000

# 6. Comando para arrancar la app
CMD ["python", "main.py"]