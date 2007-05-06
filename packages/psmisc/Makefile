# Psmisc Makefile

NM= psmisc
VRS= 22.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://easynews.dl.sourceforge.net/sourceforge/psmisc/$(FILE)
SHA-$(FILE)= 0fd6c52dd0dad464a9be7baa79fb810caf43c923

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --exec-prefix=""
	make
	make install
	mv -v /bin/pstree* /usr/bin

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
