# fix github runner https://github.com/actions/runner-images/issues/13729
Start-Service docker

# Download ComfyUI

$i = $(Invoke-WebRequest -Uri https://api.github.com/repos/Comfy-Org/ComfyUI/releases).content | ConvertFrom-Json
$url = (($i | Where-Object { $_.tag_name -eq "$env:GH_CI_TAG" }).assets | Where-Object { $_.name -eq "ComfyUI_windows_portable_nvidia.7z" }).browser_download_url
[string]$7z = "$PWD" + '\build'


# Download driver

git clone --depth 1 --single-branch https://github.com/Eisaichen/nvidia-driver-docker .\build\res\nvdll
Remove-Item -Path ".\build\res\nvdll\.git" -Recurse -Force


# Unzip the file

.\wget -q --no-hsts $url -O .\ComfyUI_windows_portable_nvidia.7z
Invoke-Expression ".\7z\7za.exe x .\ComfyUI_windows_portable_nvidia.7z -o$7z"
Copy-Item .\entry.bat .\build\ComfyUI_windows_portable
Copy-Item .\install_requirement.ps1 .\build\ComfyUI_windows_portable
$i = Get-Content .\build\ComfyUI_windows_portable\README_VERY_IMPORTANT.txt
Set-Content .\build\ComfyUI_windows_portable\README_VERY_IMPORTANT.txt $i[14..20]


# Build ltsc2025

$i = Get-Content -Path .\build\Dockerfile
Set-Content -Path .\build\Dockerfile -Value $($i.replace("FROM mcr.microsoft.com/windows/server:ltsc2022", "FROM mcr.microsoft.com/windows/server:ltsc2025"))

if ($env:GH_CI_LATEST -eq "true") {
    docker build --isolation hyperv --pull --no-cache -t eisai/comfy-ui:latest -t eisai/comfy-ui:$env:GH_CI_TAG .\build
}
else {
    docker build --isolation hyperv --pull --no-cache -t eisai/comfy-ui:$env:GH_CI_TAG .\build
}

# Push
if ($env:GH_CI_PUSH -eq "true") {
    docker push eisai/comfy-ui -a
}
