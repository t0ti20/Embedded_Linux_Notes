
## Manual File Creation
### Source Code Syntax

```c
/* Module Structure */
#include <linux/module.h>
/* Initialize Module */
#include <linux/init.h>
/* Adding Parametars */
#include <linux/moduleparam.h>
/* Registeration Files */
#include <linux/fs.h>

/* Set Meta Information  */
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Khaled El-Sayed");
MODULE_DESCRIPTION("LED Driver for controling LED");

/* Read Paramiter While Insertion 'insmod' */
bool State=false;
module_param(State,bool,(S_IRUSR|S_IRGRP|S_IWUSR|S_IWGRP));/*-rw-rw----*/
MODULE_PARM_DESC(State,"LED Stete true|false");

/* Open Function */
static int Open_Driver(struct inode *Device_Inode,struct file *Object){printk("Driver File Opened !");return 0;}
/* CLose Function */
static int CLose_Driver(struct inode *Device_Inode,struct file *Object){printk("Driver File CLosed !");return 0;}
/* FIle Operation */
struct file_operations Led_File ={.owner=THIS_MODULE,.open= Open_Driver,.release=CLose_Driver};

/* Define Major Number Manully */
const int Major_Number=20;

/* Initialization Function For Diver */
static int __init LED_Initialization(void)
{
    int Return_Value=0;
    /* Print Welcome Message */
    printk("Starting LED Driver\n");
    /* Register Char Device */
    if(register_chrdev(Major_Number,"Control_LED",&Led_File)==0)
    {
        printk("Done Registering Char Device (Major=%d | Minor=%d | Function=%s)\n",Major_Number,0,__FUNCTION__);
    }
    else 
    {
        printk("Can't Registering Char Device ! (Function=%s)\n",__FUNCTION__);
        Return_Value=-1;
    }
    return Return_Value;
}

/* Delete Any Initialized Element Before Exit */
void Delete_Registered_Elements(void)
{
    unregister_chrdev(Major_Number,"Control_LED");
}

/* Exit Function For Diver */
static void __exit LED_Exit(void)
{
    /* Delete Registered Devices */
    Delete_Registered_Elements();
    /* Print Exit Message */
    printk("Ending LED Driver\n");
}

/*Initialize Module*/
module_init(LED_Initialization);
/*Delete Module*/
module_exit(LED_Exit);
```

### Manipulating With Node

```bash
#Intert Module
sudo insmod <module_name>.ko
#Get Major Number
cat /proc/devices | grep "Control_LED"
#Make Node
sudo mknod /dev/Control_LED c <major_number> <minor_number>
#Remove Node
sudo rm /dev/Control_LED 
#Remove Module
sudo rmmod <module_name>
```
## Automatic File Creation

