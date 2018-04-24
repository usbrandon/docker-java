#
# This is a base image for Oracle JDK based server
#

# Pull base image
FROM phusion/baseimage:0.10.0

# Set maintainer
MAINTAINER Brandon Jackson <usbrandon@gmail.com>

# Set environment variables
ENV LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8" LC_ALL="en_US.UTF-8" TERM=xterm JAVA_VERSION=8 JAVA_HOME=/usr/lib/jvm/java-8-oracle \
	JMX_EXPORTER_VERSION=0.9 JMX_EXPORTER_FILE=/usr/local/jmx_prometheus_javaagent.jar

# Set label
LABEL java_version="Oracle Java $JAVA_VERSION"

# Configure system(charset and timezone) and install JDK
RUN locale-gen en_US.UTF-8 \
		&& echo 'APT::Install-Recommends 0;' >> /etc/apt/apt.conf.d/01norecommends \
		&& echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends \
		&& echo '#!/bin/bash' > /usr/bin/oom_killer \
			&& echo 'set -e' >> /usr/bin/oom_killer \
			&& echo 'echo "`date +"%Y-%m-%d %H:%M:%S.%N"` OOM Killer activated! PID=$PID, PPID=$PPID"' >> /usr/bin/oom_killer \
			&& echo 'ps -auxef' >> /usr/bin/oom_killer \
			&& echo 'for pid in $(jps | grep -v Jps | awk "{print $1}"); do kill -9 $pid; done' >> /usr/bin/oom_killer \
			&& chmod +x /usr/bin/oom_killer \
		&& add-apt-repository -y ppa:webupd8team/java \
		&& apt-get update \
		&& apt-get dist-upgrade --yes \
		&& echo oracle-java${JAVA_VERSION}-installer shared/accepted-oracle-license-v1-1 select true \
				| /usr/bin/debconf-set-selections \
		&& apt-get install -y --allow-unauthenticated software-properties-common \
			wget tzdata net-tools curl iputils-ping iotop iftop tcpdump lsof htop iptraf \
			oracle-java${JAVA_VERSION}-installer oracle-java${JAVA_VERSION}-unlimited-jce-policy \
                && printf '2\n37\n' | dpkg-reconfigure -f noninteractive tzdata \
		&& wget -O ${JMX_EXPORTER_FILE} http://central.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${JMX_EXPORTER_VERSION}/jmx_prometheus_javaagent-${JMX_EXPORTER_VERSION}.jar \
		&& apt-get autoremove --yes \
		&& apt-get clean \
		&& rm -rf /var/lib/apt/lists/* /var/cache/oracle-jdk8-installer $JAVA_HOME/*.zip
