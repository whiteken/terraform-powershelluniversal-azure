[cmdletbinding()]
<#
Adapted from https://gist.github.com/dkittell/f029b6c7d1c46ebcffcb
#>
param(
    #FTP Host URL
    [parameter()][string]$FTPHost = 'ftp://192.168.1.1/html/',
    #FTP username
    [parameter()][string]$FTPUser = 'user',
    #FTP password
    [parameter()][string]$FTPPass = 'password',
    # Directory where to find pictures to upload
    [parameter()][string]$UploadFolder
)

$webclient = New-Object System.Net.WebClient
$webclient.Credentials = New-Object System.Net.NetworkCredential($FTPUser, $FTPPass)

$source = Get-ChildItem $UploadFolder -Recurse
$sourceFolders = $source | Where-Object { $_.PSIsContainer }
$sourceFiles = $source| Where-Object { -not $_.PSIsContainer }

# Create FTP Directory/SubDirectory If Needed - Start
foreach ($folder in $sourceFolders) {
    $sourceFolderPath = $UploadFolder -replace "\\", "\\" -replace "\:", "\:"
    $destinationFolder = $folder.Fullname -replace $sourceFolderPath, $FTPHost
    $destinationFolder = $destinationFolder -replace "\\", "/"

    try {
        $makeDirectory = [System.Net.WebRequest]::Create($destinationFolder);
        $makeDirectory.Credentials = New-Object System.Net.NetworkCredential($FTPUser, $FTPPass);
        $makeDirectory.Method = [System.Net.WebRequestMethods+FTP]::MakeDirectory;
        $makeDirectory.GetResponse();
        #folder created successfully
    }
    catch [Net.WebException] {
        try {
            #if there was an error returned, check if folder already existed on server
            $checkDirectory = [System.Net.WebRequest]::Create($destinationFolder);
            $checkDirectory.Credentials = New-Object System.Net.NetworkCredential($FTPUser, $FTPPass);
            $checkDirectory.Method = [System.Net.WebRequestMethods+FTP]::PrintWorkingDirectory;
            $checkDirectory.GetResponse() | Out-Null
            #folder already exists!
        }
        catch [Net.WebException] {
            #if the folder didn't exist
        }
    }
}
# Create FTP Directory/SubDirectory If Needed - Stop

# Upload Files - Start

# Upload Files - Start
foreach ($entry in $SrcFiles) {
    $sourceFullname = $entry.fullname
    #$SrcName = $entry.Name
    $SrcFilePath = $UploadFolder -replace "\\", "\\" -replace "\:", "\:"
    $DesFile = $sourceFullname -replace $SrcFilePath, $FTPHost
    $DesFile = $DesFile -replace "\\", "/"
    # Write-Output $DesFile

    $uri = New-Object System.Uri($DesFile)
    Write-Host "Uploading: $uri"
    $webclient.UploadFile($uri, $sourceFullname)
}
# Upload Files - Stop