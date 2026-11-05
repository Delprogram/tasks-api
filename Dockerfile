# Image de base Python légère
FROM python:3.12-slim

# Dossier de travail
WORKDIR /app

# Dépendances d'abord (couche mise en cache tant que requirements.txt ne change pas)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Code de l'application
COPY app/ ./app/

# Utilisateur non-root
RUN useradd --create-home --uid 10001 appuser
USER appuser

# Version embarquée et lancement
ARG APP_VERSION=dev
ENV APP_VERSION=${APP_VERSION}
EXPOSE 8000
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app.main:app"]
