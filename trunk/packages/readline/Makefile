# Readline Makefile

NM= readline
VRS= 5.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 4b2ee2bc9c6dd1d238c84a58f7e6db173600b850

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
	./configure --prefix=/usr --libdir=/lib
	make $(PM) SHLIB_LIBS=-lncurses
	make install
	chmod 755 /lib/lib{readline,history}.so*
	mv /lib/lib{readline,history}.a /usr/lib
	rm /lib/lib{readline,history}.so
	ln -sf ../../lib/libreadline.so.5 /usr/lib/libreadline.so
	ln -sf ../../lib/libhistory.so.5 /usr/lib/libhistory.so

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
