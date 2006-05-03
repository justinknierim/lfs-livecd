/* Simple event recorder */
#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <argz.h>

int main(int argc, char * argv[])
{
	char * envar;
	char * envz;
	size_t len;
	int bug;
	bug = open("/dev/bug", O_WRONLY | O_APPEND);
	if (bug == -1)
		return 0;

	/* Ignore everything USB-related to avoid spamming the list */
	envar = getenv("PHYSDEVPATH");
	if (envar && strstr(envar, "usb"))
		return 0;
	envar = getenv("DEVPATH");
	if (envar && strstr(envar, "usb"))
		return 0;
	
	setenv("_SEPARATOR", "--------------------------------------", 1);
	argz_create(environ, &envz, &len);
	argz_stringify(envz, len, '\n');
	envz[len-1]='\n';
	write(bug, envz, len);
	close(bug);
	free(envz);
	return 0;
}
