#!/bin/bash

echo Starting application 

python manage.py  makemigrations

python manage.py  migration

exec gunicorn webapp.wsgi  --name webapp --bind 0.0.0.0:8000 --workers 3
