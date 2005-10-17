# HTML Tidy Makefile

NM= tidy
VRS= 051013
DIR= $(NM)

FILE= $(NM)_src_$(VRS).tgz
URL-$(FILE)= http://tidy.sourceforge.net/src/old/$(FILE)
SHA-$(FILE)= 4bd9268da375a6e51bc028c643d65c53b07e1795

FILE1= $(NM)_docs.tgz
URL-$(FILE1)= http://tidy.sourceforge.net/docs/$(FILE1)
SHA-$(FILE1)= b243d7910ce2fe57a8df27ff8f775e6d397c732d

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-html_$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE1)
	unpack $(FILE1)
	$(std_build)

compile-stage2:
	sh build/gnuauto/setup.sh
	./configure --prefix=/usr
	make $(PM)
	make install
	install -d -m755 /usr/share/doc/tidy
	cp -R htmldoc /usr/share/doc/tidy
	chown -R root:root /usr/share/doc/tidy

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
