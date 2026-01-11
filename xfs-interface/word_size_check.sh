echo -n 'a' >> sample.dat
./xfs-interface load --data /home/acausr/myexpos/xfs-interface/sample.dat
size=$( ./xfs-interface ls | tail -n 1 | awk '{print $4}' )
while [[ size -eq 0 ]]; do
  echo -n 'a' >> sample.dat
  ./xfs-interface rm sample.dat
  ./xfs-interface load --data /home/acausr/myexpos/xfs-interface/sample.dat
  size=$( ./xfs-interface ls | tail -n 1 | awk '{print $4}' )
done

