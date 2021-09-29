#!/usr/bin/bash

sudo git clone https://github.com/bezkoder/react-crud-web-api.git /home/admin/frontend
cd frontend/
sudo npm install
sudo npm run-script build

sudo apt -y install nginx

sudo cp /home/admin/files/frontend/default /etc/nginx/sites-enabled/default
sudo cp /home/admin/files/frontend/http-common.js /home/admin/frontend/src/http-common.js

sudo systemctl restart nginx

sudo npm run-script build

cd /home/backend/backend/
