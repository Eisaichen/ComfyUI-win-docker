if ( Test-Path -Path C:\userdata\custom_nodes -PathType Container ) {
    foreach ( $i in $(Get-ChildItem -Path C:\userdata\custom_nodes -Recurse -Depth 1 -Filter requirements.txt).FullName ) {
        python.exe -m pip install -r $i
    }

    if ( Test-Path -Path C:\userdata\requirements.txt -PathType Leaf ) { python.exe -m pip install -r C:\userdata\requirements.txt }
}
