# man-pages-it Makefile

NM= man-pages-it
VRS= 0.3.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.pluto.it/pub/pluto/ildp/man/$(FILE)
SHA-$(FILE)= e5014f209afddaf2e468f1b28446b9acf9facd55

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	@mkdir $(DIR)
	@cd $(DIR) ; unpack ../$(FILE)
	@make -C $(DIR) -f ../Makefile compile-$@ >>$(DIR)-$@.log 2>&1
	@make clean

compile-stage2:
	cp -r man? /usr/share/man/it

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
