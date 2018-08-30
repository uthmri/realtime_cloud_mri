
copy C:\remoting\tempinputseries\DBIEX.REC C:\remoting\TACC\t1fitting\data\TI_120.REC
copy C:\remoting\tempinputseries\DBIEX.XML C:\remoting\TACC\t1fitting\data\TI_120.XML

REM submit the fitting script
C:\cygwin64\bin\dos2unix C:\remoting\TACC\t1fitting\scripts\t1fitting.sh
C:\cygwin64\bin\bash C:\remoting\TACC\t1fitting\scripts\t1fitting.sh


del C:\remoting\tempoutputseries\NoOutputData.ini

copy  C:\remoting\TACC\t1fitting\results\T1map.XML C:\remoting\tempoutputseries\DBIEX.XML
copy  C:\remoting\TACC\t1fitting\results\T1map.REC C:\remoting\tempoutputseries\DBIEX.REC
