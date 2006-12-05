# Findutils Makefile

NM= findutils
VRS= 4.2.27
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 0655e10b20dc66b1ccddfa45e5d6c57a3cd312a2

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
	./configure --prefix=$(WD)
	make $(PM)
	make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --libexecdir=/usr/lib/findutils \
	 --localstatedir=/var/lib/locate
	make $(PM)
	make install
	mv -v /usr/bin/find /bin
	sed -i -e 's@BINDIR=/usr/bin@BINDIR=/bin@' /usr/bin/updatedb

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
