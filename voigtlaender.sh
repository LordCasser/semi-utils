#!/bin/sh
exifTool=`which exiftool`

if [ $# -eq 0 ]
	  then
		      echo "No arguments supplied"
		      echo "Please input the path to a directory of photos"
		      echo "Eg. ./v.sh ~/Pictures/myPhotos"
		      exit
fi

for file in $1/*; do 
	  if [[ "$file" == *.DNG || "$file" == *.dng || "$file" == *.jpg || "$file" == *.JPG || "$file" == *.png || "$file" == *.PNG  || "$file" == *.jpeg || "$file" == *.JPEG ]]; 
		                then
	inputLens=`$exifTool -Lens $file`

	case $inputLens in

	  "Lens                            : Summicron-M 1:2/35 ASPH.")
		Lens="Ultron VM 35mm f/2 Aspherical"
	    ;;

	  "Lens                            : Summicron-APO-M 1:2/35 ASPH.")
		Lens="APO-LANTHAR VM 35mm f/2 Aspherical"
	    ;;

	  "Lens                            : Summilux-M 1:1.4/35 ASPH.")
		Lens="Nokton VM 35mm f/1.5 Aspherical II MC"
	    ;;

	  "Lens                            : Summicron-APO-M 1:2/50 ASPH.")
		Lens="APO-LANTHAR VM 50mm f/2 Aspherical"
	    ;;

	  "Lens                            : Summilux-M 1:1.4/50 ASPH.")
		Lens="Nokton VM 50mm f/1.5 Aspherical II MC"
	    ;;

		"Lens                            : 40mm f/1.2")
		Lens="Nokton Z 40mm f/1.2 Aspherical"
	    ;;


	  *)
		echo "unknown lens detected: $inputLens"
		# echo "exiting on file $file"
		continue
	    ;;
	esac

	$exifTool -Lens="$Lens" -LensModel="$Lens" -LensID="" -LensMake="Voigtländer" -m -overwrite_original_in_place $file -v0
  else
	  echo "Skipping $file"
	  fi
done
