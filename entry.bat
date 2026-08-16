@robocopy C:\app\ComfyUI\_models C:\app\ComfyUI\models /E /XC /XN /XO /R:3 /W:1 /NP >nul
@robocopy C:\app\ComfyUI\_custom_nodes C:\app\ComfyUI\custom_nodes /E /XC /XN /XO /R:3 /W:1 /NP >nul
@type C:\app\README_VERY_IMPORTANT.txt
@echo.
@echo.
@echo.
@.\python_embeded\python.exe -s ComfyUI\main.py --windows-standalone-build --listen 0.0.0.0 --disable-auto-launch %ARGS%
@exit
