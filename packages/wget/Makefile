# Wget Makefile

NM= wget
VRS= 1.10.2
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.gz
SHA= a258357297959964fd42fed6afa1a4cce9069980

# Targets

include $(ROOT)/scripts/functions

$(FILE):
	cd $(SRC) ; ftpget $(VRS)
# The only reason for using download below is to check the sha1sum, and create
# the link to the file since at this point we already have the tarball.
	$(call download,$(FILE),NULL,$(SHA))
	

prebuild: $(FILE)
	$(std_build)

compile-prebuild:
	./configure --prefix=$(WD) --libdir=$(WD)/lib --without-ssl \
	 --enable-static --disable-shared
	make $(PM)
	make install

stage1:
	$(std_build)

compile-stage1:
ifndef CROSS
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
