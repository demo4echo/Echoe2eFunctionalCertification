# Echoe2eFunctionalCertification
_A module holding all the end to end tests run against the [echobe](https://github.com/demo4echo/echobe) and [echofe](https://github.com/demo4echo/echofe) µs following every successful build of them :basecampy:_

## TL;DR:
The module uses [karate](https://github.com/intuit/karate) for managing end to end automated testing (mainly in the area of REST API)

### Principal Items:
**EnvFile.properties** - branch specific configuration file. All its properties are converted to environment variables within the Jenkins Pipeline execution. This file will not be merged during merge between branches (following a proper setup in the **.gitattributes** file)
