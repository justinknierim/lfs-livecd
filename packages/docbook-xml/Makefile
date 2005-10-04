# DocBook XML DTD Makefile

NM= docbook-xml
VRS= 4.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).zip
URL-$(FILE)= $(HTTPBLFS)/D-E/$(FILE)
SHA-$(FILE)= 7c4d91c82ad3747e1b5600c91782758e5d91c22b

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	mkdir $(DIR)
	cd $(DIR) ; unzip ../$(FILE)
	make -C $(DIR) -f ../Makefile compile-$@
	make clean
	touch $@

compile-stage2:
	../install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
