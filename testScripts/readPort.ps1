$port= new-Object System.IO.Ports.SerialPort COM4,115200,None,8,one
$port.Open()

echo "checking port"
echo $port.IsOpen

#open port if it's not yet open
IF ($port.IsOpen) {
    echo "Port is already open"
    #already open
} ELSE {
    echo "Port is not open"
    #open port
    $port.Open()
}

$dataToWrite = "Goodbye Cruel World"
#write the data
echo "Writing data: $dataToWrite"
$port.WriteLine($dataToWrite)

$port.ReadTimeout = 50


wait-event -timeout .05

#wait for a response (must end in newline). This removes the need to have a hard coded delay
echo "Waiting for response"
$line = $port.ReadLine()
echo $line >> line.txt #send read data out


if ($line -eq "") {
  echo "Blah, bad data"
}
echo "Response received"
$responses = @(11)

#if the response was multiple lines, then read the rest of the buffer. If the port was just opened.
$dataCounter = 0
#if the data counter is less than , then keep reading
while ($dataCounter -lt 10){
    $dataReturned = 1
    $line = $port.ReadLine()
    echo $line #send read data out for the remainder of the buffer
    $responses += $line
    wait-event -timeout .1
    $dataCounter++
    echo "Data counter: $dataCounter"
}

$port.Close()
$port.Dispose()
echo "Port closed"

$writecounter = 0
while ($writecounter -lt 11){
    $writecounter++
    echo $responses[$writecounter] >> responses.txt
}
