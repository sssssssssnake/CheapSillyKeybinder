param (
    [string[]]$args
)

Add-Type -AssemblyName System.Windows.Forms

# Combine all arguments into a single string
$inputString = $args -join " "

# Send the combined string as keystrokes
[System.Windows.Forms.SendKeys]::SendWait($inputString)