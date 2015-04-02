#!/usr/bin/env bash

echo "Provision VM START"
echo "=========================================="
echo "Installing java & scala..."

apt-get update
apt-get install -y python-software-properties wget curl unzip git

if [ ! `which java` ]; then
  add-apt-repository ppa:webupd8team/java
  # Update package list again
  apt-get update
  # Walkthough the License Agreement
  echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
  echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
  apt-get install -y oracle-java8-installer
else
  echo "Already installed java!"
fi

cd /tmp

if [ ! `which scala` ]; then
  wget http://downloads.typesafe.com/scala/2.11.6/scala-2.11.6.tgz ./
  tar -xzf scala-2.11.6.tgz
  mv scala-2.11.6/ /usr/local/share
  rm -f scala-2.11.6.tgz  
else
  echo "Already installed Scala!"
fi

if [ ! `which activator`]; then
  cd /home/vagrant/
  wget http://downloads.typesafe.com/typesafe-activator/1.3.2/typesafe-activator-1.3.2-minimal.zip
  unzip typesafe-activator-1.3.2-minimal.zip
  rm -f typesafe-activator-1.3.2-minimal.zip
  
  # add activator to environment variables
  echo "export PATH=/home/vagrant/activator-1.3.2-minimal:\$PATH" >> /home/vagrant/.bashrc
  source /home/vagrant/.bashrc
  # download dependencies and show activator help - so we don't need to wait later
  /home/vagrant/activator-1.3.2-minimal/activator help
fi

echo ""
echo "=========================================="
echo "jdk version:"
java -version

echo ""
echo "Provision VM finished"  
