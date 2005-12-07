# LFS Book Makefile

NM= LFS-BOOK
VRS= trunk
DIR= $(NM)-$(VRS)-HTML

# Ensure sources match LFS book for "trunk".  Update along with LFS packages.
ifeq ($(VRS),trunk)
REV= 7197
REVPARM= -r $(REV)
endif

URL= svn://svn.linuxfromscratch.org/LFS/$(VRS)/BOOK
FIREFOX_CONFIG= $(ROOT)/root/.mozilla/firefox/2qwpcv2u.default/prefs.js

PATCH50= lfs_book-r7197-utf8-1.patch
URL-$(PATCH50)= http://www.linuxfromscratch.org/~alexander/patches/$(PATCH50)
SHA-$(PATCH50)= d2e25ffee4860d06958bb228c431e13c9e42caf9

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
	@cd $(NM) ; patch -Np0 -i ../$(PATCH50) ; make BASEDIR=../$(DIR)-UTF8
	cp -av $(DIR)-UTF8 /usr/share
	@make clean >$(DIR)-$@.log 2>&1
	@touch $@

clean:
	-rm -rf $(NM) $(DIR) $(DIR)-UTF8

.PHONY: clean chroot compile-stage2
