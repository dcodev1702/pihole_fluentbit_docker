FROM pihole/pihole:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-utils \
    unbound \
    curl \
    dnsutils \
    iputils-ping \
    jq \
    net-tools \
    procps \
    vim \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN touch /etc/s6-overlay/s6-rc.d/user/contents.d/unbound
RUN mkdir -p /etc/s6-overlay/s6-rc.d/user/unbound
RUN mkdir -p /etc/s6-overlay/s6-rc.d/unbound
RUN touch /etc/s6-overlay/s6-rc.d/unbound/type
RUN echo oneshot | tee /etc/s6-overlay/s6-rc.d/unbound/type

RUN tee /etc/s6-overlay/s6-rc.d/unbound/up <<-EOF
foreground { echo "starting unbound..." }
/etc/init.d/unbound start
EOF

# RUN chmod +x /etc/s6-overlay/s6-rc.d/unbound/up
