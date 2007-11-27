# Subversion Makefile

NM= subversion
VRS= 1.4.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://subversion.tigris.org/downloads/$(FILE)
SHA-$(FILE)= 7e740c469b61977b7b623642892470207ae64a50

FILE2= $(NM)-deps-$(VRS).tar.bz2
URL-$(FILE2)= http://subversion.tigris.org/downloads/$(FILE2)
SHA-$(FILE2)= e60214d61442544f8563d20bdb139b3e0055690e

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE2)
	$(std_build)

compile-stage2:
	unpack ../$(FILE2) --strip-components=1
	unset VERSION ; ./configure --prefix=/usr --with-ssl \
	 --with-editor=/usr/bin/vim \
	 --with-installbuilddir=/usr/share/apr/build
	unset VERSION ; make
	unset VERSION ; make install
	install -v -d -m755 /usr/share/doc/$(DIR)
	cp -v -R doc/* /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
