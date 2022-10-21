##
## Dockerfile for building aquaticus source images
##

# choose base image (bionic focal jammy)
FROM ubuntu:jammy

# install dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    subversion g++ cmake sudo curl git vim emacs \
    libncurses-dev libfltk1.3-dev freeglut3-dev libpng-dev libjpeg-dev libxft-dev libxinerama-dev libtiff5-dev \
    && apt-get clean

# create user
RUN useradd -m -p "moos" moos && \
    usermod -a -G sudo moos && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER moos
WORKDIR /home/moos

# build moos trunk/head
RUN svn export https://oceanai.mit.edu/svn/moos-ivp-aro/trunk/ moos-ivp && \
    cd moos-ivp && \
    ./build.sh && \
    cd -

# build aquaticus
RUN svn export https://oceanai.mit.edu/svn/moos-ivp-aquaticus-oai/trunk/ moos-ivp-aquaticus > /tmp/svn-export && \
    cd moos-ivp-aquaticus && \
    ./build.sh && \
    tail -n1 /tmp/svn-export > revision.txt && \
    cd -

#build robot drivers
RUN git clone https://github.com/westpoint-robotics/mdo-hurt-s.git && \
    cd mdo-hurt-s/moos-ivp-surveyor/ && \
    ./build.sh && \
    cd -

# set vars
ENV PATH /home/moos/moos-ivp-aquaticus/bin:/home/moos/moos-ivp/bin:/home/moos/mdo-hurt-s/moos-ivp-surveyor/bin:$PATH
ENV IVP_BEHAVIOR_DIRS=/home/moos/moos-ivp-aquaticus/lib:/home/moos/moos-ivp-aquaticus/lib

## For submissions, start the app on container start
WORKDIR /home/moos/moos-ivp-aquaticus/missions/oct_wp_competition-2022
ENTRYPOINT ["/bin/bash"]
# CMD ["launch_demo.sh"]
