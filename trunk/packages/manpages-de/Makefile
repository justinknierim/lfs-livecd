# manpages-de Makefile

NM= manpages-de
VRS= 0.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.infodrom.org/projects/manpages-de/download/$(FILE)
SHA-$(FILE)= 0ab8d3350aca0db90b04aab201bbc3f1b7016375

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	cp -r man? /usr/share/man/de

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
