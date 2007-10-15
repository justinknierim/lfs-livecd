# LFS Book Makefile

NM= LFS-BOOK
VRS= 6.3
DIRBASE= $(NM)-$(VRS)
DIR= $(DIRBASE)-XML
HTMLDIR= $(DIRBASE)-HTML

#FILE= $(DIR).tar.bz2
#URL-$(FILE)= http://www.linuxfromscratch.org/lfs/downloads/6.2/$(FILE)
#SHA-$(FILE)= 729bcf04d8e4ed0af3c58daf0d289e94d6385052

ifeq ($(CD_ARCH),x86)
URL= svn://svn.linuxfromscratch.org/LFS/tags/6.3/BOOK@8348
endif
ifeq ($(CD_ARCH),x86_64)
URL= svn://svn.linuxfromscratch.org/LFS/branches/x86_64/BOOK@8276
endif

SEAMONKEY_CONFIG= $(ROOT)/root/.mozilla/default/79exklwh.slt/prefs.js

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	@$(call echo_message, Building)
	@mkdir tmp
	@make CROSSVARS=../$(CROSSVARS) -C tmp -f ../Makefile compile-$@ >$(DIR)-$@.log 2>&1
	@make clean >>$(DIR)-$@.log 2>&1
	@touch $@

compile-stage2:
	svn co $(URL) $(DIR)
	# tar xf $(FILE)
	cd $(DIR) ; make BASEDIR=../$(HTMLDIR) RENDERTMP=.
	rm $(DIR)/lfs-full.xml $(DIR)/lfs-html.xml
	cp -av $(DIR) $(HTMLDIR) /usr/share
	cd $(SRC) ; cp -v `sed 's@^.*/\([^/]*\)$$@\1@' /usr/share/$(HTMLDIR)/wget-list` $(LFSSRC)
	sed -i \
	 's@file:///.*index.html@file:///usr/share/$(HTMLDIR)/index.html@' \
	 $(SEAMONKEY_CONFIG)
	sed -i 's@WWW_HOME=\".*\"@WWW_HOME=\"/usr/share/$(HTMLDIR)/index.html\"@' \
	 $(ROOT)/etc/profile

clean:
	-rm -rf tmp
	-rm -rf $(ROOT)/root/tmp

.PHONY: clean chroot compile-stage2
