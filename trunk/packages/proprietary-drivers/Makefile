# Makefile for proprietary video drivers

NM= proprietary-drivers
VRS= 3

# NVIDIA legacy driver
FILE1= NVIDIA-Linux-x86-1.0-7182-pkg0.run
URL-$(FILE1)= http://download.nvidia.com/XFree86/Linux-x86/1.0-7182/$(FILE1)
SHA-$(FILE1)= 263244a24eab5334c77afbcda3534dba67fa0e51

# Current NVIDIA driver
FILE2= NVIDIA-Linux-x86-1.0-8762-pkg0.run
URL-$(FILE2)= http://download.nvidia.com/XFree86/Linux-x86/1.0-8762/$(FILE2)
SHA-$(FILE2)= d186a4b31177dad951dcb0f0c15adad06d800962

# ATI FGLRX driver
FILE3= ati-driver-installer-8.26.18-x86.run
URL-$(FILE3)= http://www2.ati.com/drivers/linux/$(FILE3)
SHA-$(FILE3)= 5c84a8d3526accccb0154c9d701948629f7ae45d

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE1) $(FILE2) $(FILE3)
	@install -m755 $(FILE1) $(FILE2) $(FILE3) $(LFSSRC)
	@touch $@

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot
