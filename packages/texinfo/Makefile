# Texinfo Makefile

NM= texinfo
VRS= 4.9
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnu.org/texinfo/$(FILE)
SHA-$(FILE)= 19a0cc0b56cbfcfe610925bef31e0bdf749492c9

PATCH1= $(DIR)-tempfile_fix-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/lfs/development/$(PATCH1)
SHA-$(PATCH1)= 2ead28cb8e2679cdb53e1e4908209f0a31397dfe

PATCH2= $(DIR)-multibyte-1.patch
URL-$(PATCH2)= http://www.linuxfromscratch.org/patches/lfs/development/$(PATCH2)
SHA-$(PATCH2)= b97ae3468c03f8389dbf5c9b6eed64f996f9ed5c

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)

compile-stage1:
	./configure --prefix=$(WD)
	make
	make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	./configure --prefix=/usr
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
