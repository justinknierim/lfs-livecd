# ImLib2 Makefile

NM= imlib2
VRS= 1.2.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://easynews.dl.sourceforge.net/sourceforge/enlightenment/$(FILE)
SHA-$(FILE)= c358aed94f2faf0fb2afcae905c56e8a54c1d763

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	make $(PM)
	make install
	install -d -m755 /usr/share/doc/$(DIR)
	install -m644 doc/{*.gif,index.html} /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
