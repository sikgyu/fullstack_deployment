CREATE DATABASE tutorials;
CREATE USER backend;
ALTER USER 'backend'@'%' IDENTIFIED BY 'backend';
GRANT ALL PRIVILEGES ON tutorials.* TO 'backend'@'%';
FLUSH PRIVILEGES
