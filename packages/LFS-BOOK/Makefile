# LFS Book Makefile

NM= LFS-BOOK
VRS= trunk
DIR= $(NM)-$(VRS)-HTML

# Ensure sources match LFS book for "trunk".  Update along with LFS packages.
ifeq ($(VRS),trunk)
REV= 7272
REVPARM= -r $(REV)
endif

URL= svn://svn.linuxfromscratch.org/LFS/$(VRS)/BOOK
FIREFOX_CONFIG= $(ROOT)/root/.mozilla/default/79exklwh.slt/prefs.js

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(PATCH50)
	@$(call echo_message, Building)
	@svn co -q $(REVPARM) $(URL) $(NM)
	@cd $(NM) ; make BASEDIR=../$(DIR)
	cp -av $(DIR) /usr/share
	@sed -i \
	 's@file:///.*index.html@file:///usr/share/$(DIR)/index.html@' \
	 $(FIREFOX_CONFIG)
	@sed -i 's@WWW_HOME=\".*\"@WWW_HOME=\"/usr/share/$(DIR)/index.html\"@' \
	 $(ROOT)/etc/profile
	@make clean >$(DIR)-$@.log 2>&1
	@touch $@

clean:
	-rm -rf $(NM) $(DIR)

.PHONY: clean chroot compile-stage2
