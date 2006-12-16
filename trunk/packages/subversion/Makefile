# Subversion Makefile

NM= subversion
VRS= 1.4.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://subversion.tigris.org/downloads/$(FILE)
SHA-$(FILE)= 349847a97ad790cb14ad15bfd7bfe5bc5a9c8837

FILE2= $(NM)-deps-$(VRS).tar.bz2
URL-$(FILE2)= http://subversion.tigris.org/downloads/$(FILE2)
SHA-$(FILE2)= bbeb782dc725be253f5e41e11a48065c3e0de2c5

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE2)
	$(std_build)

compile-stage2:
	unpack ../$(FILE2) --strip-components=1
	./configure --prefix=/usr --with-ssl \
	 --with-editor=/usr/bin/vim \
	 --with-installbuilddir=/usr/share/apr/build
	make $(PM)
	make install
	install -v -d -m755 /usr/share/doc/$(DIR)
	cp -v -R doc/* /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
