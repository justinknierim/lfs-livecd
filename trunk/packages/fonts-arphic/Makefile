# Arphic fonts Makefile

NM= fonts-arphic
LOCATION= /usr/X11R6/lib/X11/fonts/TTF
BASE= http://cle.linux.org.tw/fonts/Arphic

FILE1= bkai00mp.ttf
FILE2= bsmi00lp.ttf
FILE3= gbsn00lp.ttf
FILE4= gkai00mp.ttf

URL-$(FILE1)= $(BASE)/$(FILE1)
URL-$(FILE2)= $(BASE)/$(FILE2)
URL-$(FILE3)= $(BASE)/$(FILE3)
URL-$(FILE4)= $(BASE)/$(FILE4)

SHA-$(FILE1)= 82fa51badf5eeab60b795d686741b32d46cedc65
SHA-$(FILE2)= f9ac121e172e900b04235039339588200d7e4145
SHA-$(FILE3)= 443db42f54904757ed82622e3896d378fff9e57a
SHA-$(FILE4)= 8f0322c8a1be38e78dd492c2923b2551fd5665c4

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE1) $(FILE2) $(FILE3) $(FILE4)
	cp -Hv $(FILE1) $(FILE2) $(FILE3) $(FILE4) $(LOCATION)
	touch $@

clean:

.PHONY: clean chroot compile-stage2
