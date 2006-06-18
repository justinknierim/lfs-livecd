# LFS Book Makefile

NM= LFS-BOOK
VRS= trunk
DIR= $(NM)-$(VRS)

REV= 7646
REVPARM= -r $(REV)

URL= svn://svn.linuxfromscratch.org/LFS/trunk/BOOK
SEAMONKEY_CONFIG= $(ROOT)/root/.mozilla/default/79exklwh.slt/prefs.js

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(PATCH50)
	@$(call echo_message, Building)
	@svn co -q $(REVPARM) $(URL) $(DIR)-XML
	@cd $(DIR)-XML ; make BASEDIR=../$(DIR)-HTML
	cp -av $(DIR)-{XML,HTML} /usr/share
	@sed -i \
	 's@file:///.*index.html@file:///usr/share/$(DIR)-HTML/index.html@' \
	 $(SEAMONKEY_CONFIG)
	@sed -i 's@WWW_HOME=\".*\"@WWW_HOME=\"/usr/share/$(DIR)-HTML/index.html\"@' \
	 $(ROOT)/etc/profile
	@make clean >$(DIR)-$@.log 2>&1
	@touch $@

clean:
	-rm -rf $(NM) $(DIR)-{XML,HTML}

.PHONY: clean chroot compile-stage2
