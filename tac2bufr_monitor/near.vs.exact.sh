# Go through near-dupes.txt and exact-dupes.txt and eliminate common report
# IDs.  What remains in near-dupes.txt are those near dupe IDs that should be
# eliminated.

# near-dupes.txt generated by:
# grep "near dupe" gdas_dump_06.o1516940.p-cor-air | sort | uniq > near-dupes.txt
# exact-dupes.txt generated by:
# grep "exact dupe" gdas_dump_06.o1516940.p-cor-air | sort | uniq > exact-dupes.txt

#wkdir=/meso/save/$USER/svnwkspc/melchior/tac2bufr_monitor
wkdir=/meso/noscrub/$USER/TAC2BUFR/cor-vs-air
#nearfl=$wkdir/near-dupes.txt
nearfl=$wkdir/near-dupes.txt.p-cor-air
#exactfl=$wkdir/exact-dupes.txt
exactfl=$wkdir/exact-dupes.txt.p-cor-air

cnt=0
cat $nearfl | while read line
do
  rptindex=$(echo $line | cut -f2 -d"-") 
  test=$(grep -o ${rptindex}$ $exactfl)
  if [ -z $test ]; then
    echo "$rptindex not explained!"
    cnt=$((cnt+1))
   echo $cnt
  fi 
done
echo $cnt
