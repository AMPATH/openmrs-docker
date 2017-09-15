FROM tomcat:8-jre8

ENV OPENMRS_HOME /root/.OpenMRS
ENV OPENMRS_MODULES ${OPENMRS_HOME}/modules
ENV OPENMRS_PLATFORM_URL="https://sourceforge.net/projects/openmrs/files/releases/OpenMRS_Platform_2.0.5/openmrs.war/download"
ENV OPENMRS_REST_URL="https://modules.openmrs.org/modulus/api/releases/1616/download/webservices.rest-2.20.0.omod"

ENV DB_NAME="openmrs"
ENV OPENMRS_DB_USER=""
ENV OPENMRS_DB_PASS=""
ENV OPENMRS_MYSQL_HOST=""
ENV OPENMRS_MYSQL_PORT=""

# Refresh repositories and add mysql-client and libxml2-utils (for xmllint)
# Download and Deploy OpenMRS
# Download and copy reference application modules (if defined)
# Unzip modules and copy to module/ref folder
# Create database and setup openmrs db user
RUN mkdir -p ${OPENMRS_HOME}
RUN apt-get update && apt-get install -y mysql-client libxml2-utils \
    && curl -L ${OPENMRS_PLATFORM_URL} -o ${CATALINA_HOME}/webapps/openmrs.war \
    && curl -L ${OPENMRS_REST_URL} -o webservices.rest-2.20.0.omod \
    && mkdir -p /root/temp/modules \
    && cp webservices.rest-2.20.0.omod  /root/temp/modules/

# Copy OpenMRS properties file
COPY openmrs-runtime.properties /root/temp/

EXPOSE 8080

# Setup openmrs, optionally load demo data, and start tomcat
COPY run.sh /run.sh
ENTRYPOINT ["/run.sh"]
