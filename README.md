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
