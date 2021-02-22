#!/bin/bash
# Update apt and get dependencies
sudo apt-get -y update
sudo apt-mark hold grub
sudo apt-mark hold grub-pc
sudo apt-get -y upgrade
sudo apt-get install -y zip unzip curl wget socat ebtables git vim conntrack