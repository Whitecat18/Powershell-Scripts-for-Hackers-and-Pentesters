## Network Enumeration using powershell

In this Page , There are many scripts and commands that i posted here for Network Enumeration using powershell. 
<br><br>
Test your windows-server machines and Enumerate your server using this commands !

----

### (0) . Short WIFI Powershell Scripts to Get All Stored Wifi-Passwords 

if that doesnt work !

```
(netsh wlan show profiles) -match "All User Profile\s*: (.*)" | %{(netsh wlan show profile $_.trim() key=clear)} | Select-String "Key Content" | ForEach-Object {$_ -replace "Key Content\s*: ", ""}
```

To Display only Keys :

```
(netsh wlan show profile name=wifi-name key=clear) | Select-String "Key Content" | ForEach-Object { $_.ToString().Split(":")[1].Trim() }
```

Display only Wifi-Keys 

IF IT DOES NOT WORK TRY THESE SIMPLE COMMAND ( Everyone Knows :)

```
netsh wlan show profile Name=* Key=clear
```

GET ALL PROFILE NAMES WITH PASSWORDS .

```
(netsh wlan show profiles) | Select-String "\:(.+)$" | %{$name=$_.Matches.Groups[1].Value.Trim(); $_} | %{(netsh wlan show profile name="$name" key=clear)} | Select-String "Key Content\W+\:(.+)$" | %{$pass=$_.Matches.Groups[1].Value.Trim(); $_} | %{[PSCustomObject]@{ PROFILE_NAME=$name;PASSWORD=$pass }} | Format-Table –AutoSize | Out-String -OutVariable dataCaptured
```

#### (1) Retrieve network adapter information, including WLAN and Ethernet adapters.

```
Get-NetAdapter | Select-Object Name, InterfaceDescription, Status, MacAddress, LinkSpeed, MediaType, DriverVersion, DriverDate, PhysicalMediaType, Virtual | Format-Table
```
Explanation : <br>
The Command `Get-NetAdapter` retrieves the adapter name, description, status, MAC address, link speed, media type, driver version, driver date, physical media type, and whether the adapter is virtual.
<br>

#### (2) Display Only Ethernet Adapter

```
Get-NetAdapter -Name Ethernet | Select-Object Name, InterfaceDescription, Status, MacAddress, LinkSpeed, MediaType, DriverVersion, DriverDate, PhysicalMediaType, Virtual | Format-Table
```


#### (3) Gather Information about network connections, running network services

```
Get-NetTCPConnection | Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State | Format-Table
```
Explanation :<br>
This  `Get-NetTCPConnection` retrieves information about active TCP connections on the local computer. 

#### (4) Get Active UDP Endpoints  

```
Get-NetUDPEndpoint | Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort | Format-Table
```
Explanation : <br>
 This `Get-NetUDPEndpoint` retrieves information about active UDP endpoints on the local computer.


#### (5) Display the current value of the TCP
```
Get-NetTCPSetting | Select-Object TcpWindowSize
```
Explanation :<br>
This query retrieves information about the TCP settings on the local computer


#### (6) Get IP-Configuration
```
Get-NetIPConfiguration | Select-Object InterfaceAlias, IPAddress, IPv6Address, PrefixLength, DefaultGateway | Format-Table
```
Explanation : <br>
This query displays the IP address, subnet mask, and default gateway for all network adapters on the local computer

#### (7) Get information about the neighbor cache on Local Machine
```
Get-NetNeighbor | Select-Object IPAddress, LinkLayerAddress, InterfaceIndex | Format-Table
```
Explanation:<br>This will display the MAC address and interface index for all neighbors.

#### (8) Retrieving information about the IP routing table on the local computer
```
Get-NetRoute | Select-Object DestinationPrefix, Netmask, NextHop, InterfaceAlias | Format-Table
```
Explanation:<br>This will display the destination network, netmask, and next hop address for all routes.

#### (9) Retrieves information about running services on your Local Computer

```
Get-Service | Where-Object {$_.Status -eq 'Running' -and $_.StartType -eq 'Auto' -and $_.DisplayName -like '*Network*'} | Select-Object DisplayName, Status, StartType | Format-Table
```
Explanation:<br>This command will list all running network-related services and display their display name, status, and start type.

#### (10) Ping and a Traceroute

Test your machine connectivity to a network resource by performing a ping and a traceroute using Test-NetConnection

```
Test-NetConnection -ComputerName 192.168.1.100
```
Explanation:<br>This will perform a ping and a traceroute to the remote system and display the results.

You can also use the Test-NetConnection cmdlet to test the connectivity to a remote system by its hostname . To do that 

```
Test-NetConnection -ComputerName remote-system.example.com
```
Additionally, you can use the -Port parameter with Test-NetConnection to test connectivity to a specific port on a remote system . To do that

```
Test-NetConnection -ComputerName remote-system.example.com -Port 80
```
Explanation:<br>
This is an example to test the connectivity to port 80 on a remote system, you can use the above Command 

#### (11) Retrieve information about the neighbor cache on the local computer
```
Get-NetNeighbor | Select-Object IPAddress, LinkLayerAddress | Format-Table
```
Explanation:<br>
This will display the IP addresses and MAC addresses of all neighbors on the local network.

