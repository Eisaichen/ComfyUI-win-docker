FROM mcr.microsoft.com/windows/server:ltsc2022

EXPOSE 8188

ENV ARGS= COMFY_INSTALL_NODE=true

COPY ./res c:/res
COPY ./ComfyUI_windows_portable c:/app

RUN powershell Move-Item -Path c:\res\nvdll\System32\* -Destination C:\Windows\System32 -Force ; \
    Move-Item -Path c:\res\nvdll\SysWOW64\* -Destination C:\Windows\SysWOW64 -Force ; \
    Start-Process -wait -FilePath C:\res\vc_redist.x64.exe -ArgumentList '/install /passive /norestart' ; \
    Import-Certificate -Filepath C:\res\cacert.sst -CertStoreLocation 'Cert:\LocalMachine\Root' ; \
    C:\app\python_embeded\python.exe -m pip install -r C:\app\ComfyUI\manager_requirements.txt ; \
    C:\app\python_embeded\python.exe -m pip install PyOpenGL-accelerate ; \
    [Environment]::SetEnvironmentVariable('Path',"$([Environment]::GetEnvironmentVariable('Path','Machine'))"+';C:\app\python_embeded;C:\app\python_embeded\Scripts','Machine') ; \
    [Environment]::SetEnvironmentVariable('PYTHONUTF8','1','Machine') ; \
    Remove-Item -Recurse c:\res

WORKDIR C:/app
ENTRYPOINT entry.bat
