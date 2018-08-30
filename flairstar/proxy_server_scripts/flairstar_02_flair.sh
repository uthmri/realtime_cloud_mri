#!/bin/bash
# set the path for cygwin
export PATH=/home/UT/cli/bin:/bin;

# move into working directory
cd C:/remoting/TACC/flairstar;

touch flairstar_output.log;
echo "beginning flairstar_02_FLAIR.sh... " >> flairstar_output.log; date >> flairstar_output.log;
echo "de-identification..." >> flairstar_output.log; date >> flairstar_output.log;

# anonymize data
for FILE in ` ls data/*XML `; do PNAME=` grep "Patient Name" ${FILE} | awk -F\> '{print $2}' | awk -F\< '{print $1}' `;
sed -i "s/${PNAME}/ANONYMOUS/g" "$FILE";
done

echo "data transfer..." >> flairstar_output.log; date >> flairstar_output.log;
# upload the rest of the data
files-upload -F data/FLAIR3D.REC -S jetstream-storage /vol1/agave/data/;
files-upload -F data/FLAIR3D.XML -S jetstream-storage /vol1/agave/data/;

# check job status and wait for finish of GRAPE execution
while true; do
var=`jobs-status $(cat job_number.txt | awk '{print $4}')`
if [ "$var" = "FINISHED" ];
then
break;
fi
sleep 1;
done


# check the results directory exists 
if [ ! -d "results" ]; then mkdir results; fi; rm results/*; cd results;

# download the results
echo "result download..." >> ../flairstar_output.log; date >> ../flairstar_output.log;
files-get -S jetstream-storage /vol1/agave/output.tar.gz;

# decompress
echo "result decompression..." >> ../flairstar_output.log; date >> ../flairstar_output.log;
tar -xzf output.tar.gz;
cd ../;

# set result directory name
DIR_NAME=` date "+results-%Y.%m.%d-%H.%M.%S" `;
echo "copy result..." >> flairstar_output.log; date >> flairstar_output.log;
cp -r results $DIR_NAME;

echo "finished!" >> flairstar_output.log; date >> flairstar_output.log;
cp flairstar_output.log results;
mv flairstar_output.log $DIR_NAME;
