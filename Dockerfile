FROM tremolosecurity/openunison:1.0.6

MAINTAINER Tremolo Security, Inc. - Docker <docker@tremolosecurity.com>

#Network Configuration
ENV OPENUNISON_HOST 192.168.99.100
ENV OPENUNISON_PT_PORT 8080
ENV OPENUNISON_EXT_PT_PORT 8888
ENV OPENUNISON_ENC_PORT 8443
ENV OPENUNISON_EXT_ENC_PORT 8443
ENV OPENUNISON_FORCE_TO_ENC true

# Key configuration
ENV OPENUNISON_TLS_KEYALIAS unison-tls
ENV OPENUNISON_SESSION_KEY session-unison
ENV OPENUNISON_KEYSTORE_PASSWORD start123




ADD ./conf/unisonKeyStore.jks /etc/openunison/unisonKeyStore.jks
ADD ./conf/*.xml /tmp/
ADD ./conf/unisonService.props /tmp/
ADD ./conf/myvd.conf /tmp/

RUN /usr/local/tomcat/bin/preProcConfig.py /tmp/unison.xml /etc/openunison/unison.xml ; \
    /usr/local/tomcat/bin/preProcConfig.py /tmp/myvd.conf /etc/openunison/myvd.conf ; \
    /usr/local/tomcat/bin/preProcConfig.py /tmp/unisonService.props /etc/openunison/unisonService.props ; \
    /usr/local/tomcat/bin/preProcConfig.py /tmp/log4j.xml /etc/openunison/log4j.xml ; \
    /usr/local/tomcat/bin/preProcConfig.py /tmp/server.xml /usr/local/tomcat/conf/server.xml

#Uncomment if using provisioning web services
ENV OPENUNISON_WS_WEBXML https://raw.githubusercontent.com/TremoloSecurity/OpenUnison/1.0.6-Dev/unison/open-unison-webapp-webservices/src/main/webapp/WEB-INF/web.xml
RUN curl $OPENUNISON_WS_WEBXML -o /usr/local/tomcat/webapps/ROOT/WEB-INF/web.xml
