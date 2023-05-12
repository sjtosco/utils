# Set $USER capture with Wireshark permissions

On Ubuntu

    sudo apt-get install wireshark libcap2-bin
    sudo groupadd wireshark
    sudo usermod -a -G wireshark $USER
    sudo chgrp wireshark /usr/bin/dumpcap
    sudo chmod 755 /usr/bin/dumpcap
    sudo setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap
    
    
 > WEB: https://osqa-ask.wireshark.org/questions/1949/wireshark-says-there-are-no-interfaces-on-which-a-capture-can-be-done-how-do-i-fix-this
