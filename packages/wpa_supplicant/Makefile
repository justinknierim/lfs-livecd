# wpa_supplicant Makefile

NM= wpa_supplicant
VRS= 0.5.8
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://hostap.epitest.fi/releases/$(FILE)
SHA-$(FILE)= 434545faf4758044629f574d82939511be8deb0b

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	cp defconfig .config
	make
	install -m755 wpa_supplicant wpa_passphrase wpa_cli /usr/bin
	mkdir -p /etc/wpa_supplicant
	cp examples/*.conf /etc/wpa_supplicant

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
