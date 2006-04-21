# Subversion Makefile

NM= subversion
VRS= 1.3.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= f8d670a0ae931fca17192d02862aa93a229e5dda

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	$(ARCH_CC) ./configure --prefix=/usr --with-ssl --without-berkeley-db $(EXTRA_CONF)
	make $(PM)
	make install
	install -v -d -m755 /usr/share/doc/$(DIR)
	cp -v -R doc/* /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
