# Patch Makefile

NM= patch
VRS= 2.5.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 0282d048ff6ebd06cb92adc06b49932ec71c382f

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
ifneq ($(LFS-ARCH),x86_64)
	CPPFLAGS=-D_GNU_SOURCE ./configure --prefix=$(WD)
else
	CC="${CC} ${BUILD64}" ./configure --prefix=$(WD) \
    	 --host=$(LFS_TARGET)
endif
	make $(PM)
	make install

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	CPPFLAGS=-D_GNU_SOURCE ./configure --prefix=/usr
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
