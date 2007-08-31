# jhalfs Makefile

NM= jhalfs
VRS= 2.3.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://www.linuxfromscratch.org/alfs/downloads/jhalfs/stable/$(FILE)
SHA-$(FILE)= 95a41e2e1c3ff01feaaefafeda7d187760a24dfe

FILE1= configuration
# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE1)
	@$(call echo_message, Building)
	mkdir -p /home/jhalfs
	cp -v $(ROOT)/root/.bashrc /home/jhalfs/.bashrc
	cd /home/jhalfs ; unpack $(SRC)/$(FILE)
	cp -v $(FILE1) /home/jhalfs/$(DIR)
	chown -R jhalfs:jhalfs /home/jhalfs
	@touch $@

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
