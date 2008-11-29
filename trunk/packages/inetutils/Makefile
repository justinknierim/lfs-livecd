# Inetutils Makefile

NM= inetutils
VRS= 1.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 825834b94cd387b2d088ef1cfe727de824b9589e

PATCH1= $(DIR)-no_server_man_pages-2.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 55510e7f21a09cb688d9a069b6564df3dfe5abbf

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	sed -i 's@<sys/types.h>@<sys/types.h>\n#include <stdlib.h>@' \
	 libicmp/icmp_timestamp.c
	./configure --prefix=/usr --libexecdir=/usr/sbin \
	--sysconfdir=/etc --localstatedir=/var --disable-ifconfig \
	--disable-logger --disable-syslogd \
	--disable-whois --disable-servers
	make
	make install
	mv -v /usr/bin/ping /bin

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
