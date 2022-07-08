# Monitor b004/xx003 from previous 10 days to get a baseline idea for 
# "typical" counts from reporting aircraft

# Run gsb to split bufr_d file into constituents
# gsb /com/gfs/prod/gdas.${dtg}/gdas1.t${cyc}z.aircft.tm00.bufr_d
# output writes to /stmpp1/$USER/sb

# Run ue on split_NC004003 to list out ACID
# ue /stmpp1/Shelley.Melchior/sb/split_NC004003 "ACID | " quiet
# output writes to cwd/ufbtab_example.out

# parse through ufbtab_example.out to gather report counts

# generate temp space
tempsvdir=/stmpp1/$USER/tac2bfr_monitor
rm -rf $tempsvdir
if [ ! -d /stmpp1/$USER/tac2bfr_monitor ]; then
  mkdir -p /stmpp1/$USER/tac2bfr_monitor
fi

# set up array for "10 days ago"
array10da=('20141027' '20141028' '20141029' '20141030' '20141031' \
           '20141101' '20141102' '20141103' '20141104')

for dtg in "${array10da[@]}"
do
  gsb /com/gfs/prod/gdas.${dtg}/gdas1.t00z.aircft.tm00.bufr_d
  cp /stmpp1/$USER/sb/split_NC004003 $tempsvdir/NC004003.${dtg}00
  gsb /com/gfs/prod/gdas.${dtg}/gdas1.t06z.aircft.tm00.bufr_d
  cp /stmpp1/$USER/sb/split_NC004003 $tempsvdir/NC004003.${dtg}06
  gsb /com/gfs/prod/gdas.${dtg}/gdas1.t12z.aircft.tm00.bufr_d
  cp /stmpp1/$USER/sb/split_NC004003 $tempsvdir/NC004003.${dtg}12
  gsb /com/gfs/prod/gdas.${dtg}/gdas1.t18z.aircft.tm00.bufr_d
  cp /stmpp1/$USER/sb/split_NC004003 $tempsvdir/NC004003.${dtg}18
done

