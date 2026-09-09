@robocopy C:\app\models C:\userdata\models /E /XC /XN /XO /R:3 /W:1 /NP >nul
@robocopy C:\app\custom_nodes C:\userdata\custom_nodes /E /XC /XN /XO /R:3 /W:1 /NP >nul
@robocopy C:\app\input C:\userdata\input /E /XC /XN /XO /R:3 /W:1 /NP >nul
@robocopy C:\app\output C:\userdata\output /E /XC /XN /XO /R:3 /W:1 /NP >nul


@if /I "%COMFY_INSTALL_NODE%"=="true" (
    @echo Scan for dependencies
    @echo Set "COMFY_INSTALL_NODE=false" to disable auto install
    @echo ------------------------------------------------------------
    @powershell -NonInteractive -Command C:\app\install_requirement.ps1
)

@echo.
@echo.
@echo ------------------------------------------------------------
@echo Starting ComfyUI
@echo ------------------------------------------------------------
@echo.
@echo.
@python.exe -s main.py --listen 0.0.0.0 --disable-auto-launch --base-directory C:\userdata %ARGS%
@exit
