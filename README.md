# Openmrs platform docker
This is a produces a docker image with openmrs platform 2.0.5 with openmrs rest services module version 2.20.0
Rename the main.env.example to main.env and use
```docker run --env-file=main.env```
to override the env variables defined in the docker file  refer to http://ryannickel.com/html/playing_with_docker_enviornment_variables.html