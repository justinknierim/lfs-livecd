# xfmedia Makefile

NM= xfmedia
VRS= 0.9.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://spuriousinterrupt.org/files/xfmedia/$(FILE)
SHA-$(FILE)= cb8d39f2a4ee6a6164f722162fa45004770a7605

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	# Without -O0, videos cannot be played on x86_64
	CFLAGS="-O0 -pipe" ./configure --prefix=/usr
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
