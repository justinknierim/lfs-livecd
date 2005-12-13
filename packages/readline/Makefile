# Readline Makefile

NM= readline
VRS= 5.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 06fb3e314e43140f8d7d1b5ce1d8cc3f6af151f3

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
ifndef CROSS
	./configure --prefix=/usr --libdir=/lib
else
	CC="gcc $(64FLAGS)" CXX="g++ $(64FLAGS)" \
   	 ./configure --prefix=/usr --libdir=/lib64
endif
	make $(PM) SHLIB_LIBS=-lncurses
	make install
ifndef CROSS
	chmod 755 /lib/lib{readline,history}.so*
	rm /lib/lib{readline,history}.so
	ln -sf ../../lib/libreadline.so.5 /usr/lib/libreadline.so
	ln -sf ../../lib/libhistory.so.5 /usr/lib/libhistory.so
else
	chmod 755 /lib64/lib{readline,history}.so*
	mv /lib64/lib{readline,history}.a /usr/lib64
	rm /lib64/lib{readline,history}.so
	ln -sf ../../lib64/libreadline.so.5 /usr/lib64/libreadline.so
	ln -sf ../../lib64/libhistory.so.5 /usr/lib64/libhistory.so
endif

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
