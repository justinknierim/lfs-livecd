# xine-lib Makefile

NM= xine-lib
VRS= 1.1.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://easynews.dl.sourceforge.net/xine/$(FILE)
SHA-$(FILE)= f7c865d08991be875eb986dab2640e788946e426

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --with-internal-vcdlibs \
	    --disable-opengl --disable-syncfb --disable-fb --disable-dxr3 \
	    --disable-optimizations \
	    --with-freetype --with-fontconfig --enable-antialiasing
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2