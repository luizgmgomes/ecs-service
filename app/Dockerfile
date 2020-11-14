FROM python:3.7-alpine
RUN apk add --no-cache gcc musl-dev linux-headers
COPY requirements.txt ./
RUN pip install -r requirements.txt
EXPOSE 5000
ENV STATIC_URL /static
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
WORKDIR /app
COPY . .
CMD ["python", "app.py", "--host", "0.0.0.0", "-p", "5000", ":", "5000"]
