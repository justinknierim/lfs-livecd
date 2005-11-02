# ppp Makefile

NM= ppp
VRS= 2.4.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 7f3840464639f3575d08f9394cfbce65b1956aa8

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
	cp -a $(ROOT)/etc/ppp /etc
	chown -R 0:0 /etc/ppp

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
