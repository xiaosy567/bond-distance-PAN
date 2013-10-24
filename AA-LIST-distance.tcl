#calculate the distance of the geometry of two group atoms
#

set nf [molinfo 0 get numframes]

set atomAlistResid {14 13 12}
set atomAlistName  {P  P  P}
set atomBlistResid {31 32 33}
set atomBlistName  {P  P  P}

foreach Aitem1 $atomAlistResid Aitem2 $atomAlistName Bitem1 $atomBlistResid Bitem2 $atomBlistName {
  set seltextA [join [list "resid" $Aitem1 "and" "name" $Aitem2] "  "]
  set seltextB [join [list "resid" $Bitem1 "and" "name" $Bitem2] "  "]
  puts $seltextA
  puts $seltextB

  #### 
  animate goto 0
  set selA [atomselect top $seltextA]
  set selB [atomselect top $seltextB]

  ###get index list
  set list1 [list [$selA get index] [$selB get index]]

  ###output file
  set resnameA [$selA get resname]
  set resnameB [$selB get resname]
  set fo [open "./bond-length-${resnameA}${Aitem1}-${Aitem2}-${resnameB}${Bitem1}-${Bitem2}.dat" "w"]
  ###
 
  for {set i 0} {$i < $nf} {incr i} {
    set bondLength [measure bond $list1 frame ${i}]
    puts $fo "$i   $bondLength"
  }

  $selA delete
  $selB delete

  close $fo
  
  puts "-----------------------------"
}
