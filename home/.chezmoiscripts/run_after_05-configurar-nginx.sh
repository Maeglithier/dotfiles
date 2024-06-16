#!/bin/bash

if [[ ! -f "/etc/nginx/sites-available/inicio" ]]; then
    cat <<X0 | sudo tee /etc/nginx/sites-available/inicio >/dev/null
server {
	listen 80;
	listen [::]:80;

	server_name inicio;

	root /var/www/startpage;
	index index.html;

	location / {
		try_files \$uri \$uri/ =404;
	}
}
X0
fi

if [[ -f "/etc/nginx/sites-available/inicio" ]]; then
    ln -sf /etc/nginx/sites-available/inicio /etc/nginx/sites-enabled/inicio
fi

sudo nginx -s reload >/dev/null
