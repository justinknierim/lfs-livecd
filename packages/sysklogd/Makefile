# Sysklogd Makefile

NM= sysklogd
VRS= 1.4.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 2439b0ce3c3e0c98e5a03cee13a112cff9a801d2

PATCH1=$(DIR)-fixes-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 4fbd5e56c212c8e37f363eb48ba86a5ecea21f4a

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i $(SRC)/$(PATCH1)
	make $(PM)
	make install
	cp -ra $(ROOT)/etc/syslog.conf /etc

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
