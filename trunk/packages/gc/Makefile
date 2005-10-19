# Boehm GC Makefile

NM= gc
VRS= 6.5
DIR= $(NM)$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_source/$(FILE)
SHA-$(FILE)= 1227e4d5d156bdc56ade82043e1d03d2cf35bef5

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
