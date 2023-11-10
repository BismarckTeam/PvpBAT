@echo on
color b
netsh int tcp set heuristics disabled
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\be337238-0d82-4146-a960-4f3749d470c7" /f /v "Attributes" /t REG_SZ /d 2
chcp 65001 > nul
color A
netsh int tcp set heuristics disabled
netsh int tcp set global nonsackrttresiliency=disabled
netsh int tcp set global netdma=enabled
netsh int ipv6 set global defaultcurhoplimit=64
set supplemental congestionprovider=false
netsh int tcp set heuristics disabled
netsh int tcp set global rss=enabled
netsh int tcp set global chimney=disabled
netsh int tcp set global rsc=disabled
netsh int tcp set global nonsackrttresiliency=disabled
netsh int tcp set global maxsynretransmissions=2
netsh int tcp set global fastopen=enabled
netsh int tcp set global ecncapability=disabled
netsh int tcp set global timestamps=disabled
netsh int tcp set global knockback=0

color 3
netsh interface ipv4 set subinterface "Ethernet" mtu=666 store=persistent
netsh interface ipv6 set subinterface "Ethernet" mtu=666 store=persistent


set TcpDelAckTicks 2
set TcpAckFrequency 1 
set TCPNoDelay 1 
set MTU 100 
set MSS 100 
set MaxUserPort 1 
set DefaultTTL 114 
set NetTick 10

@Echo off 
cd %systemroot%\system32
call :IsAdmin
for /f "usebackq" %%i in (`reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces`) do (
Reg.exe add %%i /v "TcpAckFrequency" /d "1" /t REG_DWORD /f
Reg.exe add %%i /v "TCPNoDelay" /d "1" /t REG_DWORD /f
Reg.exe add %%i /v "TcpDelAckTicks" /d "0" /t REG_DWORD /f
)
color b
ipconfig /flushdns
netsh interface ip delete arpcache
netsh winsock reset catalog
netsh int ip reset c:resetlog.txt

set TcpDelAckTicks 2
set TCPNoDelay 1 
set MTU 100 
set MSS 100 
set MaxUserPort 1 
set DefaultTTL 114 
set NetTick 10
@echo on
call connection\enthernet.bat
color d
@echo Done!
TIMEOUT /T 10 /NOBREAK 