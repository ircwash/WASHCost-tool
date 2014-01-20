#!/usr/bin/env bash

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list

apt-get update
apt-get install -y nano curl git build-essential mongodb-10gen libv8-dev nodejs qt4-dev-tools libqt4-dev libqt4-core libqt4-gui

# Check locales are set up properly

sudo update-locale LC_ALL=en_GB.UTF-8

# Set up RVM with Ruby 1.9.3

curl -sSL https://get.rvm.io | sudo bash -s stable
usermod -aG rvm vagrant
source /etc/profile.d/rvm.sh
rvm install ruby-1.9.3
rvm use --default ruby-1.9.3

su vagrant <<EOU

# Set up RVM as vagrant user

source /etc/profile.d/rvm.sh
rvm use --default ruby-1.9.3

# Install gems

gem install bundler

# Set up project dependencies

cd /vagrant/
bundle update debugger
bundle install
bundle exec rake db:migrate

EOU