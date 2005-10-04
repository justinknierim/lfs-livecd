# HTML Tidy Makefile

NM= tidy
VRS= 050920
DIR= $(NM)

FILE= $(NM)_src_$(VRS).tgz
URL-$(FILE)= http://tidy.sourceforge.net/src/old/$(FILE)
SHA-$(FILE)= eb27b64232bf3272f76dbe9b1cc485d6136e1c15

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
