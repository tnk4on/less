# Containerfile for tnk4on/less
FROM registry.access.redhat.com/ubi8/ubi
LABEL maintainer="Shion Tanaka / Twitter(@tnk4on)"

ENV VERSION=594

RUN dnf install --disableplugin=subscription-manager --nodocs -y make gcc autoconf automake ncurses-devel git \
&& git clone https://github.com/gwsw/less.git \
&& cd less \
&& autoreconf -i \
&& make -f Makefile.aut dist || true \
&& cp release/less-${VERSION}/less-${VERSION}.tar.gz . \
&& tar xf less-${VERSION}.tar.gz \
&& cd less-${VERSION} \
&& ./configure --prefix=$HOME/usr \
&& make \
&& make install

WORKDIR /tmp
ENTRYPOINT ["/root/usr/bin/less"]