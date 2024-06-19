#!/bin/bash

# Disable hyperthreading and set CPU freq (if not already)
if sudo -n true 2> /dev/null; then
        ht_enabled=`cat /sys/devices/system/cpu/smt/control`
        if [ "$ht_enabled" = 'on' ]; then
                echo "- Disabling SMT..."
                echo "off" | sudo tee /sys/devices/system/cpu/smt/control
                echo "+ SMT disabled"
        fi

        boost_enabled=`cat /sys/devices/system/cpu/cpufreq/boost`
        if [ $boost_enabled -eq 1 ]; then
                echo "- Disabling boost frequency..."
                echo "0" | sudo tee /sys/devices/system/cpu/cpufreq/boost
                echo "+ Boost freq. disabled"
        fi

        sudo -n cpupower frequency-set -g performance &> /dev/null
fi
