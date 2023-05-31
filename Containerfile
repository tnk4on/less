# Containerfile for tnk4on/less

# Preparation Build
FROM registry.access.redhat.com/ubi9/ubi as prep

RUN dnf install --disableplugin=subscription-manager --nodocs -y make gcc autoconf ncurses-devel diffutils git
RUN git clone https://github.com/gwsw/less.git
RUN cd less \
&& make -f Makefile.aut distfiles || true \
&& ./configure --prefix=$HOME/usr \
&& make \
&& make install 

# Building Image
FROM registry.access.redhat.com/ubi9/ubi-micro
LABEL maintainer="Shion Tanaka / Twitter(@tnk4on)"

COPY --from=prep /root/usr/bin/less /usr/bin/less

ENTRYPOINT ["/usr/bin/less"]