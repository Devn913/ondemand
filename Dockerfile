FROM rockylinux/rockylinux:9
LABEL maintainer="Devn913"

# Setup OnDemand repositories and install dependencies
RUN dnf -y install https://yum.osc.edu/ondemand/4.0/ondemand-release-web-4.0-1.el9.noarch.rpm && \
    dnf -y update && \
    dnf install -y dnf-utils epel-release && \
    dnf module enable -y ruby:3.3 nodejs:20 && \
    dnf install -y ondemand && \
    dnf clean all && rm -rf /var/cache/dnf/*

RUN /usr/libexec/httpd-ssl-gencerts
RUN systemctl enable httpd

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80 443

CMD [ "/entrypoint.sh" ]
