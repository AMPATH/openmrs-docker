# Openmrs platform docker
This produces a docker image with openmrs platform 2.1.2 with openmrs rest services module version 2.24.0
Rename the main.env.example to main.env and use
```docker run --env-file=main.env```
to override the env variables defined in the docker file  refer to http://ryannickel.com/html/playing_with_docker_enviornment_variables.html

To access amrs use:
    username : pocadmin
    password : POCadmin123

To run the applications, run the following commands in order 
 1. cd amrsdb
 2. cat amrs_part* > ../dbdump/amrs.sql
 3. cd ..
 4. docker-compose up
