#!/bin/bash

# Script for converting  dorade files to cfradial format
#
# Syntax:
#	$ dorade2cfradial.sh [input_dir] [output_dir]
#
# Example:
#	$ dorade2cfradial.sh . ./output
#
# This script is copied from ~/Github/dorade2cfradial to
# ~/bin as a symbolic link
#
# Raul Valenzuela
# April, 2015

# input directory
#----------------------
INDIR=$1

# output directory
#------------------------
OUTDIR=$2

# parsing
#-------------
if [ "$INDIR" == "." ]; then
	INDIR=$(pwd)
elif [ -z "$INDIR" ];then
	echo "need input directory"
	exit
fi

if [ "$OUTDIR" == "." ]; then
	OUTDIR=$(pwd)
elif [ "${OUTDIR:1}" != " " ];then
	OUTDIR=$(pwd)/${OUTDIR:2}
elif [ -z "$OUTDIR" ];then
	OUTDIR="${INDIR/dorade/cfrad}"
fi

echo
echo " I/O directories"
echo "-----------------------"
echo " Input directory: $INDIR"
echo " Output directory: $OUTDIR"
echo
read -r -p " Do you want to continue? [y/N] " response
if [[ $response =~ ^([nN][oO]|[nN])$ ]]; then
	exit
fi

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
RDXOUT="$(ls -d 200*/)"
cd $RDXOUT
mv * $OUTDIR
cd $OUTDIR
rm -r $RDXOUT
echo
echo " Done"
echo

