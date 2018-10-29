FROM centos

RUN yum -y update

RUN yum -y install which && yum clean all

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

RUN curl -L get.rvm.io | bash -s stable --auto-dotfiles

RUN source /etc/profile.d/rvm.sh

RUN source /etc/profile.d/rvm.sh

RUN /bin/bash -c -l "rvm requirements"

RUN /bin/bash -c -l "rvm install 2.5.3"

ADD . /opt/lmdb

RUN /opt/lmdb/bin/setup

