#!/bin/bash
echo "Starting bahmni configs ${OPENMRS_DB_USER}"
if [[ ! -z "${OPENMRS_DB_USER}" ]] && [[ ! -z "${OPENMRS_DB_PASS}" ]] && [[ ! -z "${DB_NAME}" ]]
then
    echo "Downloading Bahmni UI"
    wget -q https://bintray.com/openmrs/owa/download_file?file_path=appointments-1.0.0.zip -O /usr/local/tomcat/appointments.zip
    unzip /usr/local/tomcat/appointments.zip -d /usr/local/tomcat/webapps/appointments
    rm -f /usr/local/tomcat/appointments.zip
    cp -r /root/temp/bahmniapps/config/appointments/ng-constants.json /usr/local/tomcat/webapps/appointments/constants/ng-constants.json
    cp -r /root/temp/bahmniapps/i18n /usr/local/tomcat/webapps/appointments/
    mkdir -p /usr/local/tomcat/webapps/appointments/bahmniapps/config
    cp -r /root/temp/bahmniapps/config /usr/local/tomcat/webapps/appointments/bahmniapps/
    #Configure Bahmni Roles and privileges
    echo "Configuring Bahmni UI global properties, roles and privileges"
    mysql -u${OPENMRS_DB_USER} -p${OPENMRS_DB_PASS} -h ${OPENMRS_MYSQL_HOST} ${DB_NAME} < /root/temp/bahmniapps/db/properties.sql
else
    echo "DB Credentials are not set"
fi