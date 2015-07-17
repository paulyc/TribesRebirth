#==============================================================================
#    
#  MakeFile.mak for Phoenix Tools
#    
#  (c) Copyright 1997, Dynamix Inc.   All rights reserved.
#
#==============================================================================

PhoenixObj =.
OBJdest    =.
LIBdest    =.
EXEdest    =.
ARTdir     =.
DATdir     =.

%if !%exists($(PhoenixMake)\Builtins.Mak)
   %abort 1 Error: Environment var "PhoenixMake" not set. Set to Phoenix\Makes directory
   @-md $(var)
%endif
%include <$(PHOENIXMAKE)\builtins.mak>

%set PRECOMPILED_HEADER=

#==========================================================================
# Build Phoenix Tools and Utilities

TOOLS =         \
   BATool       \
   DMLMake      \
   FontEdit     \
   mpMerger     \
   ObjStrip     \
   picaNew      \
   tag2bin      \
   TexMix       \
   TexTable     \
   Vt           \
   PalTool      \
   
# PalTool compiles, and will view palette[0], but no saving or modification

# currently broken
#   wsock        \

# obsolete tools
#   ALPHAMAP     \      # obsoleted by pica & mpal
#   DynaColor    \      # obsoleted by pica & mpal
#   23DS         \      # requires much older version of TS
#   Cdump        \      # requires older version of classio
#   Dt2          \      # requires older version of classio
#   IConvert     \      # very old code, many unresolved headers
#   MipView      \      # only mipmake.exe part compiles
#   Palmap       \      # requires very old version of Phoenix
#   Show         \      # requires older version of TS
#   GUIEdit      \      # requires older version of event library
#   StampTool    \
#   picanew      \      # replaced by picaNew
#   mpal         \      # replaced by mpMerger
#   MipView      \      # mipmaps generated by picaNew now

# requires MSVC++ IDE
#   Matilda     \
#   Mcu         \
#   zed         \


#==========================================================================
#--------------------------------------------------------------------------
# Build the entire project
#--------------------------------------------------------------------------
#==========================================================================

all: $(TOOLS)

copy:

#==========================================================================

$(TOOLS) .MAKE .ALWAYS .MISER:
   %if %exists($(.TARGET)) 
	   @%chdir $(.TARGET)
	   @make $(MFLAGS)
	   @%chdir $(MAKEDIR)
   %endif

