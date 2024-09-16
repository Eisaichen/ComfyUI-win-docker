$i=(curl https://api.github.com/repos/comfyanonymous/ComfyUI/releases/latest).content | ConvertFrom-Json | Where-Object {$_.assets.name -eq 'ComfyUI_windows_portable_nvidia.7z'}
[string]$7z="$PWD"+'\build'


docker pull mcr.microsoft.com/windows/server:ltsc2022
.\wget -q --no-hsts $i.assets.browser_download_url -O .\ComfyUI_windows_portable_nvidia.7z
Invoke-Expression ".\7z\7za.exe x .\ComfyUI_windows_portable_nvidia.7z -o$7z"
Rename-Item -Path .\build\ComfyUI_windows_portable\ComfyUI\models -NewName _models
mkdir .\build\ComfyUI_windows_portable\ComfyUI\models
cp .\entry.bat .\build\ComfyUI_windows_portable
$i=Get-Content .\build\ComfyUI_windows_portable\README_VERY_IMPORTANT.txt
Set-Content .\build\ComfyUI_windows_portable\README_VERY_IMPORTANT.txt $i[14..$i.length]

if ($env:GH_CI_LATEST -eq "true") {
    docker build --isolation hyperv --no-cache -t eisai/comfy-ui:latest -t eisai/comfy-ui:$env:GH_CI_TAG .\build
} else {
    docker build --isolation hyperv --no-cache -t eisai/comfy-ui:$env:GH_CI_TAG .\build
}

if ($env:GH_CI_PUSH -eq "true") {
    docker push eisai/comfy-ui -a
}