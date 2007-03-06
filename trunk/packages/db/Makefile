# DB Makefile

NM= db
VRS= 4.5.20
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 0e5a6c152c5d7089899481d9de689d1f7e77bde1

PATCH1= $(DIR)-fixes-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/lfs/development/$(PATCH1)
SHA-$(PATCH1)= adf217ef8606f25b6fd4e7c9a0c1ea9f01c4f250

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	cd build_unix ; ../dist/configure --prefix=/usr \
	    --enable-compat185 --enable-cxx
	cd build_unix ; make
	cd build_unix ; make docdir=/usr/share/doc/$(DIR) install
	chown -Rv root:root /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
