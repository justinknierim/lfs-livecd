# Findutils Makefile

NM= findutils
VRS= 4.2.30
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.gnu.org/gnu/findutils/$(FILE)
SHA-$(FILE)= d9f174b67f44bcb5ea3147c8ce313e89d2a900fc

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)

compile-stage1:
	./configure --prefix=$(WD)
	make
	make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --libexecdir=/usr/lib/findutils \
	 --localstatedir=/var/lib/locate
	make
	make install
	mv -v /usr/bin/find /bin
	sed -i -e 's@BINDIR=/usr/bin@BINDIR=/bin@' /usr/bin/updatedb

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
