# DocBook XSL Stylesheets Makefile

NM= docbook-xsl
VRS= 1.69.1
OLDVERSIONS= 1.67.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= aaabf0e274609134e187a6c36d2be23f3471f507

FILE1= $(NM)-doc-$(VRS).tar.bz2
URL-$(FILE1)= $(HTTPBLFS)/$(NM)/$(FILE1)
SHA-$(FILE1)= 2844c94d3127a9c517462b6efd9a4a9a38c5d9ba

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE1) install
	$(std_build)

compile-stage2:
	cd .. ; unpack $(FILE1)
	../install $(VRS) $(OLDVERSIONS)
	ln -sf xsl-stylesheets-$(VRS) /usr/share/xml/docbook/xsl-stylesheets-current

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
