#!/bin/sh

parts=( base feet leg pintack_small pintack_large pinpeg_small pinpeg_large body dial logo arm_upper arm_lower hand head eye mouth antenna_top antenna_side_bottom antenna_side_top key assembly head_cavity_negative plate1 plate2 plate3 plate4 plate5 plate6 )
# parts=( body )

for part in "${parts[@]}"
do
  mkdir -p ./stl
	echo Building $part...
	openscad -s ./stl/$part.stl -D "part=\"$part\"" bobblehead_bot.scad
done
