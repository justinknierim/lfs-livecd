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

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	sed -i -e "s,^extern char \*malloc();,/* & */," scaffold.c
	make REAL_DAEMON_DIR=/usr/sbin STYLE=-DPROCESS_OPTIONS linux
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
