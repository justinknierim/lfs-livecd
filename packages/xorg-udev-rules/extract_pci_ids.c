#include <stdio.h>
#include <string.h>
#include <dlfcn.h>
#include <xorg/xf86str.h>

char driver_name[128];

DriverPtr GetDriverRec(char *drvname, void *handle)
{
	char mdsym[128];
	XF86ModuleData * md;
	DriverRec *result;
	sprintf(mdsym, "%sModuleData", drvname);
	md = dlsym(handle, mdsym);
	md->setup(&result, NULL, NULL, NULL);
	return result;
}

void WriteUdevRule(const char *comment, int vendor, int device)
{
	if ((vendor == 0) || (vendor == 0xff) || (vendor == 0xffff))
		return;
	if ((device == 0) || (device == 0xffff))
		return;
	printf("# %s\n"
		"ATTR{vendor}==\"0x%04x\", "
		"ATTR{device}==\"0x%04x\", "
		"RUN+=\"/bin/sed -i s/vesa/%s/ /etc/X11/xorg.conf\"\n\n",
		comment, vendor, device, driver_name);
}

int main(int argc, char *argv[])
{
	void *handle;
	char driver[128];
	char drvname[128];
	char *pos;
	DriverPtr drv;

	strcpy(driver, argv[1]);
	strcpy(drvname, argv[1]);
	pos = strstr(drvname, "_drv.so");
	if (!pos) {
		/* This file is not a driver */
		return 0;
	}
	*pos = 0;
	pos = strrchr(drvname, '/');
	if (pos)
		strcpy(driver_name, pos + 1);
	else
		/* dlopen would fail anyway */
		return 0;

	/* radeon and r128 should not be used directly,
	   and sisusb is too different */
	if (!strcmp(driver_name, "radeon"))
		return 0;
	if (!strcmp(driver_name, "r128"))
		return 0;
	if (!strcmp(driver_name, "sisusb"))
		return 0;

	handle = dlopen(driver, RTLD_LAZY);
	if (!handle) {
		/* this driver is not interesting anyway */
		return 0;
	}
	drv = GetDriverRec(driver_name, handle);
	if (!strcmp(driver_name, "nv")) {
		drv->Identify(1);
	} else if (!strcmp(driver_name, "ati")) {
		Bool (*Probe)(struct _DriverRec *drv, int flags);
		Probe = dlsym(handle, "R128Probe");
		Probe(drv, 1);
		Probe = dlsym(handle, "RADEONProbe");
		Probe(drv, 1);
	} else {
		drv->Probe(drv, 1);
	}
	dlclose(handle);
	return 0;
}

/* Stubs that are called by Xorg drivers from Probe and Identify functions */
unsigned char byte_reversed[256];

pointer XNFalloc(unsigned long amount)
{
	return malloc(amount);
}

unsigned short StandardMinorOpcode(void * client)
{
	return 1;
}

void xf86ErrorFVerb()
{
}

void xf86AddDriver(DriverPtr drv, void * module, int unknown)
{
	DriverPtr *dest = module;
	*dest = drv;
}

int xf86MatchDevice()
{
	return 1;
}

void * xf86GetPciVideoInfo()
{
	static void* dummy = NULL;
	return &dummy;
}

void *xf86GetPciConfigInfo(void)
{
	static void* dummy = NULL;
	return &dummy;
}

void LoaderRefSymLists(const char ** dummy, ...)
{
}

void xf86LoaderRefSymLists(const char ** dummy, ...)
{
}

void xf86MsgVerb(MessageType type, int verb, const char *format, ...)
{
}

void Xfree(void * ptr)
{
}

int xf86MatchPciInstances(const char *driverName, int vendorID,
                      SymTabPtr chipsets, PciChipsets *PCIchipsets,
                      GDevPtr *devList, int numDevs, DriverPtr drvp,
                      int **foundEntities)
{
	const char *comment;
	while (PCIchipsets->PCIid != -1) {
		SymTabPtr chips = chipsets;
		while (chips->token != -1) {
			if (chips->token == PCIchipsets->numChipset)
				comment = chips->name;
			chips++;
		}
		if (!vendorID)
			vendorID = PCIchipsets->PCIid >> 16;
		WriteUdevRule(comment, vendorID, PCIchipsets->PCIid & 0xffff);
		PCIchipsets++;
	}
	return 0;
}

void xf86PrintChipsets(const char *drvname, const char *drvmsg,
                       SymTabPtr chips)
{
	while(chips->token != -1) {
		WriteUdevRule(chips->name,
		    chips->token >> 16, chips->token & 0xffff);
		chips++;
	}
}

int xf86MatchIsaInstances(const char *driverName, SymTabPtr chipsets,
                          IsaChipsets *ISAchipsets, DriverPtr drvp,
                          FindIsaDevProc FindIsaDevice, GDevPtr *devList,
                          int numDevs, int **foundEntities)
{
	return 0;
}

pointer xf86LoadDrvSubModule(DriverPtr drv, const char *name)
{
	return NULL;
}

Bool xf86ServerIsOnlyDetecting(void)
{
	return TRUE;
}
