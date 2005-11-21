# Subversion Makefile

NM= subversion
VRS= 1.2.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 513a217ba4a8045ea3daba5c3b0816f80ce0041b

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
ifeq ($(LFS-ARCH),sparc64)
	CC="gcc $(64FLAGS)" ./configure --prefix=/usr \
	 --libdir=/usr/lib64
else
	./configure --prefix=/usr
endif
	make $(PM)
	make install
	install -v -d -m755 /usr/share/doc/$(DIR)
	cp -v -R doc/* /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
