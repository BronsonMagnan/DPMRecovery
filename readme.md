
The DPM Recovery PowerShell project was created to work around a bug in the Microsoft DPM MMC Console. 

The DPM Recovery console bug occurs when attempting to restore a file from a volume that holds file shares. You will be unable to select or browse items in a recovery point. However, DPM can restore files on these volumes without issue using DPM PowerShell. Unfortunately, restoring files with PowerShell is a complicated process. This project is a GUI front end for restoring DPM files to an alternate server location.

The server you run this script on requires the DPM console to be installed.

I have tested this on Server 2016, with DPM 1807.

This is version 1.0, there are definetly some UI related bugs, but it does the job.
Known issues:
1. Typing in a alternate restore subfolder after the drive root does not work.
2. Restore job status update does not work until the job is completed.

Notes:
Search may take a while, depends on your SQL performance, expect at least 30 seconds.
The restore operation might look like it is doing nothing, the status update does not work.

Please see DPM Recovery Instructions.png for the guide on using the GUI front end.

![alt text](https://github.com/BronsonMagnan/DPMRecovery/blob/master/DPM%20Recovery%20Instructions.png "Instructions")
