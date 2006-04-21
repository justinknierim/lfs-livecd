# Expat Makefile

NM= expat
VRS= 2.0.0
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://ufpr.dl.sourceforge.net/sourceforge/expat/$(FILE)
SHA-$(FILE)= 9ff011a75a1f5b60145c4afdec520442cb398d93

include $(CROSSVARS)

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) 
	$(std_build)

compile-stage2:
	$(ARCH_CC) ./configure --prefix=/usr $(EXTRA_CONF)
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
