maintainr
=========

Functions to synchronize package installation and libraries across multiple computers on multiple platforms. This workflow should also make upgrading R on Windows much more straightforward, and allow for the synchronization of packages among versions of R on the same machine or across machines.

The basic workflow is simple, but the idea of the package is to create a way to allow lots of flexibility to users--such as composing and synchronizing an RProfile and Renviron file within R. 

The first step is to get a csv file of installed packages (so it is human readable as well) with the function `save_pkgs()`. Eventually Dropbox will be integrated into the package to allow remote reading and writing of the package list from Dropbox, but until this feature is developed, the user will have to specify a directory to store the package list. 

```
# For example
PATH<-"Path/To/My/Dropbox"
save_pkgs(PATH)
```

After packages have been stored, then the user can restore the installed packages either to a new library (to create a sitewide library for example) or on a new machine, using the following workflow:

```
PATH<-"Path/to/My/Packagefile"

mypkgs<-read_pkgs(PATH)

newLib<-"Path/to/new/pkg_library"

install_pkgs(mypkgs,newLib)

```

After we have installed the packages into a new library, we need to tell R how to find that library. For now, the options to do this are quite limited. The best way is to borrow the code from [Tal Galili](http://stackoverflow.com/questions/1401904/painless-way-to-install-a-new-version-of-r-on-windows) to create a new .Renviron file. Currently this function only allows for a library that is in the parent of the R home directory, but will be updated soon to fix this:

```
set_library()

```



