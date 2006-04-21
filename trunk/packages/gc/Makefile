# Boehm GC Makefile

NM= gc
VRS= 6.7
DIR= $(NM)$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_source/$(FILE)
SHA-$(FILE)= 22d7f81bf141bd1df8fe7a692e80b03754717498

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) 
	$(std_build)

compile-stage2:
	sed -i "s|\$$(datadir)/@PACKAGE@|&-$(VRS)|" doc/Makefile.in
	./configure --prefix=/usr --datadir=/usr/share/doc --enable-cplusplus
	make $(PM)
	make install
	install -v -m644 doc/gc.man /usr/share/man/man3/gc_malloc.3
	ln -sf gc_malloc.3 /usr/share/man/man3/gc.3

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
