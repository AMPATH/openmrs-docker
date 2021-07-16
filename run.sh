#!/bin/bash

# Only load db and modules if this script is being loaded for the first time (ie, docker run)
if [ -d "/root/temp" ]; then
# ------------ Begin Load Database ------------

echo "Using MySQL host: ${OPENMRS_MYSQL_HOST}"

echo "Using MySQL port: ${OPENMRS_MYSQL_PORT}"

# Ensure mysql is up
while ! mysqladmin ping -h"$OPENMRS_MYSQL_HOST" -P $OPENMRS_MYSQL_PORT --silent; do
    echo "Waiting for database at '$OPENMRS_MYSQL_HOST:$OPENMRS_MYSQL_PORT'..."
    sleep 2
done


 # Write openmrs-runtime.properties file with linked database settings
OPENMRS_CONNECTION_URL="connection.url=jdbc\:mysql\://$OPENMRS_MYSQL_HOST\:$OPENMRS_MYSQL_PORT/${DB_NAME}?autoReconnect\=true&zeroDateTimeBehavior\=convertToNull&sessionVariables\=default_storage_engine\=InnoDB&useUnicode\=true&characterEncoding\=UTF-8"
echo "${OPENMRS_CONNECTION_URL}" >> /root/temp/openmrs-runtime.properties
echo "connection.username=${OPENMRS_DB_USER}" >> /root/temp/openmrs-runtime.properties
echo "connection.password=${OPENMRS_DB_PASS}" >> /root/temp/openmrs-runtime.properties
mkdir -pv ${OPENMRS_HOME}/${OPENMRS_NAME}
mkdir -pv ${OPENMRS_HOME}/${OPENMRS_NAME}/frontend
cp /root/temp/openmrs-runtime.properties ${OPENMRS_HOME}/${OPENMRS_NAME}/${OPENMRS_NAME}-runtime.properties
cp /root/temp/openmrs.war  ${CATALINA_HOME}/webapps/${OPENMRS_NAME}.war
# Copy base/dependency modules to module folder
echo "Copying module dependencies and reference application modules..."
export OPENMRS_MODULES=${OPENMRS_HOME}/${OPENMRS_NAME}/modules
rm -rf ${OPENMRS_HOME}/${OPENMRS_NAME}/modules/
mkdir -pv $OPENMRS_MODULES
cp /root/temp/modules/*.omod $OPENMRS_MODULES
rm -rf ${OPENMRS_HOME}/${OPENMRS_NAME}/.openmrs-lib-cache/
echo "Modules copied."
# Setup microfrontends
echo "Setting up microfrontends"
ls /root/temp/microfrontends
cp -r /root/temp/microfrontends/* ${OPENMRS_HOME}/${OPENMRS_NAME}/frontend/
cp  /root/temp/microfrontends/import-map.json ${OPENMRS_HOME}/${OPENMRS_NAME}/frontend/import-map.json

echo "List copied frontend assets"
ls ${OPENMRS_HOME}/${OPENMRS_NAME}/frontend/
# Cleanup temp files
rm -r /root/temp
fi

# Set custom memory options for tomcat
export JAVA_OPTS="-Dfile.encoding=UTF-8 -server -Xms1024m -Xmx2048m -XX:PermSize=256m -XX:MaxPermSize=1024m"

echo "Setup cron"
service rsyslog start
service cron start
# Run tomcat
catalina.sh run
