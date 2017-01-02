FROM jenkins
MAINTAINER jmfiz@paradigmadigital.com

# if we want to install via apt
USER root
# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables

# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ | sh

# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
ADD ./wrapdockerandjenkins /usr/local/bin/wrapdockerandjenkins
RUN chmod +x /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdockerandjenkins

# Define additional metadata for our image.
VOLUME /var/lib/docker
CMD ["wrapdockerandjenkins"]
