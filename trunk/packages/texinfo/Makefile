# Texinfo Makefile

NM= texinfo
VRS= 4.8
DIR= $(NM)-$(VRS)
FILE= $(DIR).tar.bz2

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= b19e906f7220294c1e8b087d583c50f5c4d7c420

PATCH1= $(DIR)-tempfile_fix-2.patch
URL-$(PATCH1)= $(HTTP)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 2ead28cb8e2679cdb53e1e4908209f0a31397dfe

PATCH50= $(DIR)-multibyte-1.patch
URL-$(PATCH50)= $(HTTP)/$(NM)/$(PATCH50)
SHA-$(PATCH50)= b97ae3468c03f8389dbf5c9b6eed64f996f9ed5c

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

stage2: Makefile $(FILE) $(PATCH1) $(PATCH50)
	$(std_build)
	cp $(SRC)/{$(PATCH1),$(PATCH50)} $(LFSSRC)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH50)
	./configure --prefix=/usr
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
