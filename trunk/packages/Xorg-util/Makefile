NM= X.org-util
VRS= X11R7.1
URLBASE= http://xorg.freedesktop.org/releases/individual/util

FILE101= util-macros-1.1.1.tar.bz2
URL-$(FILE101)= $(URLBASE)/$(FILE101)
SHA-$(FILE101)= c1ad23bbdd3c087e061000ae998401b671686406

FILE102= gccmakedep-1.0.2.tar.bz2
URL-$(FILE102)= $(URLBASE)/$(FILE102)
SHA-$(FILE102)= a3d971a507a460233afd8ed46e9f06135fed634d

ALLFILES= $(foreach FILE,$(sort $(filter FILE%,$(.VARIABLES))),$($(FILE)))

include $(ROOT)/scripts/functions

stage2: Makefile $(ALLFILES)
	$(foreach DIR,$(subst .tar.bz2,,$(ALLFILES)),make FILE=$(DIR).tar.bz2 DIR=$(DIR) $(DIR)-stage2 && ) true

compile-%-stage2:
	./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var
	make
	make install

%-stage2:
	$(std_build)

clean:
	rm -rf *-*/
