# DejaGNU Makefile

NM= dejagnu
VRS= 1.4.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= c50655b800ad27be60aed5546495e3154ffce9b2

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
