# Udev Makefile

NM= udev
VRS= 071
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 99554141df9d8333eeeb37276ada5cdafb080e3c

CONFIG1= $(NM)-config-5.rules
URL-$(CONFIG1)= $(HTTP)/$(NM)/$(CONFIG1)
SHA-$(CONFIG1)= 648115cb81e7507488d151e79fd297abd680aa02

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(CONFIG1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(CONFIG1)} $(LFSSRC)

compile-stage2:
ifndef CROSS
	make EXTRAS=extras/run_directory/
else
	make CC="gcc $(64FLAGS)" LD="gcc $(64FLAGS)" \
	 EXTRAS=extras/run_directory/
endif
	# DESTDIR avoids killing an existing udevd and starting a new one
	make EXTRAS=extras/run_directory/ DESTDIR=/ install
	# Udev-070 Makefile has a bug here
	install -m755 extras/run_directory/udev_run_hotplugd /sbin
	cp $(SRC)/$(CONFIG1) /etc/udev/rules.d/25-lfs.rules
	install -m644 -D docs/writing_udev_rules/index.html \
	 /usr/share/doc/$(DIR)/index.html

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2