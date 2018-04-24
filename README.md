# docker-java
## Phusion/baseimage:0.9.22 image with Oracle JDK 8.0 build 131 installed.

* Includes the JMX to Prometheus exporter v0.9/2017-03-21
* US English UTF8 Locale is set
* tzdata set to America/Chicago

## Intent:
This JDK image is probably suitable for most any purpose including a properly adjusted Ubuntu 16.04 for running server processes reliably.
https://github.com/phusion/baseimage-docker/tree/0.9.22

I will use this image to stand up various Pentaho products (server and data integration tools). Those tools have a lot of components which could use good monitoring. The plan is to use the JMX to Prometheus exporter to gain visibility into the performance and display it in Grafana. I found this excellent starter stack on github by vegabrianc [A Prometheus & Grafana docker-compose stack](https://github.com/vegasbrianc/prometheus)

Links:
Included in this image:
    [Phusion Base Images](https://github.com/phusion/baseimage-docker/releases)
    [JMX to Prometheus Exporter](https://github.com/prometheus/jmx_exporter/releases)
Not included in this image:
    [Grafana](https://grafana.com/dashboards/893)

## Credits:
Zhichun Wu created the original base image here.