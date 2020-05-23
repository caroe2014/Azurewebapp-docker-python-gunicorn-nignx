# ---- Base python ----
FROM python:3.6 AS base
# Create app directory
WORKDIR /app

# ---- Dependencies ----
FROM base AS dependencies  
COPY gunicorn_app/requirements.txt ./
COPY app.service /etc/systemd/system/
# install app dependencies
#RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# ---- Copy Files/Build ----
FROM dependencies AS build  
WORKDIR /app
COPY . /app

# Build / Compile if required

# --- Release with Alpine ----
#FROM python:3.6-alpine3.7 AS release
FROM python:3.6 AS release  
# Create app directory
WORKDIR /app

RUN apt-get update \
    && apt-get install -y apt-utils nginx

COPY app /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/app /etc/nginx/sites-enabled

COPY --from=dependencies /app/requirements.txt ./
COPY --from=dependencies /root/.cache /root/.cache


#RUN mkdir /etc/systemd/system/app.service

# Install app dependencies
RUN pip install -r requirements.txt
COPY --from=build /app/ ./
CMD ["gunicorn", "--config", "./gunicorn_app/conf/gunicorn_config.py", "gunicorn_app:app"]
