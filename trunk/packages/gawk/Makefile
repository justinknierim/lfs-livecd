# Gawk Makefile

NM= gawk
VRS= 3.1.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= fb45bded207af6a8e46cd63fcbb6fb064ecee607

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)

compile-stage1:
	./configure --prefix=$(WD) ac_cv_func_working_mktime=yes
	make
	make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --libexecdir=/usr/lib ac_cv_func_working_mktime=yes
	make
	make install
	mkdir -v /usr/share/doc/$(DIR)
	cp -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2
