#!/usr/bin/bash

set -uxe

sudo useradd -m -d /home/backend backend
curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -

sudo apt-get install -y git nodejs mysql-server

sudo mysql -u root < files/backend/db_init.sql
sudo -u backend git clone https://github.com/bezkoder/nodejs-express-sequelize-mysql.git /home/backend/backend

sudo npm install --prefix /home/backend/backend

cd /home/backend/backend
sudo npm install

sudo cp /home/admin/files/backend/db.config.js /home/backend/backend/app/config/db.config.js
