# Wget Makefile

NM= wget
VRS= 1.10.1
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
SHA= 63249e837a02eb946b887a610ccc7be4ab41d0bc

# Targets

include $(ROOT)/scripts/functions

$(FILE):
	cd $(SRC) ; ftpget $(VRS)
# The only reason for using download below is to check the sha1sum, and create
# the link to the file since at this point we already have the tarball.
	$(call download,$(FILE),NULL,$(SHA))
	

prebuild: Makefile $(FILE)
	$(std_build)

compile-prebuild:
	./configure --prefix=$(WD) --libdir=$(WD)/lib --without-ssl \
	 --enable-static --disable-shared
	make $(PM)
	make install

stage1:
	$(std_build)

compile-stage1:
ifneq ($(LFS-ARCH),x86_64)
	./configure --prefix=$(WD) --libdir=$(WD)/lib --without-ssl \
	 --enable-static --disable-shared
else
	./configure --prefix=$(WD) --host=$(LFS_TARGET) \
	 --without-ssl
endif
	make $(PM)
	make install

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --with-ssl
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-prebuild compile-stage1 clean chroot compile-stage2
