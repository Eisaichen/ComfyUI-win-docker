if ( Test-Path -Path C:\userdata\custom_nodes -PathType Container ) {
    foreach ( $i in $(Get-ChildItem -Path C:\userdata\custom_nodes -Recurse -Depth 1 -Filter requirements.txt).FullName ) {
        pip install -r $i
    }
}

if ( Test-Path -Path C:\userdata\deps -PathType Container ) {
    if ( Test-Path -Path C:\userdata\deps\requirements.txt -PathType Leaf ) { pip install -r C:\userdata\deps\requirements.txt }
    if ( Test-Path -Path C:\userdata\deps\*.whl -PathType Leaf ) { 
        foreach ( $wheel in $(Get-ChildItem C:\userdata\deps\*.whl).FullName ) {
            pip install $wheel
        }
    }
}
