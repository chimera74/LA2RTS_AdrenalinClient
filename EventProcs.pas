procedure TCPSend2;
begin
	sendRes := TCPSocket.SendBuffer(@SendBuff2, sendBuffLength2);
end;

procedure SendSingleNpcFullInfo(P : Pointer);
begin	
	SendBuff2[0] := $06;
	sendBuffLength2 := 0;
	PutIntToBuff(1, SendBuff2, sendBuffLength2);	
	PutNPCFullInfoToBuff(TL2Npc(P), SendBuff2, sendBuffLength2);	
	PutMessageLengthToBuff(SendBuff2, sendBuffLength2);
	
	Script.MainProc(TCPSend2); 
	LogDebug('SendSingleNpcFullInfo', 'Sending full info about: ' + TL2Npc(P).Name);
end;

procedure SendSingleNpcQuickInfo(P : Pointer);
begin	
	SendBuff2[0] := $07;
	sendBuffLength2 := 0;
	PutIntToBuff(1, SendBuff2, sendBuffLength2);	
	PutNPCQuickInfoToBuff(TL2Npc(P), SendBuff2, sendBuffLength2);	
	PutMessageLengthToBuff(SendBuff2, sendBuffLength2);
	
	Script.MainProc(TCPSend2); 
	LogDebug('SendSingleNpcQuickInfo', 'Sending short info about: ' + TL2Npc(P).Name);
end;

procedure SendSinglePlayerFullInfo(P : Pointer);
begin	
	SendBuff2[0] := $08;
	sendBuffLength2 := 0;
	PutIntToBuff(1, SendBuff2, sendBuffLength2);	
	PutPlayerFullInfoToBuff(TL2Char(P), SendBuff2, sendBuffLength2);	
	PutMessageLengthToBuff(SendBuff2, sendBuffLength2);
	
	Script.MainProc(TCPSend2); 
	LogDebug('SendSinglePlayerFullInfo', 'Sending full info about: ' + TL2Char(P).Name);
end;

procedure SendSinglePlayerQuickInfo(P : Pointer);
begin	
	SendBuff2[0] := $09;
	sendBuffLength2 := 0;
	PutIntToBuff(1, SendBuff2, sendBuffLength2);	
	PutPlayerQuickInfoToBuff(TL2Char(P), SendBuff2, sendBuffLength2);	
	PutMessageLengthToBuff(SendBuff2, sendBuffLength2);
	
	Script.MainProc(TCPSend2); 
	LogDebug('SendSinglePlayerQuickInfo', 'Sending short info about: ' + TL2Char(P).Name);
end;

procedure ProcessSpawn(P : Pointer);
begin
	LogDebug('ProcessSpawn', 'Spawned: ' + TL2Spawn(P).Name);
	if TL2Spawn(P).ClassType = TL2Npc then
		SendSingleNpcFullInfo(P)
	else if TL2Spawn(P).ClassType = TL2Char then
		SendSinglePlayerFullInfo(P)
	else
		print('Other');
end;

procedure ProcessMovement(P : Pointer);
begin
	LogDebug('ProcessMovement', 'Moved: ' + TL2Spawn(P).Name);
	if TL2Spawn(P).ClassType = TL2Npc then
		SendSingleNpcQuickInfo(P)
	else if TL2Spawn(P).ClassType = TL2Char then
		SendSinglePlayerQuickInfo(P)
	else
		print('Other');
end;

procedure EventMonitoring;
var
	P1, P2 : Pointer;
	captAction : TL2Action;
begin
	While IsBGThreadsEnabled do
	begin
		captAction := Engine.WaitAction(TL2Actions([1, 27, 28]), P1, P2, 500);
		if captAction = laSpawn then begin
			ProcessSpawn(P1)
		end else if (Ord(captAction) = 27) or (Ord(captAction) = 28) then // Start and stop movement
			ProcessMovement(P1);
	end;
end;