#### (12) Retrieve information about network adapters

```
Get-NetAdapter | Select-Object Name, InterfaceDescription, Status, LinkSpeed | Format-Table

```
Explanation:<br>
This command will display the name, interface description, status, and link speed of all network adapters on the local computer


#### (13) Firewall Info 

```
Get-NetFirewallRule | Where-Object {$_.Enabled -eq 'True' -and $_.DisplayName -like '*Network*'} | Select-Object DisplayName, Description, Enabled | Format-Table
```

Explanation:<br>
This command will display the name, description, and enabled status of all firewall rules related to network traffic.

#### (14) Info about IP interfaces

```
Get-NetIPInterface | Select-Object Name, InterfaceIndex, InterfaceMetric | Format-Table
```

Explanation:<br>

This command will display the name, interface index, and interface metric of all IP interfaces on the local computer.

#### (15) View statistics on the local computer

```
Get-NetAdapterStatistics | Select-Object Name, BytesSent, BytesReceived, PacketsSent, PacketsReceived, Errors | Format-Table
```
Explanation:<br>

This command will display the bytes sent and received, packets sent and received, and errors for all network adapters on the local computer.

#### (16)  Retrieves information about TCP settings on the local computer

```
Get-NetTCPSetting | Select-Object *
```
Explanation:<br>

See the maximum number of concurrent connections, the maximum initial window size, and the maximum retransmission time.

#### (17) Retrieves Current TCP Information about local Computer 

```
Get-NetTCPConnection | Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State, OwningProcess | Format-Table
```
Explanation:<br>

display's the local and remote IP addresses and ports, the state, and the process ID (PID) of all current TCP connections, you can use:

#### (18) Retrieves Current UDP information about local Computer
```
Get-NetUDPEndpoint | Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort | Format-Table
```
Explanation :
This will display the local and remote addresses and ports for all active UDP endpoints.


#### (19) Get Basic Infos In Table Format

```
Get-NetAdapter | Select-Object Name, InterfaceDescription, Status, MacAddress, LinkSpeed, MediaType, DriverVersion, DriverDate, PhysicalMediaType, Virtual | Format-Table
```
Explanation:<br>

This script retrieves the adapter name, description, status, MAC address, link speed, media type, driver version, driver date, physical media type, and whether the adapter is virtual. You can modify the Select-Object and Format-Table parameters to retrieve and display different fields.

#### (20) Display information for the Ethernet adapter
```
Get-NetAdapter -Name Ethernet | Select-Object Name, InterfaceDescription, Status, MacAddress, LinkSpeed, MediaType, DriverVersion, DriverDate, PhysicalMediaType, Virtual | Format-Table
```
Explaination:

This will only display information for the Ethernet adapter.

#### (21) Knows Net ip config in an Table Format
```
Get-NetIPConfiguration | Select-Object InterfaceAlias, IPAddress, IPv6Address, PrefixLength, DefaultGateway | Format-Table
```

Explaination:

This command is used to display the IP address, subnet mask, and default gateway for all network adapters on the local computer

#### (22) Get neighbor cache on the local computer 
```
Get-NetNeighbor | Select-Object IPAddress, LinkLayerAddress, InterfaceIndex | Format-Table
```

Explain:

This will display the MAC address and interface index for all neighbors.

#### (23) To List All Network Related Servics 
```
Get-Service | Where-Object {$_.Status -eq 'Running' -and $_.StartType -eq 'Auto' -and $_.DisplayName -like '*Network*'} | Select-Object DisplayName, Status, StartType | Format-Table
```
Explain: 

This is to list all running network-related services on local computer

#### (24) Get Firewall basic infos
```
Get-NetFirewallRule | Where-Object {$_.Enabled -eq 'True' -and $_.DisplayName -like '*Network*'} | Select-Object DisplayName, Description, Enabled | Format-Table
```
Explain : 

The command display the name, description, and enabled status of all firewall rules related to network traffic.

#### (25) Get IP Interfaces on Local Computer
```
Get-NetIPInterface | Select-Object Name, InterfaceIndex, InterfaceMetric | Format-Table
```

Explain :

This command will display the name, interface index, and interface metric of all IP interfaces on the local computer.

#### (26) Analyse Packects 
```
Get-NetAdapterStatistics | Select-Object Name, BytesSent, BytesReceived, PacketsSent, PacketsReceived, Errors | Format-Table
```
Explain :

This command will display the bytes sent and received, packets sent and received, and errors for all network adapters on the local computer.

#### (27) Retrive Values of TCP
```
Get-NetTCPSetting | Select-Object *
```
Explain :

This command will display the current values of all TCP settings, including the maximum number of concurrent connections, the maximum initial window size, and the maximum retransmission time.

#### (28) Retrive inforation about Routing Tables
```
Get-NetRoute | Select-Object DestinationPrefix, PrefixLength, NextHop, RouteMetric, InterfaceIndex | Format-Table
```
Explain :

This will display the network destination, network mask, gateway, and interface index for all routes in the routing table.
