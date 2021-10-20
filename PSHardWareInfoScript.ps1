; $Name = hostname; $Motherboard = Get-WmiObject Win32_BaseBoard; $CPU = Get-WmiObject Win32_Processor; $GPU = Get-WmiObject Win32_VideoController; $RAM = Get-WmiObject Win32_ComputerSystem; $Ether_IP = Get-NetIPAddress -AddressFamily IPv4 | Select-Object IPAddress -first 1; $WiFi_IP = Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias \"Wi-Fi\" | Select-Object IPAddress; $Disk_Total = Get-WmiObject Win32_LogicalDisk -filter drivetype=3 | Select-Object Size; $Disk_Remain = Get-WmiObject Win32_LogicalDisk -filter drivetype=3 | Select-Object FreeSpace ; $SerialNumber = Get-WmiObject Win32_Bios | Select SerialNumber; $To_File = new-object PSObject -property @{'Name' = $Name; 'Motherboard' = $Motherboard.Product; 'CPU' = $CPU.Name; 'Cores' = $CPU.NumberOfCores; 'GPU' = $GPU.Name; 'RAM' = \"{0:N2}\" -f ($RAM.TotalPhysicalMemory/1GB)+\" (GB)\"; 'Ether_IP' = $Ether_IP.IPAddress; 'Wifi_IP' = $Wifi_IP.IPAddress; 'Disk_Total' = \"{0:N2}\" -f ($Disk_Total.Size) ; 'Disk_Remain' = \"{0:N2}\" -f ($Disk_Remain.FreeSpace) ;  'windows_username' = $env:username ;'Serial_Number' = $SerialNumber.SerialNumber };  $To_File | Select-Object Name, Motherboard, CPU, Cores, GPU, RAM, Ether_IP, Wifi_IP, Disk_Total, Disk_Remain, windows_username, Serial_Number | Export-csv -Encoding UTF8 -path .\HardWareInfo.csv
#test