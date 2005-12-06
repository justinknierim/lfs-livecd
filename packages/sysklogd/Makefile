# Sysklogd Makefile

NM= sysklogd
VRS= 1.4.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 2439b0ce3c3e0c98e5a03cee13a112cff9a801d2

PATCH1= $(DIR)-fixes-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 4fbd5e56c212c8e37f363eb48ba86a5ecea21f4a

PATCH50= $(DIR)-8bit-1.patch
URL-$(PATCH50)= http://www.linuxfromscratch.org/patches/downloads/$(NM)/$(PATCH50)
SHA-$(PATCH50)= edc01eceb4ae7af3d6a02e23a4dace8fee50f3eb

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH50)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1),$(PATCH50)} $(LFSSRC)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH50)
ifndef CROSS
	make $(PM)
else
	make $(PM) CC="gcc $(64FLAGS)"
endif
	make $(PM)
	make install
	cp -ra $(ROOT)/etc/syslog.conf /etc

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