cd $tempsvdir
for file in *; do
  echo $file
  ue $file "ACID | " quiet
  cp ufbtab_example.out ${file}.ue.out
  cat ${file}.ue.out | cut -d')' -f2 > ${file}.ue.out.stripped
  # AFZA
  grep AFZA ${file}.ue.out.stripped > ${file}.AFZA
  ttlcnt=$(grep AFZA ${file}.AFZA | wc -l)
  echo "Total AFZA reports: $ttlcnt" >> ${file}.AFZA
  unq=$(grep AFZA ${file}.AFZA | sort | uniq | wc -l)
  echo "Total AFZA unique IDs: $unq" >> ${file}.AFZA
  zero=$(grep AFZA0 ${file}.AFZA | wc -l)
  echo "Total AFZA0* reports:" $zero >> ${file}.AFZA
  one=$(grep AFZA1 ${file}.AFZA | wc -l)
  echo "Total AFZA1* reports:" $one >> ${file}.AFZA
  two=$(grep AFZA2 ${file}.AFZA | wc -l)
  echo "Total AFZA2* reports:" $two >> ${file}.AFZA
  three=$(grep AFZA3 ${file}.AFZA | wc -l)
  echo "Total AFZA3* reports:" $three >> ${file}.AFZA
  four=$(grep AFZA4 ${file}.AFZA | wc -l)
  echo "Total AFZA4* reports:" $four >> ${file}.AFZA
  five=$(grep AFZA5 ${file}.AFZA | wc -l)
  echo "Total AFZA5* reports:" $five >> ${file}.AFZA
  six=$(grep AFZA6 ${file}.AFZA | wc -l)
  echo "Total AFZA6* reports:" $six >> ${file}.AFZA
  seven=$(grep AFZA7 ${file}.AFZA | wc -l)
  echo "Total AFZA7* reports:" $seven >> ${file}.AFZA
  eight=$(grep AFZA8 ${file}.AFZA | wc -l)
  echo "Total AFZA8* reports:" $eight >> ${file}.AFZA
  nine=$(grep AFZA9 ${file}.AFZA | wc -l)
  echo "Total AFZA9* reports:" $nine >> ${file}.AFZA
  # AU
  grep AU ${file}.ue.out.stripped > ${file}.AU
  ttlcnt=$(grep AU ${file}.AU | wc -l)
  echo "Total AU reports: $ttlcnt" >> ${file}.AU
  unq=$(grep AU ${file}.AU | sort | uniq | wc -l)
  echo "Total AU unique IDs: $unq" >> ${file}.AU
  zero=$(grep AU00 ${file}.AU | wc -l)
  echo "Total AU00* reports:" $zero >> ${file}.AU
  one=$(grep AU01 ${file}.AU | wc -l)
  echo "Total AU01* reports:" $one >> ${file}.AU
  # CNC
  grep CNC ${file}.ue.out.stripped > ${file}.CNC
  ttlcnt=$(grep CNC ${file}.CNC | wc -l)
  echo "Total CNC reports: $ttlcnt" >> ${file}.CNC
  unq=$(grep CNC ${file}.CNC | sort | uniq | wc -l)
  echo "Total CNC unique IDs: $unq" >> ${file}.CNC
  ovm=$(grep CNCOVM ${file}.CNC | wc -l)
  echo "Total CNCOVM reports:" $ovm >> ${file}.CNC
  ovl=$(grep CNCOVL ${file}.CNC | wc -l)
  echo "Total CNCOVL reports:" $ovl >> ${file}.CNC
  mvt=$(grep CNCMVT ${file}.CNC | wc -l)
  echo "Total CNCMVT reports:" $mvt >> ${file}.CNC
  mts=$(grep CNCMTS ${file}.CNC | wc -l)
  echo "Total CNCMTS reports:" $mts >> ${file}.CNC
  svn=$(grep CNCSVN ${file}.CNC | wc -l)
  echo "Total CNCSVN reports:" $svn >> ${file}.CNC
  # CNF
  grep CNF ${file}.ue.out.stripped > ${file}.CNF
  ttlcnt=$(grep CNF ${file}.CNF | wc -l)
  echo "Total CNF reports: $ttlcnt" >> ${file}.CNF
  unq=$(grep CNF ${file}.CNF | sort | uniq | wc -l)
  echo "Total CNF unique IDs: $unq" >> ${file}.CNF
  el=$(grep CNFL ${file}.CNF | wc -l)
  echo "Total CNFL* reports:" $el >> ${file}.CNF
  em=$(grep CNFM ${file}.CNF | wc -l)
  echo "Total CNFM* reports:" $em >> ${file}.CNF
  en=$(grep CNFN ${file}.CNF | wc -l)
  echo "Total CNFN* reports:" $en >> ${file}.CNF
  oh=$(grep CNFO ${file}.CNF | wc -l)
  echo "Total CNFO* reports:" $oh >> ${file}.CNF
  pee=$(grep CNFP ${file}.CNF | wc -l)
  echo "Total CNFP* reports:" $pee >> ${file}.CNF
  que=$(grep CNFQ ${file}.CNF | wc -l)
  echo "Total CNFQ* reports:" $que >> ${file}.CNF
  are=$(grep CNFR ${file}.CNF | wc -l)
  echo "Total CNFR* reports:" $are >> ${file}.CNF
  # EU
  grep EU ${file}.ue.out.stripped > ${file}.EU
  ttlcnt=$(grep EU ${file}.EU | wc -l)
  echo "Total EU reports: $ttlcnt" >> ${file}.EU
  unq=$(grep EU ${file}.EU | sort | uniq | wc -l)
  echo "Total EU unique IDs: $unq" >> ${file}.EU
  zero=$(grep EU0 ${file}.EU | wc -l)
  echo "Total EU0* reports:" $zero >> ${file}.EU
  one=$(grep EU1 ${file}.EU | wc -l)
  echo "Total EU1* reports:" $one >> ${file}.EU
  two=$(grep EU2 ${file}.EU | wc -l)
  echo "Total EU2* reports:" $two >> ${file}.EU
  three=$(grep EU3 ${file}.EU | wc -l)
  echo "Total EU3* reports:" $three >> ${file}.EU
  four=$(grep EU4 ${file}.EU | wc -l)
  echo "Total EU4* reports:" $four >> ${file}.EU
  five=$(grep EU5 ${file}.EU | wc -l)
  echo "Total EU5* reports:" $five >> ${file}.EU
  six=$(grep EU6 ${file}.EU | wc -l)
  echo "Total EU6* reports:" $six >> ${file}.EU
  seven=$(grep EU7 ${file}.EU | wc -l)
  echo "Total EU7* reports:" $seven >> ${file}.EU
  eight=$(grep EU8 ${file}.EU | wc -l)
  echo "Total EU8* reports:" $eight >> ${file}.EU
  nine=$(grep EU9 ${file}.EU | wc -l)
  echo "Total EU9* reports:" $nine >> ${file}.EU
  # JP
  grep JP ${file}.ue.out.stripped > ${file}.JP
  ttlcnt=$(grep JP ${file}.JP | wc -l)
  echo "Total JP reports: $ttlcnt" >> ${file}.JP
  unq=$(grep JP ${file}.JP | sort | uniq | wc -l)
  echo "Total JP unique IDs: $unq" >> ${file}.JP
  four=$(grep JP9Z4 ${file}.JP | wc -l)
  echo "Total JP9Z4* reports:" $four >> ${file}.JP
  five=$(grep JP9Z5 ${file}.JP | wc -l)
  echo "Total JP9Z5* reports:" $five >> ${file}.JP
  eight=$(grep JP9Z8 ${file}.JP | wc -l)
  echo "Total JP9Z8* reports:" $eight >> ${file}.JP
  vee=$(grep JP9ZV ${file}.JP | wc -l)
  echo "Total JP9ZV* reports:" $vee >> ${file}.JP
  ex=$(grep JP9ZX ${file}.JP | wc -l)
  echo "Total JP9ZX* reports:" $ex >> ${file}.JP
  # NZL
  grep NZL ${file}.ue.out.stripped > ${file}.NZL
  ttlcnt=$(grep NZL ${file}.NZL | wc -l)
  echo "Total NZL reports: $ttlcnt" >> ${file}.NZL
  unq=$(grep NZL ${file}.NZL | sort | uniq | wc -l)
  echo "Total NZL unique IDs: $unq" >> ${file}.NZL
  zero=$(grep NZL00 ${file}.NZL | wc -l)
  echo "Total NZL00* reports:" $zero >> ${file}.NZL
  one=$(grep NZL01 ${file}.NZL | wc -l)
  echo "Total NZL01* reports:" $one >> ${file}.NZL
  two=$(grep NZL02 ${file}.NZL | wc -l)
  echo "Total NZL02* reports:" $two >> ${file}.NZL
  three=$(grep NZL03 ${file}.NZL | wc -l)
  echo "Total NZL03* reports:" $three >> ${file}.NZL
  four=$(grep NZL04 ${file}.NZL | wc -l)
  echo "Total NZL04* reports:" $four >> ${file}.NZL
  five=$(grep NZL05 ${file}.NZL | wc -l)
  echo "Total NZL05* reports:" $five >> ${file}.NZL
  six=$(grep NZL06 ${file}.NZL | wc -l)
  echo "Total NZL06* reports:" $six >> ${file}.NZL
  seven=$(grep NZL07 ${file}.NZL | wc -l)
  echo "Total NZL07* reports:" $seven >> ${file}.NZL
  eight=$(grep NZL08 ${file}.NZL | wc -l)
  echo "Total NZL08* reports:" $eight >> ${file}.NZL
  nine=$(grep NZL09 ${file}.NZL | wc -l)
  echo "Total NZL09* reports:" $nine >> ${file}.NZL
done

# copy files to final space
finaldir=/meso/noscrub/$USER/TAC2BUFR/10day
cp $tempsvdir/* $finaldir

