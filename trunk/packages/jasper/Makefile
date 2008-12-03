# JasPer Makefile

NM= jasper
VRS= 1.900.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).zip
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 9c5735f773922e580bf98c7c7dfda9bbed4c5191

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	@$(call echo_message, Building)
	@unzip $(FILE) >$(DIR)-$@.log 2>&1
	@make -C $(DIR) -f ../Makefile compile-$@ >>$(DIR)-$@.log 2>&1
	@make clean >>$(DIR)-$@.log 2>&1
	@touch $@

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc --mandir=/usr/share/man --localstatedir=/var
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
