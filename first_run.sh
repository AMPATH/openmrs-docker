#!/bin/sh
echo "Installing bahmni appointments"
docker exec -it amrs-ocl  wget -q https://bintray.com/openmrs/owa/download_file?file_path=appointments-1.0.0.zip -O /usr/local/tomcat/appointments.zip
docker exec -it amrs-ocl  unzip /usr/local/tomcat/appointments.zip -d /usr/local/tomcat/webapps/appointments
docker exec -it amrs-ocl  rm -f /usr/local/tomcat/appointments.zip

echo "Configure configuration and translations path"
docker cp bahmniapps/config/appointments/ng-constants.json amrs-ocl:/usr/local/tomcat/webapps/appointments/constants/ng-constants.json
docker cp bahmniapps/i18n amrs-ocl:/usr/local/tomcat/webapps/appointments/
# docker exec -it amrs-ocl sed -i 's/openmrs\/frontend/openmrs/' /usr/local/tomcat/webapps/appointments/constants/ng-constants.json
docker cp bahmniapps/config amrs-ocl:/usr/local/tomcat/webapps/appointments/bahmniapps
echo "Update global propeties for appointments"
#Since properties will be created only after omods have been run once, we will do an INSERT INTO instead of Update
docker exec -it amrs-db mysql -uopenmrs -pAdmin123 amrsocl -e "INSERT INTO global_property(property, property_value, description, uuid) values ('bahmni.appointments.runningOnOpenMRS', 'true', 'If set to true, the appointments ui will run independent of bahmni core', uuid());INSERT INTO global_property(property, property_value, description, uuid) values ('bahmni.primaryIdentifierType', '05a29f94-c0ed-11e2-94be-8c13b969e334', 'Primary identifier type for looking up patients, generating barcodes, etc.', uuid());"

echo "Create appointment privileges manually, otherwise will be only created after the omod has run"
docker exec -it amrs-db mysql -uopenmrs -pAdmin123 amrsocl -e "INSERT INTO privilege (privilege, description, uuid) VALUES ('Manage Appointments', 'Able to manage Appointments in Appointments module', uuid());"
docker exec -it amrs-db mysql -uopenmrs -pAdmin123 amrsocl -e "INSERT INTO privilege (privilege, description, uuid) VALUES ('Manage Appointment Services', 'Able to manage Appointments in Appointments module', uuid());"
docker exec -it amrs-db mysql -uopenmrs -pAdmin123 amrsocl -e "INSERT INTO privilege (privilege, description, uuid) VALUES ('Manage Appointment Specialities', 'Able to manage Appointments in Appointments module', uuid());"

echo "Give admin user appointment privileges"
docker exec -it amrs-db mysql -uopenmrs -pAdmin123 amrsocl -e "INSERT INTO role values('Bahmni Role', 'Role for bahmni Appointments', uuid());"

docker exec -it amrs-db mysql -uopenmrs -pAdmin123 amrsocl -e "INSERT INTO role_privilege values('Bahmni Role', 'Manage Appointments');"
docker exec -it amrs-db mysql -uopenmrs -pAdmin123 amrsocl -e "INSERT INTO role_privilege values('Bahmni Role', 'Manage Appointment Services');"
docker exec -it amrs-db mysql -uopenmrs -pAdmin123 amrsocl -e "INSERT INTO role_privilege values('Bahmni Role', 'Manage Appointment Specialities');"

echo "Restarting the server"
docker-compose restart amrs-ocl


