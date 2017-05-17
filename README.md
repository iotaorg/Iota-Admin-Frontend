RNSP-PCS-frontend
=================

Frontend do administrador do Iota.

Para usar com docker (não precisa do nginx instalado na maquina):

    $ git clone ...; cd <repository>
    $ docker build -t iota/frontend-nginx docker/
    $ ./docker/run-container.sh

Para usar com nginx:

Montar este repositório em `/frontend`, todos os outros endpoints, passar para a API.

Por exemplo, `nginx.conf` com api rodando em `127.0.0.1:5000` e este repositório em `/data/`


    worker_processes 1;

    events { worker_connections 1024; }

    http {
        server {

            location /frontend {
                root /data/;
                autoindex on;
            }

            location / {
                proxy_set_header Host      $host;
                proxy_set_header X-Forwarded-Proto $scheme;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Host $host;
                proxy_set_header X-Real-IP $remote_addr;

                proxy_pass       http://127.0.0.1:5000;
            }
        }
    }
