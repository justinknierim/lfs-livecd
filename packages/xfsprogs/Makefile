# XFS Progs Makefile

NM= xfsprogs
VRS= 2.8.11
DIR= $(NM)-$(VRS)

FILE=$(NM)_$(VRS)-1.tar.gz
URL-$(FILE)= http://mirrors.sunsite.dk/xfs/download/cmd_tars/$(FILE)
SHA-$(FILE)= 03d0f426848479562f9ce1c5dcb8cb17a150619d

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	unset CFLAGS ; \
	    LOCAL_CONFIGURE_OPTIONS="--enable-static --disable-shared" \
	    OPTIMIZER="$(CFLAGS)" make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
