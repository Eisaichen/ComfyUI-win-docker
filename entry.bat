@robocopy C:\app\ComfyUI\models C:\userdata\models /E /XC /XN /XO /R:3 /W:1 /NP >nul
@robocopy C:\app\ComfyUI\custom_nodes C:\userdata\custom_nodes /E /XC /XN /XO /R:3 /W:1 /NP >nul
@robocopy C:\app\ComfyUI\input C:\userdata\input /E /XC /XN /XO /R:3 /W:1 /NP >nul
@robocopy C:\app\ComfyUI\output C:\userdata\output /E /XC /XN /XO /R:3 /W:1 /NP >nul
@type C:\app\README_VERY_IMPORTANT.txt
@echo.
@echo.
@echo.
@.\python_embeded\python.exe -s ComfyUI\main.py --windows-standalone-build --listen 0.0.0.0 --disable-auto-launch --base-directory C:\userdata %ARGS%
@exit
