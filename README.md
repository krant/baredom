# Baredom Linux

Minimal Xen Dom0 bootable ISO with LINCX preinstalled

 * [Buildroot](http://buildroot.net) based
 * Both BIOS and UEFI boots are supported
 * x86_64 only
 * Initramfs only (no disks required)
 * Full [LINCX](https://github.com/FlowForwarding/lincx) toolchain included (Erlang/OTP, [LING](https://github.com/cloudozer/ling))

# Install

Make sure you have prerequisites
```
 git make gcc dosfstools xorriso
```
Clone repo, launch make and wait a while. Enter sudo password when asked.
```
 $ git clone https://github.com/krant/baredom.git
 $ cd baredom
 $ make
```
If everything goes fine you will get a nice baredom.iso. Burn it to your USB:
```
 $ sudo dd if=baredom.iso of=/dev/sdX
```
Boot from USB and play with [LINCX](https://github.com/FlowForwarding/lincx)!
