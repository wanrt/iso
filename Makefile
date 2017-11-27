all: build/images/wanparty-9.2.0.iso build/images/wanparty-8.9.0.iso

images/debian-%.iso:
	mkdir -p images
	wget -c https://cdimage.debian.org/cdimage/archive/$*/amd64/iso-cd/debian-$*-amd64-netinst.iso  -O images/debian-$*.iso

mnts/loop-%.cd: images/debian-%.iso
	mkdir -p $@
	mountpoint -q $@ || sudo mount -o loop images/debian-$*.iso $@

build/images/wanparty-%: mnts/loop-%.cd iso-src/%
	mkdir -p $@
	rsync -a -H  $</ build/images/wanparty-$*/
	sudo cp -rfv iso-src/$*/* $@

build/images/wanparty-%.iso: build/images/wanparty-%
	sudo genisoimage -o $@ -r -J -no-emul-boot -boot-load-size 4 -boot-info-table -b isolinux/isolinux.bin -c isolinux/boot.cat $<
	md5sum $@ > $@.md5
	gpg  --output $@.sig --detach-sign $@


.PHONY: clean
clean:
	sudo umount mnts/* || true
	sudo rm -rf build images mnts
