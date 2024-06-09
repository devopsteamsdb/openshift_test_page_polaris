# start-polaris.ps1

# Import the Polaris module
Import-Module Polaris

# Define a route
New-PolarisRoute -Method GET -Path "/hello" -ScriptBlock {
    $Response.Send("Hello, World!")
}

New-PolarisRoute -Method GET -Path "/" -ScriptBlock {
    $Response.SetContentType('text/html')
	$html = ./index.ps1
	$Response.Send($html)
}

New-PolarisRoute -Method GET -Path "/fio" -ScriptBlock {
    $testname = $request.query['testname']
    $size = $request.query['size']
    $numjobs = $request.query['numjobs']
    $Response.SetContentType('text/html')
	$html = ./fio.ps1 -testname $testname -size $size -numjobs $numjobs
	$Response.Send($html)
}

# Start the Polaris server on port 8080
$Polaris = Start-Polaris -Port 8080

while ($Polaris.Listener.IsListening){
	Wait-Event callbackeventbridge.callbackcomplete
}