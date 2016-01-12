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

The OpenUnison deployment process relies on some environment variables to make the initial configuration easier.  It also 
