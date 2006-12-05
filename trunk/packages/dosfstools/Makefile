# dosfstools Makefile

NM= dosfstools
VRS= 2.11
DIR= $(NM)-$(VRS)

FILE= $(DIR).src.tar.gz
URL-$(FILE)= http://ftp.uni-erlangen.de/pub/Linux/LOCAL/dosfstools/$(FILE)
SHA-$(FILE)= b0d8714475ca7c7a96a46adf7c4839d69ce2f412

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
