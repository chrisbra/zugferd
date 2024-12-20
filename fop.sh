#!/bin/sh

# You need java and apache-fop installed 
# also needed: MSYS2 and ghostscript:
# Install using: pacman -S mingw-w64-x86_64-ghostscript
# export PATH, add fop and java to it
#
# for Windows
# PATH=$PATH:/C/ProgramData/Oracle/Java/javapath:/c/users/cb14508/Downloads/fop-2.4-bin/fop-2.4/fop

# fop.cmd $@

./fop-2.10/fop/fop $@
