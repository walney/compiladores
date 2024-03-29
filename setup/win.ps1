# Script to install flex+bison and some utilities.
# Author: Adriano J. Holanda
# Date: 2021-09-06

# Function to check if a program is installed
function Check_Program_Installed( $programName ) {
    return Get-Command $programName 2> $null
}

# Function to install Chocolatey
function Install_Choco() {
    $is_installed = Check_Program_Installed("choco")
    if (! $is_installed) {
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }
}

# Install the programs needed for compiler classes
$programs = @(
    [pscustomobject]@{ProgramName='gcc';PackageName='mingw'}

    [pscustomobject]@{ProgramName='git';PackageName='git'}
    
    [pscustomobject]@{ProgramName='make';PackageName='make'}

    [pscustomobject]@{ProgramName='pandoc';PackageName='pandoc'}

    [pscustomobject]@{ProgramName='win_flex';PackageName='winflexbison3'}

    [pscustomobject]@{ProgramName='win_bison';PackageName='winflexbison3'}

    [pscustomobject]@{ProgramName='code';PackageName='vscode'}
)
function Install_Programs() {
    $programs | ForEach-Object {
        $is_installed = Check_Program_Installed($_.ProgramName)
        if (! $is_installed) {
            Write-Host "Installing $($_.PackageName)..."
            choco install -y $_.PackageName
        } else {
            Write-Host "$($_.ProgramName) is already installed!"
        }
    }
}

Install_Choco
Install_Programs
