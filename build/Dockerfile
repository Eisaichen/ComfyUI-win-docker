FROM mcr.microsoft.com/windows/server:ltsc2022

EXPOSE 8188

ENV ARGS=

COPY ./res c:/res
COPY ./ComfyUI_windows_portable c:/app

RUN powershell -command "takeown /F c:\app /R /D Y 1> $null" ; \
    powershell -command "takeown /F c:\res\nvdll /R /D Y /A 1> $null" ; \
    Move-Item -Path c:\res\nvdll\* -Destination C:\Windows\System32 ; \
    Start-Process -wait -FilePath C:\res\vc_redist.x64.exe -ArgumentList '/install /passive /norestart' ; \
    Import-Certificate -FilePath c:\res\cacert.sst -CertStoreLocation 'Cert:\LocalMachine\Root' ; \
    Remove-Item -r c:\res

WORKDIR C:/app
ENTRYPOINT entry.bat
