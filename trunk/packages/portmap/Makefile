# portmap Makefile

NM= portmap
VRS= 5beta
DIR= $(NM)_$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= c86be29cbbc136ef34b368b2ee7c9a86558e0ecc

PATCH1= $(NM)-$(VRS)-compilation_fixes-3.patch
URL-$(PATCH1)= $(HTTPBLFS)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= b7a2f3828026309fccc3e688d4e0dfe328163a54

PATCH2= $(NM)-$(VRS)-glibc_errno_fix-1.patch
URL-$(PATCH2)= $(HTTPBLFS)/$(NM)/$(PATCH2)
SHA-$(PATCH2)= 6de7af3aae51d03bd5781767e0b6b09b36eeaee5

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
