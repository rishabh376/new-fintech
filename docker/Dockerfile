FROM python:3.9-slim

WORKDIR /app

COPY src/app/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY src/app .

CMD ["python", "main.py"]