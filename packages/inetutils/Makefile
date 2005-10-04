# Inetutils Makefile

NM= inetutils
VRS= 1.4.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 53841f98bd32a899461b67c319ec2bb18060d9c5

PATCH1= $(DIR)-no_server_man_pages-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= ccd3c59f9ed4eca6f7a8dffb494ed8916087bc50

PATCH2= $(DIR)-gcc4_fixes-3.patch
URL-$(PATCH2)= $(HTTP)/$(NM)/$(PATCH2)
SHA-$(PATCH2)= 77b063b0fcc15a55e28c18e1b30e1cdf5b1b7d3a

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2)
	$(std_build)
	cp $(SRC)/{$(FILE),$(PATCH1),$(PATCH2)} $(LFSSRC)/

compile-stage2:
	patch -Np1 -i ../$(PATCH2)
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr --libexecdir=/usr/sbin \
	--sysconfdir=/etc --localstatedir=/var \
	--disable-logger --disable-syslogd \
	--disable-whois --disable-servers
	make $(PM)
	make install
	mv /usr/bin/ping /bin

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
