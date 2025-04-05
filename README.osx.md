# Mac OSX specific instructions

This is an initial release for testing and there's probably plenty of mac specific bugs.  I tested it (briefly) on an x64 mac, I built it for the newer M series macs also, but since I don't have one I can't be sure it works.  Please let me know your experience.

I am not really a mac programmer, so there might be better ways of doing everything that I did to get this working.

Since this is an early release I would not recommend buying Selaco with the belief that you'll be able to play it on the mac, this is really for those people who already own it and want to see it run on their mac.

## Getting it running

You can install the engine and 
You will need a copy of Selaco.ipk3 unfortunately I'm not sure which version matches the source as provided.  The source suggests (in gitinfo.h that it's for version 0.33).  I can't seem to download that version and even when I do download version 0.4 I don't have much luck running that version of the ipk3.  The version that I tested was 0.84.

When you have Selaco.ipk3 copy it to

~/Library/Application Support/Selaco-EA/

You can also place it in the application bundle of course, but if you re-install a new build by copying a new bundle you'll lose your ipk3 file.

If you have a windows PC handy you can get this by using Steam on windows to download Selaco, then copying the Selaco.ipk3 file out and onto your mac.

If you don't have a windows PC handy then you can get this file directly from Steam on the Mac, to download version 0.84 of the ipk3 file

go to the [steam console](steam://nav/console)
issue the command
    download_depot 1592280 1592286 946534964490497901

it will tell you where it's downloaded it, but the path will have some windows backslashes in it that need fixing up, copy that file to the recommended location.

## Building from Source

I have included a build_osx.sh shell script which should act as a hint on how to build.

I build using cmake
    brew install cmake molten-vk

MacPorts is an abomination and the buildscript now installs vcpkg and automatically installs all the dependencies

I wrote a packaging script in python to copy all the required libraries into frameworks and also fixup all the paths in the executable and dylibs, the standard mac version of python should be able to run it, I don't believe it has any library requirements.

## Other

The Materials are provided “as is,” without any express or implied warranty of any kind.  I don't care what happens to your mac if you run this, it's on you.