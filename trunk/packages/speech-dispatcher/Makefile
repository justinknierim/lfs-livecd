# speech-dispatcher Makefile

NM= speech-dispatcher
VRS= 0.6.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.freebsoft.org/pub/projects/speechd/$(FILE)
SHA-$(FILE)= 9350cffa71bb1d960cefe0dae66af5bfe9036570

PATCH1= $(DIR)-host-1.patch
# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	sed -i 	-e 's/LogLevel  3/LogLevel  0/' \
		-e 's/# DefaultLanguage  "en"/DefaultLanguage  "en"/' \
		-e 's/^AddModule/#Addmodule/' \
		-e 's/#\(.*sd_espeak.*\)$$/\1/' \
		-e 's/DefaultModule flite/DefaultModule espeak/' \
		config/speechd.conf.in
	./configure --prefix=/usr --sysconfdir=/etc
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
