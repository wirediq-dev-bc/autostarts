#!/bin/bash
# XenServer 7.2.0 Virtual Appliance auto-start init script.  

# To install onto 
# 1) copy this file to /opt/wirediq/brainstem/tools/vapp-autostart.sh
# 2) make it executable by running: chmod +x /opt/wirediq/brainstem/tools/vapp-autostart.sh
# 3) Edit /etc/rc.local with nano, pico or vi editors and add /opt/wirediq/brainstem/tools/vapp-autostart.sh to the last blank line in the file. There is one line beneath this that contains 'touch /var/lock/subsys/local'.
# 4) Make /etc/rc.d/rc.local executable: chmod +x /etc/rc.d/rc.local 

# USAGE: In XenCenter, create a virtual appliance (vApp) with the same name as set above in the variable named "VIRTAPP" (below).
# Assign VMs & their boot order as you see fit in XenCenter client for the virtual appliance.  
# NOTE: Always start the SD-WAN router 1st & give it time to bring up its interfaces before launching other guests/VMs.

VIRTAPP="BrainBox"  # Name of virtual appliance to launch @ boot

while true; do 
  test -f /var/run/xapi_init_complete.cookie && \
    test "$(xe appliance-param-get uuid=$(xe appliance-list name-label="${VIRTAPP}" --minimal) param-name=allowed-operations --minimal)" == "start" && \
      xe appliance-start uuid=$(xe appliance-list name-label="${VIRTAPP}" --minimal) && \
	exit
  sleep 1
done

