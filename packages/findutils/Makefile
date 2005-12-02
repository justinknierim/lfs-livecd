# Findutils Makefile

NM= findutils
VRS= 4.2.26
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 872184285ddb6ca7cb14e0c4c5c6b0bd0629541b

# Targets

include $(ROOT)/scripts/functions

stage1: $(FILE)
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage1:
ifndef CROSS
	./configure --prefix=$(WD)
else
	echo "am_cv_func_working_getline=yes" >> config.cache
	CC="$${CC} $(64FLAGS)" ./configure --prefix=$(WD) \
   	 --host=$(LFS_TARGET) --cache-file=config.cache
endif
	make $(PM)
	make install

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
ifndef CROSS
	./configure --prefix=/usr --libexecdir=/usr/lib/findutils \
	 --localstatedir=/var/lib/locate
else
	CC="gcc $(64FLAGS)" ./configure --prefix=/usr \
    	--libexecdir=/usr/lib64/findutils --localstatedir=/var/lib/locate
endif
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: compile-stage1 clean chroot compile-stage2