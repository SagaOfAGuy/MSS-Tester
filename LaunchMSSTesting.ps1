# Test Script for MSS Roomchecks 

# Define these variables to run test script:
$kaltura_file_location="";
$vcu_zoom_link=""; 
$vlc_file_location="";  
$ticket_system_link=""; 

# Function for ejecting CD drive. Code can be found here: https://superuser.com/questions/1335225/how-to-eject-and-insert-cd-dvd-drive-using-command-line-in-windows?noredirect=1&lq=1
function Eject-CD()
{
   (New-Object -com "WMPlayer.OCX.7").cdromcollection.item(0).eject()
}

# Get Drive letter of CD drive 
function GetDrive() {
	$volumes = get-volume; 
    	foreach($volume in $volumes) 
    	{ 
        	if($volume.DriveType -eq "CD-ROM")
        	{
            		return $volume.DriveLetter + ":\"; 
        	}
    }
}

# Function to Play the DVD during roomcheck
function Play-CD()
{
    $DVD_Drive = GetDrive
    $DVD_Loaded = (Get-WMIObject -Class Win32_CDROMDrive -Property *).MediaLoaded
    if($DVD_Loaded -eq $true) {
       start-process $vlc_file_location $DVD_Drive
       sleep 30 
       stop-process -name "vlc"; 
       Eject-CD
    }
    else 
    {
       write-host "No DVD in tray. Please insert Test DVD..." 
       Eject-CD
       start-sleep 10
	   Play-CD
	}
}

# Launch Zoom Application
function LaunchZoom() 
{
    .\LoginHelper.ps1 
}

# Launch Kaltura Classroom 
function LaunchKaltura()
{
    try 
    {
        # Call Kaltura Twice to get GUI screen 
        Start-Process $kaltura_file_location
        Start-Process $kaltura_file_location
    }
    catch [System.InvalidOperationException]
    {
        [System.Windows.MessageBox]::Show("Kaltura is not installed. Submit ticket if needed");   
    }  
}

# Main function 
function main() 
{
    LaunchKaltura
    LaunchZoom
    Play-CD	
}
# Call main function
main 
