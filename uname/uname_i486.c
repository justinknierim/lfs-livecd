  /*
	This simple piece of code simply turns your ix86 into a i586 -
	useful if you're cross-compiling for a weaker platform.

	Based on the program contained in the cross compiling hint by
	Daniel Baumann <danielbaumann@linuxmail.org>
	
	Originally Updated to 2.6.x series kernel by Roel Neefs.

	Updated to work with the 2.6.x series kernel driver standards
	by Jim Gifford.

	You will need to create a small Makefile for this module to 
	work.

	cat > Makefile << "EOF"
	obj-m += uname_i586.o
	EOF

	To compile as a module use the following command:

	make -C /usr/src/linux-{version} SUBDIRS=$PWD modules

	You can change the UNAME_DUMB_STEPPING variable to get the following
	results

	2 = 286		3 = 386		4 = 486		5 = 586		6 = 686
	
  */
  
  #include <linux/module.h>
  #include <linux/config.h>
  #include <linux/init.h>
  #include <linux/utsname.h>

  #ifndef UNAME_DUMB_STEPPING
  	#define UNAME_DUMB_STEPPING '4';
  #endif

  static int save;

  static int __init uname_hack_init_module( void )
  	{
  		save = system_utsname.machine[1];
		system_utsname.machine[1] = UNAME_DUMB_STEPPING;
		return( 0 );
	}

  static void __exit uname_hack_cleanup_module( void )
  	{
  		system_utsname.machine[1] = save;
	}

 module_init(uname_hack_init_module);
 module_exit(uname_hack_cleanup_module);

