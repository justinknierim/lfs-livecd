# CDRTools Makefile

NM= cdrtools
VRS= 2.01
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= f94cfe51dd512d4e0b9106b986bde12d4f7967ce

include $(ROOT)/scripts/functions

stage1: Makefile $(FILE)
	$(std_build)

compile-stage1:
	make INS_BASE=/tools DEFINSUSR=root DEFINSGRP=root
	make INS_BASE=/tools DEFINSUSR=root DEFINSGRP=root install

clean:
	-rm -rf $(DIR)

.PHONY: clean compile-stage1
