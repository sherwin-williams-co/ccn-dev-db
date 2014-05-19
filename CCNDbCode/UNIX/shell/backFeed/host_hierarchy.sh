#Run below command to make the process run in the background even after shutdown
#nohup sh $HOME/host_hierarchy.sh > $HOME/host_hierarchy.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -elf | grep -i host_hierarchy.sh

#path where the hierarchy files are stored
# below command will get the path for ccn.config respective to the environment from which it is run from
. `cut -d/ -f1-4 <<<"${PWD}"`/ccn.config

hier_path="$HOME/hier"
datafiles_path="$HOME/datafiles"
originalfile="$hier_path/Hierarchies_Ready.ok"

# Search for the file named Hierarchies_Ready.ok
while true; do
   if [ -s $hier_path/Hierarchies_Ready.ok ]
   then
      now=`date +"%Y-%m-%d.%H%M%S"`
      renamedfile="$hier_path/Hierarchies_Ready.$now.ok"
      # Example renamedfile: Hierarchies_Ready.2013-10-30.134513.ok

      echo "copying files from $HOME/hier to $HOME/datafiles"
      # Copy all the .txt files from $HOME/hier to $HOME/datafiles
      cp -pf $hier_path/*.txt $datafiles_path

      echo "running the load_hierarchy.sh script to load the hierarchies"
      # Now run the hierarchy shell script
      sh $hier_path/load_hierarchy.sh

      echo "renaming the files from $originalfile to $renamedfile"  
      # Rename the file to something else for future running purpose
      mv $originalfile $renamedfile
   #else
      #echo "searching for $hier_path/Hierarchies_Ready.ok"
   fi
done

echo "process completed - but should not come to this point"
