# Iproute2 Makefile

NM= iproute2
ifndef CROSS
DATE= 051007
DIR= $(NM)-$(DATE)
else
VRS= 2.6.14
DATE= 051107
DIR= $(NM)-$(VRS)-$(DATE)
endif

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
ifndef CROSS
SHA-$(FILE)= 1da92131ff9ae59b96beb54f769411a1339dd1b9
else
SHA-$(FILE)= b7042721179ae912044b66711d54773457846abe
endif

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build) 
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
	sed -i '/^TARGETS/s@arpd@@g' misc/Makefile
	chmod u+x configure
	./configure
ifndef CROSS
	make $(PM) SBINDIR=/sbin
else
	make $(PM) CC="gcc $(64FLAGS)" SBINDIR=/sbin
endif
	make SBINDIR=/sbin install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
