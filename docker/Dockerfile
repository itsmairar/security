FROM python:3.9-slim

# Define diretório de trabalho
WORKDIR /app

# Copia os arquivos necessários
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia o código-fonte
COPY . .

# Executa o aplicativo
CMD ["python", "app.py"]
