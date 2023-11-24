FROM timberio/vector:0.33.0-debian

### DEB packages
RUN apt-get update && \
    apt-get -qy install --no-install-recommends nano procps lsof && \
    rm -rf /var/cache/apt/* /var/lib/apt/*
