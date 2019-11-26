# Openmrs platform docker
This is a produces a docker image with openmrs platform 2.1.2 with openmrs rest services module version 2.24.0
Rename the main.env.example to main.env and use
```docker run --env-file=main.env```
to override the env variables defined in the docker file  refer to http://ryannickel.com/html/playing_with_docker_enviornment_variables.html


# last working image hash
10.50.80.56:5005/openmrs:2.1.2@sha256:89a6385b559506d256b8dc470f60ee501a26c84cb5a7289ef371a3b8310412c3