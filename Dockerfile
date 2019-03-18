FROM tomcat:7-jre8

ENV OPENMRS_HOME /root/.OpenMRS
ENV OPENMRS_MODULES ${OPENMRS_HOME}/modules
# ENV OPENMRS_PLATFORM_URL="https://nofile.io/f/TvXKVtdVjOX/openmrs.war"
# ENV OPENMRS_REST_URL="https://modules.openmrs.org/modulus/api/releases/1616/download/webservices.rest-2.20.0.omod"

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
COPY openmrs.war /root/temp/
RUN mkdir -p ${OPENMRS_HOME}
RUN apt-get update && apt-get install -y mysql-client libxml2-utils openjdk-8-jdk \
    && mkdir -p /root/temp/modules
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      cron rsyslog \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
 COPY ./crontab-sample /etc/cron.d/session-schedule-task
 RUN chmod 0644 /etc/cron.d/session-schedule-task
 ENV TZ=Africa/Nairobi
 RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure -f noninteractive tzdata
 RUN echo "cron.* /var/log/cron.log" >> /etc/rsyslog.conf
ADD modules /root/temp/modules/
#Copy OpenMRS properties file
COPY openmrs-runtime.properties /root/temp/
COPY ./InvalidateHTTPSessions InvalidateHTTPSessions
COPY ./ScheduledGC ScheduledGC
EXPOSE 8080

# Setup openmrs, optionally load demo data, and start tomcat
COPY run.sh /run.sh
ENTRYPOINT ["/run.sh"]
