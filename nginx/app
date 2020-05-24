server {
    listen 80;
    localhost;
}

server {
    listen 80;
    localhost;

location / {
  include proxy_params;
  proxy_pass http://unix:/home/tasnuva/work/deployment/src/app.sock;
    }
}
