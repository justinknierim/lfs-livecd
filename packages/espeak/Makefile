# espeak Makefile

NM= espeak
VRS= 1.29
DIR= $(NM)-$(VRS)-source

FILE= $(DIR).zip
URL-$(FILE)= http://easynews.dl.sourceforge.net/sourceforge/espeak/$(FILE)
SHA-$(FILE)= 272e7f1980a35a360ff321ca739e07f652dd94f6

# Russian file is not downloaded because espeak mispronounces many words
# (because it doesn't know about "hard" and "soft" consonants)
# and Russian is thus unusable at this time, even with this file.
# http://espeak.sourceforge.net/data/russian_data.zip
#
# Chinese file is not downloaded because Chinese cannot be used in
# Linux console.
# http://espeak.sourceforge.net/data/zhy_list.zip

PATCH1= espeak-1.29-dont-crash.patch

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	@$(call echo_message, Building)
	@unzip $(FILE) >$(DIR)-$@.log 2>&1
	@make -C $(DIR) -f ../Makefile compile-$@ >>$(DIR)-$@.log 2>&1
	@make clean >>$(DIR)-$@.log 2>&1
	@touch $@

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	# Remove dependency on portaudio
	sed -i s/-lportaudio// src/Makefile
	sed -i /USE_PORTAUDIO/d src/speech.h
	# Don't install the crippled "espeak" executable and static library
	# install only shared library, headers and data
	sed -i '/INSTALL.*BIN2_NAME/d' src/Makefile
	sed -i '/INSTALL.*STATIC/d' src/Makefile
	make -C src
	make -C src install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
