#!/bin/bash
# set path for cygwin
export PATH=/home/UT/cli/bin:/bin;

# move into working directory
cd C:/remoting/TACC/flairstar;

touch flairstar_output.log;
echo "beginning flairstar.sh... " >> flairstar_output.log; date >> flairstar_output.log;
echo "de-identification..." >> flairstar_output.log; date >> flairstar_output.log;

# anonymize data
for FILE in ` ls data/*XML `; do PNAME=` grep "Patient Name" ${FILE} | awk -F\> '{print $2}' | awk -F\< '{print $1}' `;
sed -i "s/${PNAME}/ANONYMOUS/g" "$FILE";
done

# Compress data for transfer
cd data/ && tar -czf ../data.tar.gz T2STAR3D.REC T2STAR3D.XML && cd ../;

echo "data transfer..." >> flairstar_output.log; date >> flairstar_output.log;
# Upload the data -> expect all rec and xml files to be in there already
files-upload -F data.tar.gz -S jetstream-storage /vol1/agave/data/;
files-upload -F scripts/flairstar_v01.grp -S jetstream-storage /vol1/agave/pipelines/;

echo "job submission..." >> flairstar_output.log; date >> flairstar_output.log;

# submit the job and do not wait
jobs-submit -F scripts/flairstar.json > job_number.txt;
