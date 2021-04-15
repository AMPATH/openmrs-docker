# Openmrs platform docker
This is a produces a docker image with openmrs platform `v2.4.0` with openmrs rest services module version `2.29.0.b675eb` and FHIR2 Module version `1.1.0`

## Usage
First merge the splitted openmrs war file (- the openmrs platform v2.4.0 war file was splitted to adhere to GitHub's 100MB limit for large files). Use the commmand;
```
cat openmrs.war.aa, openmrs.war.ab > openmrs.war
```

Rename the main.env.example to main.env and use
```docker run --env-file=main.env```
to override the env variables defined in the docker file  refer to http://ryannickel.com/html/playing_with_docker_enviornment_variables.html


# last working image hash
10.50.80.56:5005/openmrs:2.1.2@sha256:b5dbaa216b57afec1a7bb5c3721b59a83292463da6fe9adaf94158cfbf27dfde