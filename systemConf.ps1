# $nargs = $args.Count #args is the list of input arguments
# $comPortName=$args[0] #This is the com port. It has zero spaces
# $baud = $args[1] #this is the numberical baud rate
# #the remainder of the arguments are processed below
# echo "starting script"


# #Combine argument 2,3,...,n with a space because of command prompt shortfalls to pass arguments with spaces
# $dataToWrite = ""
# For ($i=2; $i -le $nargs ; $i++) {
#     $dataToWrite = "$($dataToWrite) $($args[$i])"
# }

# #$port= new-Object System.IO.Ports.SerialPort COM2,9600,None,8,one
# $port= new-Object System.IO.Ports.SerialPort $comPortName,$baud,None,8,one

# #open port if it's not yet open
# IF ($port.IsOpen) {
#     echo "Port is already open"
#     #already open
# } ELSE {
#     echo "Port is not open"
#     #open port
#     $port.Open()
# }

# IF ($port.IsOpen) {
#     echo "Port is already open"
#     #already open
# } ELSE {
#     echo "Port is not open"
#     #open port
#     $port.Open()
# }

# #write the data
# echo "Writing data: $dataToWrite"
# $port.WriteLine($dataToWrite)

# #wait for a response (must end in newline). This removes the need to have a hard coded delay
# echo "Waiting for response"
# $line = $port.ReadLine()
# Write-Host $line #send read data out
# echo "Response received"

# #if the response was multiple lines, then read the rest of the buffer. If the port was just opened.
# $dataCounter = 0
# #if the data counter is less than , then keep reading
# while ($dataCounter -lt 70){
#     $dataReturned = 1
#     $line = $port.ReadLine()
#     Write-Host $line #send read data out for the remainder of the buffer
#     wait-event -timeout .1
#     $dataCounter++
# }

# $port.Close()

# #IF ($dataReturned -eq 0) {'PS_NO_BYTES_TO_READ'}