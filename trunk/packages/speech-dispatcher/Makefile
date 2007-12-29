# speech-dispatcher Makefile

NM= speech-dispatcher
VRS= 0.6.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.freebsoft.org/pub/projects/speechd/$(FILE)
SHA-$(FILE)= 5f2cd4964bf96e49e41bc6fe908f8f482f9ea0e7

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i 	-e 's/LogLevel  3/LogLevel  0/' \
		-e 's/# DefaultLanguage  "en"/DefaultLanguage  "en"/' \
		-e 's/^AddModule/#Addmodule/' \
		-e 's/#\(.*sd_espeak.*\)$$/\1/' \
		config/speechd.conf.in
	./configure --prefix=/usr --sysconfdir=/etc
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
