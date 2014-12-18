#!/usr/bin/env sh

# enable autologin
sed -i.bak '/ttyS0/c \ttyS0::respawn:-/bin/sh -c "cd /root/lincx; exec /bin/sh"' output/target/etc/inittab
rm -f output/target/etc/inittab.bak
