# Sysklogd Makefile

NM= sysklogd
VRS= 1.4.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 093775da0e429d0768cf195ceb20fdd6d96aeeea

PATCH1= $(DIR)-fixes-2.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 905d17574d6972f494b8ec4cb62bfad1c9f3ff62

PATCH2= $(DIR)-8bit-1.patch
URL-$(PATCH2)= http://www.linuxfromscratch.org/patches/downloads/$(NM)/$(PATCH2)
SHA-$(PATCH2)= edc01eceb4ae7af3d6a02e23a4dace8fee50f3eb

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1),$(PATCH2)} $(LFSSRC)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	make $(PM)
	make install
	install -m644 $(ROOT)/etc/syslog.conf /etc

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
