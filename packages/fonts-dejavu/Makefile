# DejaVu fonts Makefile

NM= dejavu-ttf
VRS= 2.0
DIR= $(NM)-$(VRS)
LOCATION= /usr/share/fonts

FILE= $(DIR).tar.gz
URL-$(FILE)= http://heanet.dl.sourceforge.net/sourceforge/dejavu/$(FILE)
SHA-$(FILE)= dd3025cf27282fb0c5b9579f5546a8c549efe874

# Post-release bugfix for 2.0, should be unneeded after 2.1
FILE1= DejaVuSansMono-BoldOb.ttf
URL-$(FILE1)= http://www.srnet.cz/~stepan/temp/.dejavu/$(FILE1)
SHA-$(FILE1)= afcfd07ee07cf3d1d24c80e4909af83f21329be1

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE1)
	$(std_build)

compile-stage2:
	cp -v ./*.ttf $(LOCATION)
	cp -v ../$(FILE1) $(LOCATION)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
