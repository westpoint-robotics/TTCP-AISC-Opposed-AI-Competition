FROM moosivp/moos-ivp:r10031-gui as build

RUN svn export https://oceanai.mit.edu/svn/moos-ivp-aquaticus-oai/trunk/ moos-ivp-aquaticus && \
    cd moos-ivp-aquaticus && \
    ./build.sh && \
    cd -

ENV PATH /home/moos/moos-ivp-aquaticus/bin:$PATH
ENV IVP_BEHAVIOR_DIRS=/home/moos/moos-ivp-aquaticus/lib:$IVP_BEHAVIOR_DIRS
