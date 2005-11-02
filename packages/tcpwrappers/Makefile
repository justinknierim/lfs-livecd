# tcpwrappers Makefile

NM= tcpwrappers
VRS= 7.6
DIR= tcp_wrappers_$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/tcp_wrappers/$(FILE)
SHA-$(FILE)= 1b76da674d6557542b3cda5c55822ed7f1379127

PATCH1= tcp_wrappers-$(VRS)-shared_lib_plus_plus-1.patch
URL-$(PATCH1)= $(HTTPBLFS)/tcp_wrappers/$(PATCH1)
SHA-$(PATCH1)= 915652d43c57f346d6f0a14eeaf706bbfed98ffa

PATCH2= tcp_wrappers-$(VRS)-gcc34-1.patch
URL-$(PATCH2)= $(HTTPBLFS)/tcp_wrappers/$(PATCH2)
SHA-$(PATCH2)= 33ff5cb9d8d0c6a4baa1b31334613ec4781b4c30

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	make $(PM) REAL_DAEMON_DIR=/usr/sbin STYLE=-DPROCESS_OPTIONS linux
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
