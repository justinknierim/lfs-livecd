NM= X.org-font
VRS= X11R7.1
URLBASE= http://xorg.freedesktop.org/releases/individual/font

FILE101= encodings-1.0.0.tar.bz2
URL-$(FILE101)= $(URLBASE)/$(FILE101)
SHA-$(FILE101)= daa208a7386ddda28d49de1dba708da9e2c2da79

FILE102= font-bh-ttf-1.0.0.tar.bz2
URL-$(FILE102)= $(URLBASE)/$(FILE102)
SHA-$(FILE102)= c39ba9c60468c1ab1a2efadb84b46df4a94f215e
FLAGS-$(FILE102)= --with-fontdir=/usr/share/fonts

FILE103= font-misc-ethiopic-1.0.0.tar.bz2
URL-$(FILE103)= $(URLBASE)/$(FILE103)
SHA-$(FILE103)= d598b873ea897574b86167a36b4c151f84d22d68
FLAGS-$(FILE103)= --with-otf-fontdir=/usr/share/fonts --with-ttf-fontdir=no

FILE104= font-misc-meltho-1.0.0.tar.bz2
URL-$(FILE104)= $(URLBASE)/$(FILE104)
SHA-$(FILE104)= fb7bb1ef32a1b7eacd2df4c372967706cd730a92
FLAGS-$(FILE104)= --with-fontdir=/usr/share/fonts

ALLFILES= $(foreach FILE,$(sort $(filter FILE%,$(.VARIABLES))),$($(FILE)))

include $(ROOT)/scripts/functions

stage2: Makefile $(ALLFILES)
	$(foreach DIR,$(subst .tar.bz2,,$(ALLFILES)),make FILE=$(DIR).tar.bz2 DIR=$(DIR) $(DIR)-stage2 && ) true

compile-%-stage2:
	./configure --prefix=/usr --sysconfdir=/etc $(FLAGS-$(FILE))
	make
	make install

%-stage2:
	$(std_build)

clean:
	rm -rf *-*/
