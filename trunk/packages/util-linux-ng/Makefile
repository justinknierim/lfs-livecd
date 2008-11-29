# Util-Linux-NG Makefile

NM= util-linux-ng
VRS= 2.14.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 4b738db04b27278329af216b15e96752e5af8cc3

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)

compile-stage1:
	./configure --prefix=$(WD)
	make BLKID_LIBS="-lblkid -luuid" -C mount mount umount
	make -C text-utils more
	cp mount/{,u}mount text-utils/more $(WD)/bin

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -e 's@etc/adjtime@var/lib/hwclock/adjtime@g' \
	 -i $$(grep -rl '/etc/adjtime' .)
	mkdir -pv /var/lib/hwclock
	./configure --enable-arch --enable-partx --enable-write
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
