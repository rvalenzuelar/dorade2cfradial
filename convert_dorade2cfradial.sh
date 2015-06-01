#!/bin/bash


# input directory
#----------------------
INDIR="$HOME/P3_v2/dorade/c03/leg03_all"


# output directory
#------------------------
OUTDIR="${INDIR/dorade/cfrad}"

# if outdir does not exit, create it
#----------------------------------------------------
if [ ! -d $OUTDIR ]; then
	mkdir -p $OUTDIR
fi

cd $INDIR
echo
echo " Running RadxConvert"
RadxConvert -f swp* -cfradial -outdir $OUTDIR
echo " Saving files in $OUTDIR"
cd $OUTDIR
RDXOUT="$(ls -d 2*/)"
cd $RDXOUT
mv * $OUTDIR
cd $OUTDIR
rm -r $RDXOUT
echo
echo " Done"
echo