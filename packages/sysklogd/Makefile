# Sysklogd Makefile

NM= sysklogd
VRS= 1.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 070cce745b023f2ce7ca7d9888af434d6d61c236

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	make
	make install
	install -m644 $(ROOT)/etc/syslog.conf /etc

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
