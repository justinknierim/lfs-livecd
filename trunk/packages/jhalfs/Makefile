# jhalfs Makefile

NM= jhalfs
VRS= 1.0
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.linuxfromscratch.org/alfs/downloads/jhalfs/stable/$(FILE)
SHA-$(FILE)= e153315fe642b76095356cccd22ea828b688a799

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	cp -av . /root/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
