FROM ubuntu:bionic

RUN \
  apt-get update && \
  apt-get install -y debhelper devscripts equivs git sudo && \
  rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
