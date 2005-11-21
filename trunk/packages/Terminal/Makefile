# Terminal Makefile

NM= Terminal
VRS= 0.2.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.os-works.com/files/projects/terminal/0.2/$(FILE)
SHA-$(FILE)= 8787f574469ec47cba9786d64fa5803fd28dd3b3

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --libexecdir=/usr/sbin
	make $(PM)
	make install
	mkdir /etc/xdg/Terminal
	install -m644 ../terminalrc /etc/xdg/Terminal/terminalrc

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
