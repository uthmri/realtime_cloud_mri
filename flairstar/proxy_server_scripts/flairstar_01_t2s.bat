echo on

del /F C:\remoting\TACC\flairstar\data\T2STAR3D.REC
del /F C:\remoting\TACC\flairstar\data\T2STAR3D.XML

del /F C:\remoting\TACC\flairstar\data\FLAIR3D.REC
del /F C:\remoting\TACC\flairstar\data\FLAIR3D.XML

copy C:\remoting\tempinputseries\DBIEX.REC C:\remoting\TACC\flairstar\data\T2STAR3D.REC
copy C:\remoting\tempinputseries\DBIEX.XML C:\remoting\TACC\flairstar\data\T2STAR3D.XML

C:\cygwin64\bin\dos2unix C:\remoting\TACC\flairstar\scripts\flairstar_01_t2s.sh
C:\cygwin64\bin\bash C:\remoting\TACC\flairstar\scripts\flairstar_01_t2s.sh

copy  C:\remoting\NoOutputData.ini C:\remoting\tempoutputseries\

