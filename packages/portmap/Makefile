# portmap Makefile

NM= portmap
VRS= 5beta
DIR= $(NM)_$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/M-P/$(FILE)
SHA-$(FILE)= c86be29cbbc136ef34b368b2ee7c9a86558e0ecc

PATCH1= $(NM)-$(VRS)-compilation_fixes-3.patch
URL-$(PATCH1)= $(HTTPBLFS)/M-P/$(PATCH1)
SHA-$(PATCH1)= fd70ed5b7aac08421e5a678e4776734b3f26042d

PATCH2= $(NM)-$(VRS)-glibc_errno_fix-1.patch
URL-$(PATCH2)= $(HTTPBLFS)/M-P/$(PATCH2)
SHA-$(PATCH2)= f9451c5a81006a6ae21358c9498ac9d26b93ff4e

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
