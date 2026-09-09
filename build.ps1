# fix github runner https://github.com/actions/runner-images/issues/13729
Start-Service -Name docker -ErrorAction SilentlyContinue


# Download driver

git clone --depth 1 --single-branch https://github.com/Eisaichen/nvidia-driver-docker .\build\res\nvdll
Remove-Item -Path ".\build\res\nvdll\.git" -Recurse -Force


# Download comfyui

git clone --depth 1 --single-branch -b $env:GH_CI_TAG https://github.com/comfy-org/comfyui .\build\app
Remove-Item -Path ".\build\app\.git" -Recurse -Force


# Unzip the file

Copy-Item .\entry.bat .\build\app
Copy-Item .\install_requirement.ps1 .\build\app


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
