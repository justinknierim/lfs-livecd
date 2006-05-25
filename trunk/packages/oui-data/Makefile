# oui-data Makefile

NM= oui-data
VRS= 20060525
DIR= $(NM)-$(VRS)

# The files are tarballed only for the purpose of checking SHA1 sum
FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.linuxfromscratch.org/~alexander/$(FILE)
SHA-$(FILE)= a2fa7b331262781afca3589d81ac94665ce7c399

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
