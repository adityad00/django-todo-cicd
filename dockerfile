# First stage: build the Django app
FROM python:3 AS builder

WORKDIR /data

RUN pip install django==3.2

COPY . .

RUN python manage.py migrate

# Second stage: final image
FROM python:3

WORKDIR /data

COPY --from=builder /data /data

EXPOSE 8000

CMD ["python","manage.py","runserver","0.0.0.0:8000"]

