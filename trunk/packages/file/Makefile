# File Makefile

NM= file
VRS= 4.17
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= e03710a3fcb95db6d0ee9cfcdf88c19a5e525ee4

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
	./configure --prefix=/usr
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
