FROM mcr.microsoft.com/windows/server:ltsc2022

EXPOSE 8188

ENV PYTHONUTF8=1 PIP_NO_CACHE_DIR=1 ARGS= COMFY_INSTALL_NODE=true

COPY ./res c:/res
COPY ./app c:/app

RUN powershell Move-Item -Path c:\res\nvdll\System32\* -Destination C:\Windows\System32 -Force ; \
    Move-Item -Path c:\res\nvdll\SysWOW64\* -Destination C:\Windows\SysWOW64 -Force ; \
    Start-Process -wait -FilePath C:\res\vc_redist.x64.exe -ArgumentList '/install /passive /norestart' ; \
    Import-Certificate -Filepath C:\res\cacert.sst -CertStoreLocation 'Cert:\LocalMachine\Root' ; \
    Start-Process -wait -FilePath C:\res\python-3.13.15-amd64.exe -ArgumentList '/quiet InstallAllUsers=0 PrependPath=1 CompileAll=1 Shortcuts=0 Include_doc=0 Include_launcher=0 Include_tcltk=0' ; \
    $env:path+=';C:\Users\ContainerAdministrator\AppData\Local\Programs\Python\Python313\Scripts\;C:\Users\ContainerAdministrator\AppData\Local\Programs\Python\Python313\' ; \
    pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu130 ; \
    pip install -r C:\app\requirements.txt ; \
    pip install -r C:\app\manager_requirements.txt ; \
    pip install triton-windows PyOpenGL-accelerate ; \
    Remove-Item -Recurse c:\res

WORKDIR C:/app
ENTRYPOINT entry.bat
