# Hotplug Makefile

NM= hotplug
VRS= 2004_09_23
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 2dd1be1337765600c66e48e5726a30a197a4f483

PATCH1= $(DIR)-try_all_drivers-6.patch
SHA-$(PATCH1)= 2a51950b25066d5d2cc81683f59c89bf05358494

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	make install
	cp etc/hotplug/pnp.distmap /etc/hotplug
	rm -rf /etc/init.d
	rm -f /etc/hotplug/net.agent
	touch /var/log/hotplug/events
	echo eepro100 >>/etc/hotplug/blacklist
	echo 8139cp >>/etc/hotplug/blacklist
	mkdir /etc/hotplug.d/pci
	install -m755 ../detect-video.hotplug /etc/hotplug.d/pci
	mkdir -p /lib/firmware

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
