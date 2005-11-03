# popt Makefile

NM= popt
VRS= 1.7
DIR= $(NM)-$(VRS)

FILE= $(NM)_$(VRS).orig.tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 631a08bfc4db6a071944bde70144ac3609439915

PATCH1= $(NM)_$(VRS)-5.diff.bz2
URL-$(PATCH1)= $(HTTPBLFS)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 774d7b2ea41128ca8b46bc834f3de1052c4fb9dc

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	bzcat ../$(PATCH1) > ../$(DIR)-5.diff
	patch -Np1 -i ../$(DIR)-5.diff
	./configure --prefix=/usr
	cp configure.in configure.ac
	touch configure.in configure.ac
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)
	-rm -f $(DIR)-5.diff

.PHONY: clean chroot compile-stage2
