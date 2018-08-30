echo on

del C:\remoting\TACC\t1fitting\data\TI_*.REC
del C:\remoting\TACC\t1fitting\data\TI_*.XML

copy C:\remoting\tempinputseries\DBIEX.REC C:\remoting\TACC\t1fitting\data\TI_1600.REC
copy C:\remoting\tempinputseries\DBIEX.XML C:\remoting\TACC\t1fitting\data\TI_1600.XML

copy C:\remoting\NoOutputData.ini C:\remoting\tempoutputseries\
