# Procps Makefile

NM= procps
VRS= 3.2.7
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= b60567cc6263167fa1a4ff6a5bea26db86022c10

PATCH= $(DIR)-watch_unicode-1.patch
URL-$(PATCH)= $(HTTP)/$(NM)/$(PATCH)
SHA-$(PATCH)= cb3e542c7786d44f8d77d949972dab2cd0d432a9

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH)
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
