# popt Makefile

# Package versions
NM= inputattach

# RULES

.PHONY: stage2 chroot

chroot:
	@chroot "$(MP)" $(chenv3) 'cd $(ROOT) && make ch-$(NM) $(chbash2)'

stage2:
	@echo ""
	@echo "=====> Building $(NM) in chroot"
	@echo ""
	if [ ! -f /usr/bin/inputattach ] ; then \
	 gcc $(CFLAGS) -D_LINUX_INTERRUPT_H -o inputattach inputattach.c && \
	 install -m 755 inputattach /usr/bin ; fi
