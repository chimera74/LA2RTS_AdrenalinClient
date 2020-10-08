uses SysUtils,TCP;
  
{$I Vars.pas}

//test 

label
  start_connection;

procedure OnFree;
begin
	TCPSocket.Free;
	IsBGThreadsEnabled := false;
end;

procedure Init;
begin
	IsQuickSelfInfoSendingEnabled := false;
	IsQuickNPCInfoSendingEnabled := false;
	
	lastPingTime := 0;
	lastDataMessageTime := 0;
	lastQuickSelfnfoMessageTime := 0;
	lastQuickNPCInfoHFMessageTime := 0;
	lastQuickNPCInfoLFMessageTime := 0;
	lastQuickPlayerInfoHFMessageTime := 0;
	lastQuickPlayerInfoLFMessageTime := 0;
end;

procedure LogDebug(sender, str: string);
begin
	if IsDebugLogEnabled then
		Engine.MSG(sender, str, 0);
end;

procedure LogError(sender, str: string);
begin
	Engine.MSG(sender, str, 255);
end;

//test 

{$I SendProcs.pas}
{$I EventProcs.pas}
{$I RecvProcs.pas}

procedure ProcessInGameCheck;
begin
	if Engine.Status = lsOnline then
	begin
		if IsInGame = false then
		begin
			IsInGame := true;
			print('Status changed to IsInGame = true');
		end;
	end
	else
	begin
		if IsInGame = true then
		begin
			IsInGame := false;
			print('Status changed to IsInGame = false');
		end;		
	end;
end;

begin
  
	IP := '127.0.0.1';
	Port := '30512';

	TCPSocket := TTCPBlockSocket.Create;
  
start_connection:
	Init();
	TCPSocket.Connect(IP, Port);
	if (TCPSocket.LastError <> 0) then  
	begin
		IsBGThreadsEnabled := false;
		print('Failed to connect. Error: ' + TCPSocket.LastError.tostring + '. Retrying in 5 sec.');
		Delay(5000);
		goto start_connection
	end;

	//connetced
	print('Connected.');
	lastPingTime := 0;
	IsBGThreadsEnabled := true;
	Script.NewThread(@EventMonitoring);
  
	repeat    

		// Master loop	
		ProcessDataRecieve();
		ProcessDataSend();
		ProcessInGameCheck();


		if sendRes = 0 then break;

		Delay(10);
	
	until false;
	IsBGThreadsEnabled := false;
	print('Lost connection. Reconnecting in 5 sec.');
	TCPSocket.Free;
	Delay(5000);
	TCPSocket := TTCPBlockSocket.Create;
	goto start_connection;
  
end.