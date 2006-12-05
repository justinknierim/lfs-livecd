# HTML Tidy Makefile

NM= tidy
VRS= 051026
DIR= $(NM)

FILE= $(NM)_src_$(VRS).tgz
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 53be36945344af0c4080c34ebc95728bf8617f1c

FILE1= $(NM)_docs_051020.tgz
URL-$(FILE1)= $(HTTPBLFS)/$(NM)/$(FILE1)
SHA-$(FILE1)= 04988d51267566db6899e8061d9f2e5b58fbeec4

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
