echo on

copy C:\remoting\tempinputseries\DBIEX.REC C:\remoting\TACC\flairstar\data\FLAIR3D.REC
copy C:\remoting\tempinputseries\DBIEX.XML C:\remoting\TACC\flairstar\data\FLAIR3D.XML

C:\cygwin64\bin\dos2unix C:\remoting\TACC\flairstar\scripts\flairstar_02_flair.sh
C:\cygwin64\bin\bash C:\remoting\TACC\flairstar\scripts\flairstar_02_flair.sh

copy  C:\remoting\TACC\flairstar\results\FLAIRSTAR.XML C:\remoting\tempoutputseries\DBIEX.XML
copy  C:\remoting\TACC\flairstar\results\FLAIRSTAR.REC C:\remoting\tempoutputseries\DBIEX.REC

del C:\remoting\tempoutputseries\NoOutputData.ini 