```c
/* Module Structure */
#include <linux/module.h>
/* Initialize Module */
#include <linux/init.h>
/* Adding Parametars */
#include <linux/moduleparam.h>
/* Registeration Files */
#include <linux/fs.h>
/* Generate Mojor Number Automatically */
#include <linux/cdev.h>

/* Set Meta Information  */
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Khaled El-Sayed");
MODULE_DESCRIPTION("LED Driver for controling LED");

/* Read Paramiter While Insertion 'insmod' */
bool State=false;
module_param(State,bool,(S_IRUSR|S_IRGRP|S_IWUSR|S_IWGRP));//-rw-rw----
MODULE_PARM_DESC(State,"LED Stete true|false");

/* Open Function */
static int Open_Driver(struct inode *Device_Inode,struct file *Object)
{printk("Driver File Opened !\n");return 0;}
/* CLose Function */
static int CLose_Driver(struct inode *Device_Inode,struct file *Object)
{printk("Driver File CLosed !\n");return 0;}
/* FIle Operation */
struct file_operations Led_File ={.owner=THIS_MODULE,.open=Open_Driver,.release=CLose_Driver};

/* Base Number Of First Device */
#define BASE_NUMBER 0
/* Total Devices Count */
#define DEVICES_COUNT 1
/* To Store Major And Minor Number */
dev_t Device_Number;

/* Character Module File Handlar */
struct cdev Module_File;
/* Character Device Class Handlar */
struct class *Device_Class;
/* Character Device Class Handlar */
struct device *Device_File;

/* Delete Any Initialized Element Before Exit */
void Delete_Registered_Elements(void)
{
    /* Delete Device File */
    device_destroy(Device_Class,Device_Number);
    /* Delete Class File */
    class_destroy(Device_Class);
    /* Delete Module */
    cdev_del(&Module_File);
    /* Delete Registered Char Device */
    unregister_chrdev_region(Device_Number,DEVICES_COUNT);
}

/* Initialization Function For Diver */
static int __init LED_Initialization(void)
{
    int Return_Value=0;
    /* Print Welcome Message */
    printk("Starting LED Driver\n");
    /* Allocate Char Device */
    if(alloc_chrdev_region(&Device_Number,BASE_NUMBER,DEVICES_COUNT,"Control_LED")==0)
    {
        printk("Done Registering Char Device (Major=%d | Minor=%d | Function=%s)\n",MAJOR(Device_Number),MINOR(Device_Number),__FUNCTION__);
        /* Initialization Character Device Module */
        cdev_init(&Module_File,&Led_File);
        /* Create Character Device Module */
        if(cdev_add(&Module_File,Device_Number,DEVICES_COUNT)==0)
        {
            printk("Done Createing Char Module (Major=%d | Minor=%d | Function=%s)\n",MAJOR(Device_Number),MINOR(Device_Number),__FUNCTION__);
            /*Create Class In Order To Create Device File*/
            Device_Class=class_create("Control_LED");
            if(Device_Class!=NULL)
            {
                /* Create File From Class */
                Device_File=device_create(Device_Class,NULL,Device_Number,NULL,"Control_LED");
                if(Device_File!=NULL)
                {
                    printk("Done Createing Device File (Major=%d | Minor=%d | Function=%s)\n",MAJOR(Device_Number),MINOR(Device_Number),__FUNCTION__);
                }
                else
                {
                    printk("Can't Create Device File !\n");
                    Return_Value=-1;
                }
            }
            else
            {
                printk("Can't Create Class File !\n");
                Return_Value=-1;
            }
        }
        else
        {
            printk("Can't Create Char Module File !\n");
            Return_Value=-1;
        }
    }
    else 
    {
        printk("Can't Allocate Memory For Char Device !\n");
        Return_Value=-1;
    }
    if(Return_Value!=0){Delete_Registered_Elements();}
    return Return_Value;
}

/* Exit Function For Diver */
static void __exit LED_Exit(void)
{
    /* Delete Registered Devices */
    Delete_Registered_Elements();
    /* Print Exit Message */
    printk("Ending LED Driver\n");
}

/*Initialize Module*/
module_init(LED_Initialization);
/*Delete Module*/
module_exit(LED_Exit);

```
## Read From File

```c
/* Define Buffer Size */
#define READ_BUFFER_SIZE 255
/* Initialize Reading Buffer */
static unsigned char Read_Buffer[READ_BUFFER_SIZE]="LED Value = ";


/* Read Call Function */
ssize_t Read_Device_File(struct file *Device_File,char __user *User_Data,size_t Read_Bytes_Count,loff_t *Offset)
{
    ssize_t Return=0;
    printk("Reading Data From File\n");
    /* Check For Read Count Size */
    if((Read_Bytes_Count+Offset)>READ_BUFFER_SIZE){Read_Bytes_Count=READ_BUFFER_SIZE-*Offset;}
    /* Copy From Physical Address To Logical Address */
    if(copy_to_user(User_Data,&Read_Buffer[*Offset],Read_Bytes_Count)==0)
    {
        printk("Data has Readded Successfully\n");
    }
    else
    {
        Return=-1;
        printk("Can't Read Whole File\n");
    }
    return Return;
}

/* File Call Operation */
struct file_operations Led_File ={.owner=THIS_MODULE,.open=Open_Device_File,.release=CLose_Device_File,.read=Read_Device_File};

```
## Commands

```bash
#Print all Files for Module
ls -al /sys/module/<modulename>
#Print All Running Modules
lsmod
cat /proc/devices
#Print All Running Classes
ls /sys/class/
#Insert Module To System
insmod <name>.ko
#Remove Module From System
rmmod <name>
#Print Information About Module
modinfo <name>.ko
```

# References

## [1 - Linux Source Code .](https://codebrowser.dev/linux/linux/)