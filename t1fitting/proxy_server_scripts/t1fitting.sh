#!/bin/bash
# set path for cygwin
export PATH=/home/UT/cli/bin:/bin;

# move into working directory
cd C:/remoting/TACC/t1fitting;

# create the log file
touch t1fitting_output.log;
echo "beginning t1fitting.sh... " >> t1fitting_output.log; date >> t1fitting_output.log;
echo "de-identification..." >> t1fitting_output.log; date >> t1fitting_output.log;

# anonymize data
for FILE in ` ls data/*XML `; do PNAME=` grep "Patient Name" ${FILE} | awk -F\> '{print $2}' | awk -F\< '{print $1}' `;
sed -i "s/${PNAME}/ANONYMOUS/g" "$FILE";
done

# Compress data for transfer
echo "data compression..." >> t1fitting_output.log; date >> t1fitting_output.log;
cd data/ && tar -czf ../data.tar.gz ./ && cd ../;

# Upload the data -> we expect all rec and xml files to be in there already
echo "data transfer..." >> t1fitting_output.log; date >> t1fitting_output.log;
files-upload -F data.tar.gz -S jetstream-storage /vol1/agave/data/;
files-upload -F scripts/T1_Fitting_v03.grp -S jetstream-storage /vol1/agave/pipelines/;

# remove the file for future runs
rm data.tar.gz;

# submit the grape job
echo "job submission..." >> t1fitting_output.log; date >> t1fitting_output.log;
jobs-submit -F scripts/t1fitting.json -W;

# check the results directory exists
if [ ! -d "results" ]; then mkdir results; fi; rm results/*; cd results;

# download the results (should we be removing old results from this directory?)
echo "result download..." >> ../t1fitting_output.log; date >> ../t1fitting_output.log;
files-get -S jetstream-storage /vol1/agave/output.tar.gz;

# decompress
echo "result decompression..." >> ../t1fitting_output.log; date >> ../t1fitting_output.log;
tar -xzf output.tar.gz;

# copy the results and source data
cd ../;
echo "copy result..." >> t1fitting_output.log; date >> t1fitting_output.log;
# set a name for the download directory
DIR_NAME=` date "+results-%Y.%m.%d-%H.%M.%S" `;
cp -r results $DIR_NAME;
cp -r data $DIR_NAME;

echo "finished!" >> t1fitting_output.log; date >> t1fitting_output.log;
mv t1fitting_output.log $DIR_NAME;
