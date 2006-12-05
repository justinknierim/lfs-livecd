# Traceroute Makefile

NM= traceroute
VRS= 1.4a12
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= c68ec1b09539a8e9655c138031c3090bda92d5f1

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i -e 's/-o bin/-o root/' Makefile.in
	./configure --prefix=/usr
	make $(PM)
	make install
	make install-man
	mv /usr/sbin/traceroute /usr/bin

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
