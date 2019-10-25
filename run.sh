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
OPENMRS_CONNECTION_URL="connection.url=jdbc\:mysql\://$OPENMRS_MYSQL_HOST\:$OPENMRS_MYSQL_PORT/${DB_NAME}?autoReconnect\=true&sessionVariables\=default_storage_engine\=InnoDB&useUnicode\=true&characterEncoding\=UTF-8"
echo "${OPENMRS_CONNECTION_URL}" >> /root/temp/openmrs-runtime.properties
echo "connection.username=${OPENMRS_DB_USER}" >> /root/temp/openmrs-runtime.properties
echo "connection.password=${OPENMRS_DB_PASS}" >> /root/temp/openmrs-runtime.properties
cp /root/temp/openmrs.war  ${CATALINA_HOME}/webapps/${OPENMRS_NAME}.war
# Copy base/dependency modules to module folder
echo "Copying module dependencies and reference application modules..."
export OPENMRS_MODULES=${OPENMRS_HOME}/modules
rm -rf ${OPENMRS_HOME}/${OPENMRS_NAME}/modules/
mkdir -pv $OPENMRS_MODULES
cp /root/temp/modules/*.omod $OPENMRS_MODULES
cp /root/temp/openmrs-runtime.properties  ${OPENMRS_HOME}/${OPENMRS_NAME}-runtime.properties
rm -rf ${OPENMRS_HOME}/${OPENMRS_NAME}/.openmrs-lib-cache/
echo "Modules copied."

# Cleanup temp files
rm -r /root/temp
fi

# Set custom memory options for tomcat
export JAVA_OPTS="-Dfile.encoding=UTF-8 -server -Xms256m -Xmx1024m -XX:PermSize=256m -XX:MaxPermSize=512m"
echo "Setup cron"
service rsyslog start
service cron start
# Run tomcat
catalina.sh run
