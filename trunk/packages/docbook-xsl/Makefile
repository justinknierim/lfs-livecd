# DocBook XSL Stylesheets Makefile

NM= docbook-xsl
VRS= 1.71.1
OLDVERSIONS= 1.69.1 1.67.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= de7199a9e55ced7a2a212e9902eff747103e4a24

FILE1= $(NM)-doc-$(VRS).tar.bz2
URL-$(FILE1)= $(HTTPBLFS)/$(NM)/$(FILE1)
SHA-$(FILE1)= 2ef6945d5caeb17bd3a0d7ad706b53fa97265a36

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
