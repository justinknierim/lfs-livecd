# oui-data Makefile

NM= oui-data
VRS= 20061014
DIR= $(NM)-$(VRS)

# The files are tarballed only for the purpose of checking SHA1 sum
FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.linuxfromscratch.org/~alexander/$(FILE)
SHA-$(FILE)= 840ac1246df87b754a76ef0598f1d84aeda5cb7e

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	install -d /usr/share/oui-data
	install -m644 *.txt /usr/share/oui-data

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
