if [[ ! -f "/etc/nginx/conf.d/startpage.conf" ]]; then
cat << X0 | sudo tee /etc/nginx/conf.d/startpage.conf >/dev/null;
server {
    listen 80;

    server_name startpage.local;

    location / {
        proxy_pass http://127.0.0.1:9999/;
    }
}
X0
fi

sudo nginx -s reload >/dev/null;