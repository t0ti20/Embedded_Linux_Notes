## Quick Overview

In the Development Stage of your Yocto Project guide, you will be working on customizing your Yocto-based Linux distribution. This stage involves several key steps to set up your build environment and create a custom image.

```Bash
/build
├── bitbake-cookerdaemon.log
├── bitbake.lock
├── cache    #cache mainly used to speed up the future build process. 
├── conf
	├── bblayers.conf   #configuration file to control Poky and Bitbake
	├── conf-notes.txt
	├── local.conf      #configuration file to control Poky and Bitbake
	└── templateconf.cfg
├── downloads            #stores all downloaded artifacts, acts as cache
├── sstate-cache
└── tmp
	├── deploy
		├── images
		├── licenses
		└── rpm
	├── sysroots-components  #collection for all sysroots
	├── sysroots-uninative   #used when native utilities are generated.
	├── work  #Used for debugging purpose
	└── rpm
```
### Step 1: Download Layer BSP with the Same Yocto Version

- Visit the OpenEmbedded Layer Index [here](https://layers.openembedded.org/layerindex/branch/master/layers/).
- Download the layer BSP (Board Support Package) that matches the Yocto version you are working with. The layer should be compatible with your target hardware and the Yocto version you've chosen.
### Step 2: Download Dependencies Needed for Your Layer

- Check the layer's documentation or README file to identify any dependencies required for it to work correctly.
- Download and install the necessary dependencies on your development machine.
### Step 3: Update bblayers.conf

- To incorporate the downloaded BSP layer into your Yocto project, you need to update the `bblayers.conf` configuration file.
- You can do this manually by editing the file or use automated commands provided by the Yocto Project to add the layer to your configuration.
### Step 4: Get Machine Name and Update local.conf

- Determine the name of the target machine or board you are working with.
- Update your `local.conf` file with this machine name to specify the target for your custom image.

### Step 5: Get Image Name and Build It Using bitbake

- Identify the name of the custom image you want to build (e.g., a minimal image, a specialized image for your project).
- Use the `bitbake` command to initiate the build process, specifying the image name as one of the build targets.

With these steps, you will set up your Yocto development environment, configure it with the required layers and settings, and initiate the build process for your custom Linux image.

```Bash
#Download meta-raspberrypi Main Layer
git clone -b mickledore git://git.yoctoproject.org/meta-raspberrypi
#Download Dependences
git clone -b mickledore git://git.openembedded.org/openembedded-core #Optional
git clone -b mickledore git://git.openembedded.org/meta-openembedded
#Update Downloadded Layers
nano ./conf/bblayers.conf
#Or
bitbake-layers add-layer ../openembedded-core/meta #Optional
bitbake-layers add-layer ../meta-openembedded/meta-oe
bitbake-layers add-layer ../meta-raspberrypi
#Remove Layer
bitbake-layers remove-layer ../meta-yocto-bsp
#Show All Layers
	bitbake-layers show-layers
#Get Machine Name <raspberrypi4-64>
ls ../meta-raspberrypi/conf/machine/
#Update Machine Name In local.config
nano ./conf/local.conf
#Get Image Name <rpi-test-image.bb>
ls ./meta-raspberrypi/recipes-core/images/
#Build Image 
bitbake rpi-test-image
#Some Kinds Of Errors I Faced 
#ERROR: Nothing RPROVIDES 'linux-firmware-rpidistro-bcm43456'
echo"LICENSE_FLAGS_ACCEPTED += "synaptics-killswitch"">>./build/conf/local.conf
#Check The Output
ls ./tmp/deploy/image
#removes the state information
bitbake -c cleansstate <recipe>
#removes files without affecting rebuild.
bitbake -c clean <recipe>
#cleans up additional files
bitbake -c cleanall <recipe>
##############################################
#Build Config File Commands
#specify a preferred provider for a particular recipe
PREFERRED_PROVIDER_<recipe>
#Change Devsheel Into Terminal
OE_TERMINAL = "screen"
#Select Building Image
MACHINE ??= "raspberrypi4-64"
#Accept License In Not Exist
LICENSE_FLAGS_ACCEPTED += "synaptics-killswitch"
#Select Recipes You Want To Install On Target
IMAGE_INSTALL:append = " <recipe>"
#Execlude Specific Recipe Or Folder
BBMASK:append = "meta-mylayer/recipes-example/<recipe>"
```

## Layer Customization

### 1. Add a New Layer

To add a new layer to your Yocto Project, you can use the `bitbake-layers` command. Here are the steps to create and add a new layer:

- Use the `create-layer` command to create a new layer. This command will generate a directory structure with the required files:


```BASH
bitbake-layers create-layer ../meta-application
```

The directory structure of the new layer should look like this:

```md
meta-application/
├── COPYING.MIT 
├── README ├── conf
│ └── layer.conf
└── recipes-example
	└── example
		└── example_0.1.bb
```

- You can add the newly created layer to your Yocto Project configuration using the `bitbake-layers` command:

```Bash
bitbake-layers add-layer ../meta-application
```

Now your Yocto Project is aware of this new layer, and you can use it to customize your distribution.

### 2. Customize Image Recipes

You can customize image recipes to tailor the output image to your project's requirements. There are two types of image recipes: application recipes and image recipes.
#### Application Recipe:
- An application recipe defines how to build and include a specific application or software component in your image.
- It should include the following information:
    1. `SRC_URI`: The location of the source code for the application.
    2. Dependencies on this source code.
    3. Compilation of dependencies and source code.
    4. Installation of executables in the desired location, such as `/usr/bin`.
For example, in a `.bb` file, you might have:
```bb
SRC_URI = "git://example.com/repo.git" 
DEPENDS = "libxyz"
```
This example specifies the source code location and a dependency on the "libxyz" library.
#### **Image Recipe:
- Image recipes are target-dependent and can be found under the path `/recipes-core/images/`.
- These recipes define what should be included in the final target image.
- Customize image recipes based on your project's requirements.
With these steps, you can create and add new layers to your Yocto Project, customize application and image recipes, and tailor your custom Linux distribution to your specific needs.

### 3. Customize and Create Recipe for Application

To create and customize a Yocto application recipe, it must reside in a layer. Follow these steps:

1. **Create a New Layer:**
```Bash
bitbake-layers create-layer ../meta-application
```

2. **Add the New Layer to bitbake-layers:**
```BASH
bitbake-layers add-layer ../meta-application
```

3. **Create Recipe Using recipetool:**
```BASH
recipetool create -o application.bb <repo_link>
recipetool create -o <name>.bb -S <commip> <repo_link>
recipetool create -o <name>.bb -V <tag> <repo_link>
recipetool create -o <name>.bb -B <branch> <repo_link>
```
Ensure the new layer is recognized by Yocto by updating `layer.conf`
```Bash
# We have recipes-* directories, add to BBFILES
BBFILES += "${LAYERDIR}/recipes-*/*/*.bb \
            ${LAYERDIR}/recipes-*/*/*.bbappend"
```
Folder Structure
```BASH
.
├── COPYING.MIT
├── README
├── conf
│   └── layer.conf
└── recipes-application
    └── helloworld
        └── helloworld.bb
```

4.  **Check for the Added Recipe:**
```bash
#Check For The New Recipe
bitbake-layers show-recipes -l <recipe_name>
#Show All Recipes In Project 
bitbake-layers show-recipes
#Show All Tasks In Recipe
bitbake -c listtasks <recipe_name>
```

#### Recipe Content:
##### 1-Important environment variables:

```bash
#Type of LICENSE Fot This Application
LICENSE = "CLOSED"
#LICENSE CheckSum
LIC_FILES_CHKSUM = ""
#Source URL To Fetch Code
SRC_URI = "git:<Repo_Link>;protocol=https;branch=master"
#Define Version Of THis Application
PV = "1.0+git${SRCPV}"
#Make Compile Tiem Dependences Between Two Recipes
DEPENDS += "<recipe>" #recipe Name or alias PROVIDES
#Make A Compile Time Alias For Recipe
PROVIDES += "<alias>"
#Make RunTime Dependences Between Two Recipes
RDEPENDS += "<recipe>" #recipe Name or alias PROVIDES
#Make A RunTime Time Alias For Recipe
RPROVIDES:${PN} += "<alias>"
#Make onflict Between Two Layers Only One Should Include
RCONFLICTS:${PN} += "<recipe>"
#Source Revision For Getting Commit Number
SRCREV="<CODE>" #Latest="${AUTOREV}"
# Package name.
PN
# Package revision.
PR
#Source Directory
S = "${WORKDIR}/git"
#Root Distination /
D
#Bin Directory
bindir
#C++ Comiler
CXX
#C Comiler
CC
#Local Working Directory Of Current Task </work/<recipe>>
WORKDIR 
#libraries are installed on the target device
libdir
#libraries are staged during the build process
STAGING_LIBDIR
#Make File For Yocto
oe_runmake
#Passing Arguments to Make File
EXTRA_OEMAKE:append = "DESTDIR=${D}"
```

##### 2-Important Tasks in the Recipe:

```bash
#Fetch Source Code From Path
do_fetch () {:}
#After Fetch Task
do_unpack () {:}
#Patch Any Patch File Run After unpack
do_patch () {:}
#Specify any needed configure commands here
do_configure () {:}
#Specify compilation commands here
do_compile () {:}
#Specify install commands here
do_install () {:}
```

In the `do_compile` and `do_install` tasks, define how to compile and install the application.

```BASH
#Configure Compiling Task
do_compile () 
{
	#Compile
	${CXX} *.cpp -o <application_name> #Hello_World
}
#Configure Installing Task
do_install () 
{
	install -d ${D}${bindir}
	install -m 0755 <application_name> ${D}${bindir}
}
```

### 4.Debugging After Building Recipe

```bash
#Get list of all image recipes exists
ls meta*/recipes*/images/*.bb
#OR
bitbake-layers show-recipes 
#Check For Recipe <Variable>
bitbake -e application | grep <Variable>=
#Check For Log Files
bitbake -c devhshell <recipe_name> 
#Do Specific Task In Recipe
bitbake -c do_<task_name> <recipe_name> 
#List All Tasks
bitbake -c listtasks <recipe name>
#Open WORKDIR In Local Files
bitbake -c devhshell <recipe_name>
ls tmp/*
#Check For dependencies
bitbake -v <recipe name> 
#Or Manula
cd /build/tmp/work/cortexa72-poky-linux


```

___
## Layer Dependences

### 1.  Compile Time Dependency  

1. **Introduction:**
    - Consider providing a brief introduction to Yocto and its layer concept for readers who may be less familiar with the framework.
2. **Compile Time Dependency:**
    - Expand on the importance of compile-time dependencies in Yocto, emphasizing that they ensure proper layer order during the build process.
    - You might want to mention that compile-time dependencies are declared in the recipes to ensure that the necessary components are built in the correct order.
3. **Example Explanation:**
    - Provide a bit more detail on the example you've given. Explain why it's important to compile the library (`libPrint.a`) before the application (`Application`).
    - Clarify that the `DEPENDS += "libraries"` line in the application recipe indicates the compile-time dependency on the "libraries" layer.
4. **Code Comments:**
    - Consider adding comments in your example code to explain key sections. For instance, explain the purpose of `${CXX}`, `${AR}`, and the linker flags used in the application recipe.
5. **Run Time Dependency:**
    - It seems like you've left the section on runtime dependencies unfinished. Consider providing information on why runtime dependencies are important, and perhaps include a brief example or reference to where one could find more information on declaring runtime dependencies in Yocto recipes.

```SHELL
#Make The Application And Library Layers
bitbake-layers create-layer ../meta-application
bitbake-layers create-layer ../meta-libraries
#Add Code Recipe
recipetool create -o application.bb <repo_link>
recipetool create -o libraries.bb <repo_link>
###################################################
#In libraries Recipe
SRCREV = "${AUTOREV}"
#DO Compile
${CXX} -c -o Print.o Print.cpp
${AR} rcs libPrint.a Print.o
#Do Install
install -m 0644 ${S}/libPrint.a ${STAGING_LIBDIR}
###################################################
#In Application Recipe
DEPENDS += "libraries" #recipe Name or alias PROVIDES
SRCREV = "${AUTOREV}"
#DO Compile
${CXX} -o Application Main.cpp -L${STAGING_LIBDIR} -lPrint -Wl,--hash-style=gnu
#Do Install
install -d ${D}${bindir}
install -m 0755 Application ${D}${bindir}
```

### 2.  Run Time Dependency  


## Init Manager
A Brief Intro to Init Manager.
What does Init Manager do?
Available Init Managers.
What is SystemD Init Manager?
How to integrate SystemD in Yocto?
Comparison between Init Managers.

how to add in yocto project 
```bash
#In local.conf File
DISTRO_FEATURES:append = " systemd"
VIRTUAL-RUNTIME_init_manager = "systemd"
DISTRO_FEATURES_BACKFILL_CONSIDERED += "sysvinit"
VIRTUAL-RUNTIME_initscripts = "systemd-compat-units"
```