function ReadStrFromBuf() : string;
var strLength : Integer;
begin
	Move(RecvBuff[recvBuffPos], strLength, 4);
	recvBuffPos := recvBuffPos + 4;
	setLength(Result, strLength);
	Move(RecvBuff[recvBuffPos], Result[1], strLength * 2);
	recvBuffPos := recvBuffPos + strLength * 2;
end;

function ReadIntFromBuf() : Integer;
begin
	Move(RecvBuff[recvBuffPos], Result, 4);
	recvBuffPos := recvBuffPos + 4;
end;

function ReadBoolFromBuf() : Boolean;
begin
	Result := recvBuff[recvBuffPos] = 1;
	recvBuffPos := recvBuffPos + 1;
end;

procedure ProcessPositionSendEnable;
begin
	Case RecvBuff[1] of
	0: IsQuickSelfInfoSendingEnabled := false;
	1: IsQuickSelfInfoSendingEnabled := true;
	else
		LogError('ProcessPositionSendEnable', 'Wrong parameter');
	end;
	LogDebug('ProcessPositionSendEnable', 'Recieved position transmit enable ' + IsQuickSelfInfoSendingEnabled.tostring + ' packet');
end;

procedure ProcessQuickNpcInfoSendEnable;
begin
	Case RecvBuff[1] of
	0: IsQuickNPCInfoSendingEnabled := false;
	1: IsQuickNPCInfoSendingEnabled := true;
	else
		LogError('ProcessQuickNpcInfoSendEnable', 'Wrong parameter');
	end;
	LogDebug('ProcessQuickNpcInfoSendEnable', 'Recieved quick NPC info transmit enable ' + IsQuickNPCInfoSendingEnabled.tostring + ' packet');
end;

procedure ProcessQuickPlayerInfoSendEnable;
begin
	Case RecvBuff[1] of
	0: IsQuickPlayerInfoSendingEnabled := false;
	1: IsQuickPlayerInfoSendingEnabled := true;
	else
		LogError('ProcessQuickPlayerInfoSendEnable', 'Wrong parameter');
	end;
	LogDebug('ProcessQuickPlayerInfoSendEnable', 'Recieved quick player info transmit enable ' + IsQuickPlayerInfoSendingEnabled.tostring + ' packet');
end;

procedure ProcessSelfInfoRequest;
begin
	LogDebug('ProcessSelfInfoRequest', 'Recieved self info request');
	SendSelfInfo();
end;

procedure ProcessStatusRequest;
begin
	LogDebug('ProcessStatusRequest', 'Recieved status request');
	SendStatus();
end;

procedure EnterCredentialsTask;
begin
	Engine.EnterText(Login);	
	Engine.UseKey('TAB');
	Delay(300);
	Engine.EnterText(Password);
	Delay(2000);
	Engine.UseKey('Enter');
	Delay(2000);
	Engine.UseKey('Enter');
end;

procedure ProcessEnterCredentialsCommand;
begin

	Login := ReadStrFromBuf();
	Password := ReadStrFromBuf();
	
	LogDebug('ProcessEnterCredentialsCommand', 'Entering credentials for ' + Login);
	
	if Engine.Status = lsOff then
		Script.NewThread(@EnterCredentialsTask);
	
end;

procedure ProcessEnterWorldCommand;
begin
	LogDebug('ProcessEnterWorldCommand', 'Entering world');
	Engine.GameStart;
end;

procedure ProcessFullNpcInfoRequest;
begin
	LogDebug('ProcessFullNpcInfoRequest', 'Recieved full npc info request');
	SendFullNPCInfo();
end;

procedure ProcessFullPlayerInfoRequest;
begin
	LogDebug('ProcessFullPlayerInfoRequest', 'Recieved full player info request');
	SendFullPlayerInfo();
end;

procedure ProcessFullNpcInfoByOIDRequest;
var OIDs : array of Integer;
	i, OIDAmount : Integer;
begin
	LogDebug('ProcessFullNpcInfoRequest', 'Recieved full npc info by OIDs request');
	OIDAmount := ReadIntFromBuf();
	SetLength(OIDs, OIDAmount);
	for i:=0 to OIDAmount - 1 do begin
		OIDs[i] := ReadIntFromBuf();
	end;
	SendFullNPCInfoByOIDs(OIDs);
end;

procedure ProcessFullPlayerInfoByOIDRequest;
var OIDs : array of Integer;
	i, OIDAmount : Integer;
begin
	LogDebug('ProcessFullPlayerInfoByOIDRequest', 'Recieved full player info by OIDs request');
	OIDAmount := ReadIntFromBuf();
	SetLength(OIDs, OIDAmount);
	for i:=0 to OIDAmount - 1 do begin
		OIDs[i] := ReadIntFromBuf();
	end;
	SendFullPlayerInfoByOIDs(OIDs);
end;

procedure ProcessUnknownPacket;
begin
	LogError('ProcessUnknownPacket', 'Unknown packet ' + RecvBuff[0].tostring());
end;

procedure ProcessMoveToCommand;
var x,y,z : Integer;
begin
	x := ReadIntFromBuf();
	y := ReadIntFromBuf();
	z := ReadIntFromBuf();
	LogDebug('ProcessMoveToCommand', 'Moving to [' + x.tostring() + ', ' + y.tostring() + ', ' + z.tostring() + ']');
	Engine.DMoveTo(x,y,z);
end;

procedure ProcessTargetCommand;
var OID, I : Integer;
begin
	OID := ReadIntFromBuf();
	
	if User.OID = OID then begin
		LogDebug('ProcessTargetCommand', 'Targeting ' + User.Name);
		Engine.SetTarget(User);
		exit;
	end;
	
	for I:=0 to NPCList.Count - 1 do
		if NPCList.Items(I).OID = OID then  begin
			LogDebug('ProcessTargetCommand', 'Targeting ' + NPCList.Items(I).Name);
			Engine.SetTarget(NPCList.Items(I));
			exit;
		end;
		
	for I:=0 to CharList.Count - 1 do
		if CharList.Items(I).OID = OID then  begin
			LogDebug('ProcessTargetCommand', 'Targeting ' + CharList.Items(I).Name);
			Engine.SetTarget(CharList.Items(I));
			exit;
		end;
		
	LogError('ProcessTargetCommand', 'Target with OID ' + OID.tostring() + ' not found');
end;

procedure ProcessUseActionCommand;
var ID, I : Integer;
	ctrl : Boolean;
begin
	ID := ReadIntFromBuf();
	ctrl := ReadBoolFromBuf();
	
	if Engine.Attack(0, ctrl) then
		LogDebug('ProcessUseActionCommand', 'Used skill ' + ID.tostring())
	else
		LogError('ProcessUseSkillCommand', 'Failed to use skill ' + ID.tostring());
end;

procedure ProcessUseSkillCommand;
var ID, I : Integer;
	ctrl : Boolean;
begin
	ID := ReadIntFromBuf();
	ctrl := ReadBoolFromBuf();
	
	if Engine.UseSkill(ID, ctrl) then
		LogDebug('ProcessUseSkillCommand', 'Used action ' + ID.tostring())
	else
		LogError('ProcessUseActionCommand', 'Failed to use action ' + ID.tostring());
end;

procedure ReadMessage();
var messageLength : Word;
begin
	RecvBuff[0] := TCPSocket.RecvByte(10);
	RecvBuff[1] := TCPSocket.RecvByte(10);
	RecvBuff[2] := TCPSocket.RecvByte(10);
	
	Move(RecvBuff[1], messageLength, 2);
	LogDebug('ReadMessage', 'Recieved packet: ' + RecvBuff[0].tostring() + ' Size: ' + messageLength.tostring());
	if messageLength > 1024 - 3 then
		LogError('ReadMessage', 'Packet too big for buffer');
	
	if messageLength = 0 then
		exit;
		
	for i:=0 to messageLength - 1 do
		RecvBuff[3 + i] := TCPSocket.RecvByte(10);
end;

procedure ProcessDataRecieve;
begin
	waitingDataAmount := TCPSocket.WaitingData();    
	
	while waitingDataAmount >= 3 do begin
		//LogDebug('Waiting Data: ' + waitingDataAmount.tostring());
		ReadMessage();
		recvBuffPos := 3;
		Case RecvBuff[0] of
			STATUS_REQUEST : ProcessStatusRequest();
			SELF_INFO_REQUEST : ProcessSelfInfoRequest();
			POSITION_SEND_ENABLE : ProcessPositionSendEnable();
			ENTER_CREDENTIALS_COMMAND : ProcessEnterCredentialsCommand();
			ENTER_WORLD_COMMAND : ProcessEnterWorldCommand();
			MOVE_TO_COMMAND : ProcessMoveToCommand();
			FULL_NPC_INFO_REQUEST : ProcessFullNpcInfoRequest();
			QUICK_NPC_INFO_SEND_ENABLE : ProcessQuickNpcInfoSendEnable();
			FULL_NPC_INFO_BY_OID_REQUEST : ProcessFullNpcInfoByOIDRequest();
			FULL_PLAYER_INFO_REQUEST : ProcessFullPlayerInfoRequest();
			QUICK_PLAYER_INFO_SEND_ENABLE: ProcessQuickPlayerInfoSendEnable();
			FULL_PLAYER_INFO_BY_OID_REQUEST : ProcessFullPlayerInfoByOIDRequest();
			TARGET_COMMAND : ProcessTargetCommand();
			USE_ACTION_COMMAND : ProcessUseActionCommand();			
			USE_SKILL_COMMAND : ProcessUseSkillCommand();
		else 
			ProcessUnknownPacket();
		end;
		waitingDataAmount := TCPSocket.WaitingData();
	end;
end;
