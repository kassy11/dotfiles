#!/bin/sh

sudo purge
echo "purge memory!"
sudo rm -rf ~/Library/Developer/Xcode/DerivedData/*
echo "clean Xcode/DerivedData!"
sudo rm -rf ~/Library/Developer/Xcode/Archives/*
echo "clean Xcode/Archives!"
sudo rm -rf ~/Library/Caches/*
echo "clean Library/Caches!"
sudo rm -rf ~/Library/Logs/iOS\ Simulator
echo "clean iOS logs"
sudo rm -rf ~/Library/Developer/Xcode/iOS\ DeviceSupport/*
echo "clean simulator cache!"
brew cleanup
echo "cleanup brew packages!"