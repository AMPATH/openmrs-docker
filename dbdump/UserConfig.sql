create user 'openmrs1'@'%' identified by 'Admin123';
grant all privileges on *.* to 'openmrs1'@'%';
flush privileges;