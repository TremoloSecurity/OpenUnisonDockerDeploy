FROM tremolosecurity/openunison:1.0.6

MAINTAINER Tremolo Security, Inc. - Docker <docker@tremolosecurity.com>


ENV JAVA_OPTS -Dopenunison.pt.port=8080 -Dopenunison.enc.port=8443 -Dopenunison.tls.keyalias=unison-tls -Dopenunison.ks.password=start123

#Network Configuration
ENV OPENUNISON_HOST 192.168.99.101
ENV OPENUNISON_EXT_PT_PORT 8888
ENV OPENUNISON_EXT_ENC_PORT 8443
ENV OPENUNISON_FORCE_TO_ENC true

# Key configuration
ENV OPENUNISON_SESSION_KEY session-unison




ADD ./conf/unisonKeyStore.jks /etc/openunison/unisonKeyStore.jks
ADD ./conf/unison.xml /etc/openunison/unison.xml
ADD ./conf/log4j.xml /etc/openunison/log4j.xml
ADD ./conf/server.xml /usr/local/tomcat/conf/server.xml
ADD ./conf/unisonService.props /etc/openunison/unisonService.props
ADD ./conf/myvd.conf /etc/openunison/myvd.conf

#Uncomment if using provisioning web services
#ENV OPENUNISON_WS_WEBXML https://raw.githubusercontent.com/TremoloSecurity/OpenUnison/1.0.6-Dev/unison/open-unison-webapp-webservices/src/main/webapp/WEB-INF/web.xml
#RUN curl $OPENUNISON_WS_WEBXML -o /usr/local/tomcat/webapps/ROOT/WEB-INF/web.xml
