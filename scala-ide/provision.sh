#!/usr/bin/env bash

echo "Installing Java JDK 8 by Oracle . . ."
add-apt-repository -y ppa:webupd8team/java > /dev/null 2>&1
apt-get update > /dev/null 2>&1
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
apt-get install -y oracle-java8-installer > /dev/null 2>&1
 
echo "Installing scala and setting it up . . . "
debfile="scala-2.10.4.deb"
wget http://www.scala-lang.org/files/archive/"$debfile" > /dev/null 2>&1
dpkg -i "$debfile" > /dev/null 2>&1
apt-get update > /dev/null 2>&1
 
echo "Installing SBT . . ."
debfile="sbt-0.13.8.deb"
wget https://dl.bintray.com/sbt/debian/"$debfile" > /dev/null 2>&1
dpkg -i "$debfile" > /dev/null 2>&1
apt-get update > /dev/null 2>&1
 
basevim="/home/vagrant/.vim"
 
echo "Setting up VIM for syntax highlighting"
#Create directories for vim syntax highlighting then fetch the files from github
#Credit where credit's due, one liner is from blog posting by Bruce Snyder
#http://bsnyderblog.blogspot.com/2012/12/vim-syntax-highlighting-for-scala-bash.html
 
mkdir -p "$basevim"/{ftdetect,indent,syntax} && for d in ftdetect indent syntax ; do wget --no-check-certificate -O "$basevim"/$d/scala.vim https://raw.github.com/scala/scala-dist/master/tool-support/src/vim/$d/scala.vim; done > /dev/null 2>&1
 
rm -f "$debfile"

echo "Installing xauth . . ."
sudo apt-get install xauth > /dev/null 2>&1

echo "Installing IntelliJ . . ."
wget -O /tmp/intellij.tar.gz https://download.jetbrains.com/idea/ideaIU-2016.2.5.tar.gz &&
tar xfz /tmp/intellij.tar.gz
