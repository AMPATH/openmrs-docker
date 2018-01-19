FROM tomcat:8-jre8

ENV OPENMRS_HOME /root/.OpenMRS
ENV OPENMRS_MODULES ${OPENMRS_HOME}/modules
ENV OPENMRS_PLATFORM_URL="https://nofile.io/f/TvXKVtdVjOX/openmrs.war"
ENV OPENMRS_REST_URL="https://modules.openmrs.org/modulus/api/releases/1616/download/webservices.rest-2.20.0.omod"

ENV DB_NAME="openmrs"
ENV OPENMRS_DB_USER=""
ENV OPENMRS_DB_PASS=""
ENV OPENMRS_MYSQL_HOST=""
ENV OPENMRS_MYSQL_PORT=""
ENV JAVAMELODY="https://github.com/javamelody/javamelody/releases/download/javamelody-core-1.70.0/javamelody-core-1.70.0.jar"
ENV JROBIN="https://repo1.maven.org/maven2/org/jrobin/jrobin/1.5.9/jrobin-1.5.9.jar"

# Refresh repositories and add mysql-client and libxml2-utils (for xmllint)
# Download and Deploy OpenMRS
# Download and copy reference application modules (if defined)
# Unzip modules and copy to module/ref folder
# Create database and setup openmrs db user
COPY openmrs.war .
RUN mkdir -p ${OPENMRS_HOME}
RUN apt-get update && apt-get install -y mysql-client libxml2-utils \
 && cp openmrs.war ${CATALINA_HOME}/webapps/amrs.war \
 && curl -L ${OPENMRS_REST_URL} -o webservices.rest-2.19.0.omod \
 && mkdir -p /root/temp/modules \
 && cp webservices.rest-2.19.0.omod  /root/temp/modules
ADD modules /root/temp/modules/
# Copy OpenMRS properties file
COPY amrs-runtime.properties /root/temp/

RUN curl -L ${JAVAMELODY} -o ${CATALINA_HOME}/lib/javamelody-core-1.70.0.jar \
 && curl -L ${JROBIN} -o ${CATALINA_HOME}/lib/jrobin-1.5.9.jar \
 && sed -i '588 a <filter> \
        <filter-name>javamelody</filter-name> \
        <filter-class>net.bull.javamelody.MonitoringFilter</filter-class> \
</filter> \
<filter-mapping> \
        <filter-name>javamelody</filter-name> \
        <url-pattern>/*</url-pattern> \
</filter-mapping> \
<listener> \
        <listener-class>net.bull.javamelody.SessionListener</listener-class> \
</listener>' ${CATALINA_HOME}/conf/web.xml

# Setup openmrs, optionally load demo data, and start tomcat
COPY run.sh /run.sh

EXPOSE 8080

ENTRYPOINT ["/run.sh"]
