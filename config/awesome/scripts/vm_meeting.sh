if [ -f ~/Cloud/.keys/meeting_vm.sh ]; then
    echo "Credential file exists. Using the file."
    source ~/Cloud/.keys/meeting_vm.sh
else
    vmuser="USER"
    vmpass="PASS"
    vmip="192.168.122.144"
fi

tmp=$(virsh --connect qemu:///system list | grep " meeting " | awk '{ print $3}')

if ([ "x$tmp" == "x" ] || [ "x$tmp" != "xrunning" ])
then
    echo "Virtual Machine meeting is starting now... Waiting 30s before starting xfreerdp."
    notify-send "Virtual Machine meeting is starting now..." "Waiting 30s before starting xfreerdp."
    virsh --connect qemu:///system start meeting
    sleep 30
else
    notify-send "Virtual Machine meeting is already running." "Launching xfreerdp now!"
    echo "Starting xfreerdp now..."
fi

xfreerdp -grab-keyboard /v:$vmip /size:100% /cert-ignore /u:$vmuser /p:$vmpass /d: /dynamic-resolution /gfx-h264:avc444 +gfx-progressive &
