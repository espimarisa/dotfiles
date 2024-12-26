#!/bin/bash
pkexec virsh --connect qemu:///system start "win10"
sleep 10
looking-glass-client -C "~/.config/looking-glass/main.ini"
