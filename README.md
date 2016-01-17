# Open Unison Docker Deployment Image

This image is used to deploy OpenUnison inside of a Docker container.  The high level steps to setting up OpenUnison in a container are:

1. Clone this repo
2. Update the environment variables to match your environment
3. Generate a keystore with the appropriate keys
4. Update unison.xml and myvd.conf for your business needs
5. Deploy

## Cloning the Repo

The first step is to clone the deployment repo:

```bash
$ git clone https://github.com/TremoloSecurity/OpenUnisonDockerDeploy.git
```

## Generate the Initial Keystore

Once the repo is cloned, generate a default keystore.  The names below are based on the names in the default Dockerfile.

```bash
$ cd OpenUnisonDockerDeploy/
$ keytool -genkeypair -storetype JCEKS -alias unison-tls -keyalg RSA -keysize 2048 -sigalg SHA256withRSA -validity 365 -keystore ./conf/unisonKeyStore.jks
.
.
.
$ keytool -genseckey -storetype JCEKS -alias session-unison -keyalg AES -keysize 256  -keystore ./conf/unisonKeyStore.jks
```

## Update the Environment Variables

The OpenUnison deployment process relies on some environment variables to make the initial configuration easier.  When building the image for the first time, if you used the same values from the environment variables when creating the keystore, the only setting that must be set is the OPENUNISON_HOST environment variable.  This should be whatever the host port of the url will be when accessing OpenUnison.

## Build and Run

At this point OpenUnison can be deployed and accessed with a default username and password.  First build the image:

```bash
$ docker build --no-cache -t local/openunison:1.0.6  .
$ docker run -ti -p 8080:8080 -p 8443:8443 local/openunison:1.0.6
```

Once the image is running, it can be accessed by going to https://host:8443/ where host is what you specified for the OPENUNISON_HOST environment variable in the Dockerfile.  The default username and password is test/test.

## Configuring OpenUnison

OpenUnison is configured via the con/unison.xml file and the conf/myvd.conf file.  When seting up the configurations for these files, the /usr/local/tomcat/bin/preProcConfig.py script is called to replace anything between #[] with its value for an environment variable.  For instance #[OPENUNISON_HOST] will be replaced with the value of the environment variable OPENUNISON_HOST.  This can be used to parameterize the configuration.

For details on how to configure OpenUnison, see OpenUnison's documentation - https://www.tremolosecurity.com/docs/tremolosecurity-docs/1.0.6/openunison/openunison.html

## Environment Variables

The following environment variables are defined in the Dockerfile

| Environment Variable | Description | Notes |
| -------------------- | ----------- | ----- |
| OPENUNISON_HOST      | The host name port of the URL for accessing OpenUnison and OpenUnison protected applications | For instance if accessing a protected application is https://host.domain.com/app then this variable should be set to OPENUNISON_HOST |
| OPENUNISON_PT_PORT   | The plain text port OpenUnison is running on | This will be configured on Tomcat |
| OPENUNISON_EXT_PT_PORT | The port that URLs the user will enter their browser will have. |  This will often be the port on a load balancer |
| OPENUNISON_ENC_PORT | The encrypted port OpenUnison is running on | This will be configured on Tomcat |
| OPENUNISON_EXT_ENC_PORT | The port that URLs the user will enter their browser will have. |  This will often be the port on a load balancer |
| OPENUNISON_FORCE_TO_ENC | If set to true, OpenUnison will allways send users to HTTPS if accessed via HTTP | true or false |
| OPENUNISON_TLS_KEYALIAS | The name of the certificate Tomcat will use for its TLS listener in the conf/unisonKeystore.jks file | |
| OPENUNISON_SESSION_KEY | The alias of the security key in conf/unisonKeystore.jks used to encrypt user sessions | MUST be AES256 |
| OPENUNISON_KEYSTORE_PASSWORD | The password for conf/unisonKeystore.jks | |


