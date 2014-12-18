baredom.iso: iso/efiboot.img
	cp -r isolinux iso
	cp buildroot/output/images/rootfs.cpio.xz iso/rootfs.cpio
	cp buildroot/output/images/bzImage iso/
	cp buildroot/output/build/xen-master/xen/xen.gz iso/
	xorriso -as mkisofs -iso-level 3 \
        	-full-iso9660-filenames -volid "BAREDOM" \
	        -eltorito-boot isolinux/isolinux.bin -eltorito-catalog isolinux/boot.cat \
	        -no-emul-boot -boot-load-size 4 -boot-info-table \
	        -isohybrid-mbr iso/isolinux/isohdpfx.bin \
	        -eltorito-alt-boot -e efiboot.img -no-emul-boot -isohybrid-gpt-basdat \
	        -output baredom.iso iso

iso/efiboot.img: buildroot/output/target/usr/bin/xl
	cp buildroot/output/images/rootfs.cpio.xz efiboot/EFI/boot/rootfs.cpio
	cp buildroot/output/images/bzImage efiboot/EFI/boot
	cp buildroot/output/build/xen-master/xen/xen.efi efiboot/EFI/boot
	mkdir -p iso
	mkdir -p img
	truncate -s 55M iso/efiboot.img
	mkfs.vfat -n BAREDOM iso/efiboot.img
	sudo mount iso/efiboot.img img
	sudo cp -r efiboot/* img
	sudo umount img

buildroot/output/target/usr/bin/xl: buildroot/output/target/usr/bin/erl
	cp libpthread.so buildroot/output/host/usr/x86_64-buildroot-linux-gnu/sysroot/usr/lib/
	cp libc.so buildroot/output/host/usr/x86_64-buildroot-linux-gnu/sysroot/usr/lib/
	make -C buildroot ERLANG_VERSION=R16B01

buildroot/output/target/usr/bin/erl: buildroot/.config
	make -C buildroot ERLANG_VERSION=R16B01 erlang

buildroot/.config: buildroot
	make -C buildroot BR2_EXTERNAL=`pwd` baredom_defconfig

buildroot:
	git clone git://git.buildroot.net/buildroot

clean:
	rm -f efiboot/EFI/boot/bzImage
	rm -f efiboot/EFI/boot/xen.efi
	rm -f efiboot/EFI/boot/rootfs.cpio
	rm -rf iso
	rm -rf img
	rm -rf buildroot
	rm -f baredom.iso

.PHONY: clean
