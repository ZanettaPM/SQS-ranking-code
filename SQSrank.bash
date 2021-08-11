#!/bin/bash

cur_path=$PWD



echo Please enter the name of your cif-file
read cifname
echo running $cifname


echo Please enter the size of the unit cell ex 2x2x1
read varname
echo running $varname

echo Please enter the cutoff distance
read cutd


cells=( $varname )


for i in "${cells[@]}"
do
  rm -rf cell_$i
  mkdir cell_$i
  ./supercell -i $cifname -s $i -m -v 2 -o cell_$i/$cifname _c${i} > cell_$i/cell_${i}.out 2>&1  &
done
wait
 

for i in "${cells[@]}"
do
  cd ${cur_path}
  sqsf="${cur_path}/SQS-$i"
  echo -ne "cfg" > $sqsf 

  echo "" >> $sqsf
  
  for j in cell_${i}/*.cif
  do
    
    pth=`dirname $j`/`basename $j .cif`
    name=`basename $j .cif`

    echo -n $j >> $sqsf
    
    cd ${cur_path}
    rm -rf $pth
    mkdir -p $pth
    mv `dirname $j`/$name.cif $pth/$name.cif
    cd $pth 

    cp ${cur_path}/convert.py convert.py 
    cp ${cur_path}/lat.in lat.in
    
         

    x=$(grep -Eo '[0-9]' <<< $varname | awk 'NR==1' )
    y=$(grep -Eo '[0-9]' <<< $varname | awk 'NR==2' )
    z=$(grep -Eo '[0-9]' <<< $varname | awk 'NR==3' )

    python -W ignore convert.py $x $y $z

    
    sed -i "/^$/d" sqs.out
    sed -i "s/None//g" sqs.out



    
    corrdump -noe -2= $cutd -l=lat.in -s=sqs.out > tcorrfinal.out


    cr=`cat tcorrfinal.out`
    echo -ne "\t$cr" >> $sqsf
    echo "" >> $sqsf
  done 
done
