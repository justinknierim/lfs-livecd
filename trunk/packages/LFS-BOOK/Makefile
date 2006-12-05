# LFS Book Makefile

NM= LFS-BOOK
VRS= 6.2
DIRBASE= $(NM)-$(VRS)
DIR= $(DIRBASE)-XML
HTMLDIR= $(DIRBASE)-HTML

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.linuxfromscratch.org/lfs/downloads/6.2/$(FILE)
SHA-$(FILE)= 729bcf04d8e4ed0af3c58daf0d289e94d6385052

#REV= 7646
#REVPARM= -r $(REV)
#
#URL= svn://svn.linuxfromscratch.org/LFS/trunk/BOOK

SEAMONKEY_CONFIG= $(ROOT)/root/.mozilla/default/79exklwh.slt/prefs.js

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	@$(call echo_message, Building)
	#@svn co -q $(REVPARM) $(URL) $(DIR)-XML
	tar xf $(FILE)
	@cd $(DIR) ; make BASEDIR=../$(HTMLDIR)
	cp -av $(DIR) $(HTMLDIR) /usr/share
	@sed -i \
	 's@file:///.*index.html@file:///usr/share/$(HTMLDIR)/index.html@' \
	 $(SEAMONKEY_CONFIG)
	@sed -i 's@WWW_HOME=\".*\"@WWW_HOME=\"/usr/share/$(HTMLDIR)/index.html\"@' \
	 $(ROOT)/etc/profile
	@make clean >$(DIR)-$@.log 2>&1
	@touch $@

clean:
	-rm -rf $(NM) $(DIR) $(HTMLDIR)

.PHONY: clean chroot compile-stage2
