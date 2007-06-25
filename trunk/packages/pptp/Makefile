# pptp Makefile

NM= pptp
VRS= 1.7.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://kent.dl.sourceforge.net/sourceforge/pptpclient/$(FILE)
SHA-$(FILE)= cc2e4f40c5e3316bede41ec0a092a32025682851

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	make OPTIMIZE="$(CFLAGS)"
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
