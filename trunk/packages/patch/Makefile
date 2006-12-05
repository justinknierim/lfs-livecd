# Patch Makefile

NM= patch
VRS= 2.5.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= a12d520eba0dc35d1c4d50ec75b7684451a40de9

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
	# CPPFLAGS=-D_GNU_SOURCE is for ppc
	CPPFLAGS=-D_GNU_SOURCE ./configure --prefix=$(WD)
	make $(PM)
	make install

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	# CPPFLAGS=-D_GNU_SOURCE is for ppc
	CPPFLAGS=-D_GNU_SOURCE ./configure --prefix=/usr
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
