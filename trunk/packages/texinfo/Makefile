# Texinfo Makefile

NM= texinfo
VRS= 4.8
DIR= $(NM)-$(VRS)

FILE= $(DIR)a.tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= cde723b115faebb81019154c320e108c5042c906

PATCH1= $(DIR)a-tempfile_fix-1.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 2ead28cb8e2679cdb53e1e4908209f0a31397dfe

PATCH2= $(DIR)a-multibyte-1.patch
URL-$(PATCH2)= $(HTTP)/$(NM)/$(PATCH2)
SHA-$(PATCH2)= b97ae3468c03f8389dbf5c9b6eed64f996f9ed5c

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
	./configure --prefix=$(WD)
	make $(PM)
	make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2)
	$(std_build)
	cp $(SRC)/{$(PATCH1),$(PATCH2)} $(LFSSRC)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	./configure --prefix=/usr
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
