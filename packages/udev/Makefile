# Udev Makefile

NM= udev
VRS= 070
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= ec9b92524a0b7b4e0c6d787d5cb6ee55ae72b607

CONFIG1= $(NM)-config-3.rules
URL-$(CONFIG1)= $(HTTP)/$(NM)/$(CONFIG1)
SHA-$(CONFIG1)= ad947b94db2c2d7d56ecf0aaabc8af4a0094a964

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(CONFIG1)
	$(std_build)

compile-stage2:
ifndef CROSS
	make EXTRAS=extras/run_directory/
else
	make CC="gcc ${BUILD64}" LD="gcc ${BUILD64}" \
	 EXTRAS=extras/run_directory/
endif
	# DESTDIR avoids killing an existing udevd and starting a new one
	make EXTRAS=extras/run_directory/ DESTDIR=/ install
	# Udev-070 Makefile has a bug here
	install -m755 extras/run_directory/udev_run_hotplugd /sbin
	cp $(SRC)/$(CONFIG1) /etc/udev/rules.d/25-lfs.rules
	echo 'RUN+="/sbin/udev_run_hotplugd"' >>/etc/udev/rules.d/25-lfs.rules
	install -m644 -D docs/writing_udev_rules/index.html \
	 /usr/share/doc/$(DIR)/index.html

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
