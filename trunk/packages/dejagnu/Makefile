# DejaGNU Makefile

NM= dejagnu
VRS= 1.4.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= fd82ffd396eba5b595f76d2f4a068cb7fcc6cffb

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
	./configure --prefix=$(WD)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot
