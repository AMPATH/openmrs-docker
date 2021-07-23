# Openmrs platform docker
This is a produces a docker image with openmrs platform version `v2.4.0`. This comes with two modules bundled which are;
  - FHIR2 Module `v1.1.0`
  - Rest Web Services Module `v2.29.0.b675eb`
## Our Setup
  - OpenMRS platform `v2.4.0`
  - Tomcat `v9.0.5`
  - MySQL `v5.6`
  - Java 11
## Usage
- First merge `openmrs.war.aa` and `openmrs.war.ab` (- the openmrs platform v2.4.0 war file was splitted to adhere to GitHub's 100MB limit for large files). Use the command;
```
cat openmrs.war.* > openmrs.war
```
- Rename the main.env.example to main.env and use
```
docker run --env-file=main.env
```
NOTE: To override the env variables defined in the docker file refer to documentation [here](http://ryannickel.com/html/playing_with_docker_enviornment_variables.html)

## List of AMRS modules
Module name | Version 
--- | --- 
Legacy UI | `1.8.3-SNAPSHOT`
Calculation | `1.2.1`
Html Form Entry	| `4.0.0`
ID Generation | `4.6.0`
Serialization XStream |	`0.2.14`
Html Widgets | `1.10.0`
Data Entry Statistics |	`1.7.0`
Reporting Compatibility | `2.0.7`
FHIR2 Module | `1.2.1`
Rest web services | `2.29.0.b675eb`
Spa Module | `1.0.7-SNAPSHOT`
Patient Matching Module | `1.4-SNAPSHOT`
Cohort Module | `3.0.0-SNAPSHOT`
XForms Module | `4.3.12`
Muzima Core Module | `1.8.1-SNAPSHOT`
FormEntry Module | `5.0.7-SNAPSHOT`
