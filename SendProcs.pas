procedure PutIntToBuff(val: Integer; var buff : array of byte; var buffLength : Integer);
begin
	Move(val, buff[buffLength + 3], 4);
	buffLength := buffLength + 4;
end;

procedure PutInt64ToBuff(val: Int64; var buff : array of byte; var buffLength : Integer);
begin
  Move(val, buff[buffLength + 3], 8);
  buffLength := buffLength + 8;
end;

procedure PutStrToBuff(str: string; var buff : array of byte; var buffLength : Integer);
var strLen : Integer;
begin
  strLen := Length(str) * 2;
  PutIntToBuff(strLen, buff, buffLength);
  Move(str[1], buff[buffLength + 3], strLen);
  buffLength := buffLength + strLen;
end;

procedure PutDoubleToBuff(val: Double; var buff : array of byte; var buffLength : Integer);
begin
  Move(val, buff[buffLength + 3], 8);
  buffLength := buffLength + 8;
end;

procedure PutByteToBuff(val: Byte; var buff : array of byte; var buffLength : Integer);
begin
  Move(val, buff[buffLength + 3], 1);
  buffLength := buffLength + 1;
end;

procedure PutBoolToBuff(val: Boolean; var buff : array of byte; var buffLength : Integer);
begin
	if val then
		buff[buffLength + 3] := 1
	else
		buff[buffLength + 3] := 0;
	buffLength := buffLength + 1;
end;

procedure PutMessageLengthToBuff(var buff : array of byte; var buffLength : Integer);
begin
	Move(buffLength, buff[1], 2);
	buffLength := buffLength + 3;
end;

procedure PutNPCFullInfoToBuff(npc : TL2Npc; var buff : array of byte; var buffLength : Integer);
begin
	// TL2Object
	PutIntToBuff(npc.OID, buff, buffLength);
	PutIntToBuff(npc.ID, buff, buffLength);
	PutStrToBuff(npc.Name, buff, buffLength);
	PutBoolToBuff(npc.Valid, buff, buffLength);
	
	// TL2Spawn
	PutIntToBuff(npc.X, buff, buffLength);
	PutIntToBuff(npc.Y, buff, buffLength);
	PutIntToBuff(npc.Z, buff, buffLength);
	PutIntToBuff(npc.SpawnTime, buff, buffLength);
	
	// TL2Live
	PutIntToBuff(npc.AbnormalID, buff, buffLength);
	PutIntToBuff(npc.AllyID, buff, buffLength);
	PutIntToBuff(npc.AtkOID, buff, buffLength);
	PutIntToBuff(npc.AtkTime, buff, buffLength);
	PutIntToBuff(npc.ClanID, buff, buffLength);
	PutIntToBuff(npc.CurHP, buff, buffLength);
	PutIntToBuff(npc.CurMP, buff, buffLength);
	PutIntToBuff(npc.Fishing, buff, buffLength);
	PutIntToBuff(npc.HP, buff, buffLength);
	PutIntToBuff(npc.Karma, buff, buffLength);
	PutIntToBuff(npc.Level, buff, buffLength);
	PutIntToBuff(npc.Load, buff, buffLength);
	PutIntToBuff(npc.MaxHP, buff, buffLength);
	PutIntToBuff(npc.MaxMP, buff, buffLength);
	PutIntToBuff(npc.MP, buff, buffLength);
	PutIntToBuff(npc.MyAtkTime, buff, buffLength);
	PutIntToBuff(npc.SP, buff, buffLength);
	PutIntToBuff(npc.Target.OID, buff, buffLength);
	PutIntToBuff(npc.Team, buff, buffLength);
	PutIntToBuff(npc.TeleportDist, buff, buffLength);
	PutIntToBuff(npc.TeleportTime, buff, buffLength);
	PutIntToBuff(npc.ToX, buff, buffLength);
	PutIntToBuff(npc.ToY, buff, buffLength);
	PutIntToBuff(npc.ToZ, buff, buffLength);
	
	PutDoubleToBuff(npc.Speed, buff, buffLength);
	
	PutInt64ToBuff(npc.Exp, buff, buffLength);
	PutInt64ToBuff(npc.Exp2, buff, buffLength);
	
	PutBoolToBuff(npc.Attackable, buff, buffLength);
	PutBoolToBuff(npc.Dead, buff, buffLength);
	PutBoolToBuff(npc.Dropped, buff, buffLength);
	PutBoolToBuff(npc.Fly, buff, buffLength);
	PutBoolToBuff(npc.InCombat, buff, buffLength);
	PutBoolToBuff(npc.IsMember, buff, buffLength);
	PutBoolToBuff(npc.Moved, buff, buffLength);
	PutBoolToBuff(npc.PK, buff, buffLength);
	PutBoolToBuff(npc.PvP, buff, buffLength);
	PutBoolToBuff(npc.Running, buff, buffLength);
	PutBoolToBuff(npc.Sitting, buff, buffLength);
	PutBoolToBuff(npc.Sweepable, buff, buffLength);
	
	PutStrToBuff(npc.Ally, buff, buffLength);
	PutStrToBuff(npc.Clan, buff, buffLength);
	PutStrToBuff(npc.Title, buff, buffLength);
	
	// TL2Npc
	PutBoolToBuff(npc.IsPet, buff, buffLength);
	PutIntToBuff(npc.PetType, buff, buffLength);
end;

procedure PutNPCQuickInfoToBuff(npc : TL2Npc; var buff : array of byte; var buffLength : Integer);
begin
	// TL2Object
	PutIntToBuff(npc.OID, buff, buffLength);
	PutBoolToBuff(npc.Valid, buff, buffLength);
	
	// TL2Spawn
	PutIntToBuff(npc.X, buff, buffLength);
	PutIntToBuff(npc.Y, buff, buffLength);
	PutIntToBuff(npc.Z, buff, buffLength);
	
	// TL2Live
	PutIntToBuff(npc.AbnormalID, buff, buffLength);	
	PutIntToBuff(npc.AtkOID, buff, buffLength);
	PutIntToBuff(npc.AtkTime, buff, buffLength);	
	PutIntToBuff(npc.CurHP, buff, buffLength);
	PutIntToBuff(npc.CurMP, buff, buffLength);	
	PutIntToBuff(npc.HP, buff, buffLength);	
	PutIntToBuff(npc.MaxHP, buff, buffLength);
	PutIntToBuff(npc.MaxMP, buff, buffLength);
	PutIntToBuff(npc.MP, buff, buffLength);
	PutIntToBuff(npc.Target.OID, buff, buffLength);
	PutIntToBuff(npc.ToX, buff, buffLength);
	PutIntToBuff(npc.ToY, buff, buffLength);
	PutIntToBuff(npc.ToZ, buff, buffLength);
	
	PutDoubleToBuff(npc.Speed, buff, buffLength);
	
	PutBoolToBuff(npc.Attackable, buff, buffLength);
	PutBoolToBuff(npc.Dead, buff, buffLength);
	PutBoolToBuff(npc.Dropped, buff, buffLength);
	PutBoolToBuff(npc.InCombat, buff, buffLength);
	PutBoolToBuff(npc.Moved, buff, buffLength);
	PutBoolToBuff(npc.PK, buff, buffLength);
	PutBoolToBuff(npc.PvP, buff, buffLength);
	PutBoolToBuff(npc.Running, buff, buffLength);
	PutBoolToBuff(npc.Sitting, buff, buffLength);
	PutBoolToBuff(npc.Sweepable, buff, buffLength);
end;

procedure PutPlayerFullInfoToBuff(pl : TL2Char; var buff : array of byte; var buffLength : Integer);
begin
	// TL2Object
	PutIntToBuff(pl.OID, buff, buffLength);
	PutIntToBuff(pl.ID, buff, buffLength);
	PutStrToBuff(pl.Name, buff, buffLength);
	PutBoolToBuff(pl.Valid, buff, buffLength);
	
	// TL2Spawn
	PutIntToBuff(pl.X, buff, buffLength);
	PutIntToBuff(pl.Y, buff, buffLength);
	PutIntToBuff(pl.Z, buff, buffLength);
	PutIntToBuff(pl.SpawnTime, buff, buffLength);
	
	// TL2Live
	PutIntToBuff(pl.AbnormalID, buff, buffLength);
	PutIntToBuff(pl.AllyID, buff, buffLength);
	PutIntToBuff(pl.AtkOID, buff, buffLength);
	PutIntToBuff(pl.AtkTime, buff, buffLength);
	PutIntToBuff(pl.ClanID, buff, buffLength);
	PutIntToBuff(pl.CurHP, buff, buffLength);
	PutIntToBuff(pl.CurMP, buff, buffLength);
	PutIntToBuff(pl.Fishing, buff, buffLength);
	PutIntToBuff(pl.HP, buff, buffLength);
	PutIntToBuff(pl.Karma, buff, buffLength);
	PutIntToBuff(pl.Level, buff, buffLength);
	PutIntToBuff(pl.Load, buff, buffLength);
	PutIntToBuff(pl.MaxHP, buff, buffLength);
	PutIntToBuff(pl.MaxMP, buff, buffLength);
	PutIntToBuff(pl.MP, buff, buffLength);
	PutIntToBuff(pl.MyAtkTime, buff, buffLength);
	PutIntToBuff(pl.SP, buff, buffLength);
	PutIntToBuff(pl.Target.OID, buff, buffLength);
	PutIntToBuff(pl.Team, buff, buffLength);
	PutIntToBuff(pl.TeleportDist, buff, buffLength);
	PutIntToBuff(pl.TeleportTime, buff, buffLength);
	PutIntToBuff(pl.ToX, buff, buffLength);
	PutIntToBuff(pl.ToY, buff, buffLength);
	PutIntToBuff(pl.ToZ, buff, buffLength);
	
	PutDoubleToBuff(pl.Speed, buff, buffLength);
	
	PutInt64ToBuff(pl.Exp, buff, buffLength);
	PutInt64ToBuff(pl.Exp2, buff, buffLength);
	
	PutBoolToBuff(pl.Attackable, buff, buffLength);
	PutBoolToBuff(pl.Dead, buff, buffLength);
	PutBoolToBuff(pl.Dropped, buff, buffLength);
	PutBoolToBuff(pl.Fly, buff, buffLength);
	PutBoolToBuff(pl.InCombat, buff, buffLength);
	PutBoolToBuff(pl.IsMember, buff, buffLength);
	PutBoolToBuff(pl.Moved, buff, buffLength);
	PutBoolToBuff(pl.PK, buff, buffLength);
	PutBoolToBuff(pl.PvP, buff, buffLength);
	PutBoolToBuff(pl.Running, buff, buffLength);
	PutBoolToBuff(pl.Sitting, buff, buffLength);
	PutBoolToBuff(pl.Sweepable, buff, buffLength);
	
	PutStrToBuff(pl.Ally, buff, buffLength);
	PutStrToBuff(pl.Clan, buff, buffLength);
	PutStrToBuff(pl.Title, buff, buffLength);
	
	// TL2Char
	PutIntToBuff(pl.CP, buff, buffLength);
	PutIntToBuff(pl.CurCP, buff, buffLength);
	PutIntToBuff(pl.MaxCP, buff, buffLength);
	PutIntToBuff(pl.ClassID, buff, buffLength);
	PutIntToBuff(pl.MainClass, buff, buffLength);
	PutIntToBuff(pl.Sex, buff, buffLength);
	PutIntToBuff(pl.Race, buff, buffLength);
	PutIntToBuff(pl.CubicCount, buff, buffLength);
	PutIntToBuff(pl.Recom, buff, buffLength);
	
	PutByteToBuff(pl.MountType, buff, buffLength);
	PutByteToBuff(pl.StoreType, buff, buffLength);
	
	PutBoolToBuff(pl.Hero, buff, buffLength);
	PutBoolToBuff(pl.Noble, buff, buffLength);
	PutBoolToBuff(pl.Premium, buff, buffLength);
	
end;

procedure PutPlayerQuickInfoToBuff(pl : TL2Char; var buff : array of byte; var buffLength : Integer);
begin
	// TL2Object
	PutIntToBuff(pl.OID, buff, buffLength);
	PutBoolToBuff(pl.Valid, buff, buffLength);
	
	// TL2Spawn
	PutIntToBuff(pl.X, buff, buffLength);
	PutIntToBuff(pl.Y, buff, buffLength);
	PutIntToBuff(pl.Z, buff, buffLength);
	
	// TL2Live
	PutIntToBuff(pl.AbnormalID, buff, buffLength);	
	PutIntToBuff(pl.AtkOID, buff, buffLength);
	PutIntToBuff(pl.AtkTime, buff, buffLength);	
	PutIntToBuff(pl.CurHP, buff, buffLength);
	PutIntToBuff(pl.CurMP, buff, buffLength);	
	PutIntToBuff(pl.HP, buff, buffLength);	
	PutIntToBuff(pl.MaxHP, buff, buffLength);
	PutIntToBuff(pl.MaxMP, buff, buffLength);
	PutIntToBuff(pl.MP, buff, buffLength);
	PutIntToBuff(pl.Target.OID, buff, buffLength);
	PutIntToBuff(pl.ToX, buff, buffLength);
	PutIntToBuff(pl.ToY, buff, buffLength);
	PutIntToBuff(pl.ToZ, buff, buffLength);
	
	PutDoubleToBuff(pl.Speed, buff, buffLength);
	
	PutBoolToBuff(pl.Attackable, buff, buffLength);
	PutBoolToBuff(pl.Dead, buff, buffLength);
	PutBoolToBuff(pl.Dropped, buff, buffLength);
	PutBoolToBuff(pl.InCombat, buff, buffLength);
	PutBoolToBuff(pl.Moved, buff, buffLength);
	PutBoolToBuff(pl.PK, buff, buffLength);
	PutBoolToBuff(pl.PvP, buff, buffLength);
	PutBoolToBuff(pl.Running, buff, buffLength);
	PutBoolToBuff(pl.Sitting, buff, buffLength);
	PutBoolToBuff(pl.Sweepable, buff, buffLength);
	
	// TL2Char
	PutIntToBuff(pl.CP, buff, buffLength);
	PutIntToBuff(pl.CurCP, buff, buffLength);
	PutIntToBuff(pl.MaxCP, buff, buffLength);
	PutIntToBuff(pl.CubicCount, buff, buffLength);
end;

procedure PutFullSelfInfoToBuff(var buff : array of byte; var buffLength : Integer);
begin
	// TL2Object
	PutIntToBuff(User.OID, buff, buffLength);
	PutIntToBuff(User.ID, buff, buffLength);
	PutStrToBuff(User.Name, buff, buffLength);
	PutBoolToBuff(User.Valid, buff, buffLength);
	
	// TL2Spawn
	PutIntToBuff(User.X, buff, buffLength);
	PutIntToBuff(User.Y, buff, buffLength);
	PutIntToBuff(User.Z, buff, buffLength);
	PutIntToBuff(User.SpawnTime, buff, buffLength);
	
	// TL2Live
	PutIntToBuff(User.AbnormalID, buff, buffLength);
	PutIntToBuff(User.AllyID, buff, buffLength);
	PutIntToBuff(User.AtkOID, buff, buffLength);
	PutIntToBuff(User.AtkTime, buff, buffLength);
	PutIntToBuff(User.ClanID, buff, buffLength);
	PutIntToBuff(User.CurHP, buff, buffLength);
	PutIntToBuff(User.CurMP, buff, buffLength);
	PutIntToBuff(User.Fishing, buff, buffLength);
	PutIntToBuff(User.HP, buff, buffLength);
	PutIntToBuff(User.Karma, buff, buffLength);
	PutIntToBuff(User.Level, buff, buffLength);
	PutIntToBuff(User.Load, buff, buffLength);
	PutIntToBuff(User.MaxHP, buff, buffLength);
	PutIntToBuff(User.MaxMP, buff, buffLength);
	PutIntToBuff(User.MP, buff, buffLength);
	PutIntToBuff(User.MyAtkTime, buff, buffLength);
	PutIntToBuff(User.SP, buff, buffLength);
	PutIntToBuff(User.Target.OID, buff, buffLength);
	PutIntToBuff(User.Team, buff, buffLength);
	PutIntToBuff(User.TeleportDist, buff, buffLength);
	PutIntToBuff(User.TeleportTime, buff, buffLength);
	PutIntToBuff(User.ToX, buff, buffLength);
	PutIntToBuff(User.ToY, buff, buffLength);
	PutIntToBuff(User.ToZ, buff, buffLength);
	
	PutDoubleToBuff(User.Speed, buff, buffLength);
	
	PutInt64ToBuff(User.Exp, buff, buffLength);
	PutInt64ToBuff(User.Exp2, buff, buffLength);
	
	PutBoolToBuff(User.Attackable, buff, buffLength);
	PutBoolToBuff(User.Dead, buff, buffLength);
	PutBoolToBuff(User.Dropped, buff, buffLength);
	PutBoolToBuff(User.Fly, buff, buffLength);
	PutBoolToBuff(User.InCombat, buff, buffLength);
	PutBoolToBuff(User.IsMember, buff, buffLength);
	PutBoolToBuff(User.Moved, buff, buffLength);
	PutBoolToBuff(User.PK, buff, buffLength);
	PutBoolToBuff(User.PvP, buff, buffLength);
	PutBoolToBuff(User.Running, buff, buffLength);
	PutBoolToBuff(User.Sitting, buff, buffLength);
	PutBoolToBuff(User.Sweepable, buff, buffLength);
	
	PutStrToBuff(User.Ally, buff, buffLength);
	PutStrToBuff(User.Clan, buff, buffLength);
	PutStrToBuff(User.Title, buff, buffLength);
	
	// TL2Char
	PutIntToBuff(User.CP, buff, buffLength);
	PutIntToBuff(User.CurCP, buff, buffLength);
	PutIntToBuff(User.MaxCP, buff, buffLength);
	PutIntToBuff(User.ClassID, buff, buffLength);
	PutIntToBuff(User.MainClass, buff, buffLength);
	PutIntToBuff(User.Sex, buff, buffLength);
	PutIntToBuff(User.Race, buff, buffLength);
	PutIntToBuff(User.CubicCount, buff, buffLength);
	PutIntToBuff(User.Recom, buff, buffLength);
	
	PutByteToBuff(User.MountType, buff, buffLength);
	PutByteToBuff(User.StoreType, buff, buffLength);
	
	PutBoolToBuff(User.Hero, buff, buffLength);
	PutBoolToBuff(User.Noble, buff, buffLength);
	PutBoolToBuff(User.Premium, buff, buffLength);
	
	//TL2User
	PutBoolToBuff(User.CanCryst, buff, buffLength);
	
	PutIntToBuff(User.Recom, buff, buffLength);
	PutIntToBuff(User.Charges, buff, buffLength);
	PutIntToBuff(User.WeightPenalty, buff, buffLength);
	PutIntToBuff(User.WeapPenalty, buff, buffLength);
	PutIntToBuff(User.ArmorPenalty, buff, buffLength);
	PutIntToBuff(User.DeathPenalty, buff, buffLength);
	PutIntToBuff(User.Souls, buff, buffLength);
	
end;

procedure PutQuickSelfInfoToBuff(var buff : array of byte; var buffLength : Integer);
begin
	
	// TL2Spawn
	PutIntToBuff(User.X, buff, buffLength);
	PutIntToBuff(User.Y, buff, buffLength);
	PutIntToBuff(User.Z, buff, buffLength);
	
	// TL2Live
	PutIntToBuff(User.AbnormalID, buff, buffLength);	
	PutIntToBuff(User.AtkOID, buff, buffLength);
	PutIntToBuff(User.AtkTime, buff, buffLength);	
	PutIntToBuff(User.CurHP, buff, buffLength);
	PutIntToBuff(User.CurMP, buff, buffLength);	
	PutIntToBuff(User.HP, buff, buffLength);	
	PutIntToBuff(User.MaxHP, buff, buffLength);
	PutIntToBuff(User.MaxMP, buff, buffLength);
	PutIntToBuff(User.MP, buff, buffLength);
	PutIntToBuff(User.Target.OID, buff, buffLength);
	PutIntToBuff(User.ToX, buff, buffLength);
	PutIntToBuff(User.ToY, buff, buffLength);
	PutIntToBuff(User.ToZ, buff, buffLength);
	
	PutDoubleToBuff(User.Speed, buff, buffLength);
	
	PutBoolToBuff(User.Attackable, buff, buffLength);
	PutBoolToBuff(User.Dead, buff, buffLength);
	PutBoolToBuff(User.Dropped, buff, buffLength);
	PutBoolToBuff(User.InCombat, buff, buffLength);
	PutBoolToBuff(User.Moved, buff, buffLength);
	PutBoolToBuff(User.PK, buff, buffLength);
	PutBoolToBuff(User.PvP, buff, buffLength);
	PutBoolToBuff(User.Running, buff, buffLength);
	PutBoolToBuff(User.Sitting, buff, buffLength);
	PutBoolToBuff(User.Sweepable, buff, buffLength);
	
	// TL2Char
	PutIntToBuff(User.CP, buff, buffLength);
	PutIntToBuff(User.CurCP, buff, buffLength);
	PutIntToBuff(User.MaxCP, buff, buffLength);
	PutIntToBuff(User.CubicCount, buff, buffLength);
	
	//TL2User
	PutIntToBuff(User.Charges, buff, buffLength);
	PutIntToBuff(User.WeightPenalty, buff, buffLength);
	PutIntToBuff(User.WeapPenalty, buff, buffLength);
	PutIntToBuff(User.ArmorPenalty, buff, buffLength);
	PutIntToBuff(User.DeathPenalty, buff, buffLength);
end;

procedure TCPSend1;
begin
	sendRes := TCPSocket.SendBuffer(@SendBuff, sendBuffLength);
end;

procedure SendPing;
begin
  SendBuff[0] := $01;
  
  sendBuffLength := 0;
  PutMessageLengthToBuff(SendBuff, sendBuffLength);
  
  Script.MainProc(TCPSend1); 
  LogDebug('SendPing', 'Sent ping packet');  
end;

procedure SendStatus;
begin
	SendBuff[0] := $05;
	
	sendBuffLength := 0;
	PutByteToBuff(Ord(Engine.Status), SendBuff, sendBuffLength);
	
	PutMessageLengthToBuff(SendBuff, sendBuffLength);
	
	Script.MainProc(TCPSend1); 
	LogDebug('SendStatus', 'Sent status packet');  
end;

procedure SendSelfInfo;
begin

	SendBuff[0] := $03;
	sendBuffLength := 0;

	PutFullSelfInfoToBuff(SendBuff, sendBuffLength);

	PutMessageLengthToBuff(SendBuff, sendBuffLength);

	Script.MainProc(TCPSend1);     
	LogDebug('SendSelfInfo', 'Sent self info packet');  
end;

procedure SendQuickSelfInfo;
begin
	SendBuff[0] := $04;
	sendBuffLength := 0;
	
	PutQuickSelfInfoToBuff(SendBuff, sendBuffLength);
	
	PutMessageLengthToBuff(SendBuff, sendBuffLength);
	
	Script.MainProc(TCPSend1); 
	LogDebug('SendQuickSelfInfo', 'Sent short self info packet');
end;

procedure SendFullNPCInfo;
var i:integer;
begin
	SendBuff[0] := $06;
	sendBuffLength := 0;	
	
	PutIntToBuff(NpcList.Count, SendBuff, sendBuffLength);	
	for i:=0 to NpcList.Count - 1 do begin	
		PutNPCFullInfoToBuff(NpcList.Items(i), SendBuff, sendBuffLength);
	end;
	
	PutMessageLengthToBuff(SendBuff, sendBuffLength);
	
	Script.MainProc(TCPSend1); 
	LogDebug('SendFullNPCInfo', 'Sent full NPC info packet. Size: ' + sendBuffLength.tostring());
end;

procedure SendFullNPCInfoByOIDs(OIDs : array of Integer);
var isFound : Boolean;
	npcCount : Integer;
begin
	SendBuff[0] := $06;
	sendBuffLength := 0;	
	
	PutIntToBuff(High(OIDs), SendBuff, sendBuffLength);
	npcCount := 0;
	for i:=0 to NpcList.Count - 1 do begin		
		isFound := false;
		for j:=0 to High(OIDs) do
			if NpcList.Items(i).OID = OIDs[j] then begin
				isFound := true;
				break;
			end;
		
		if isFound then begin
			Inc(npcCount);
			PutNPCFullInfoToBuff(NpcList.Items(i), SendBuff, sendBuffLength);
		end;
	end;
	
	//replace npc count with actual value
	Move(npcCount, SendBuff[3], 4);
	
	PutMessageLengthToBuff(SendBuff, sendBuffLength);
	
	Script.MainProc(TCPSend1); 
	LogDebug('SendFullNPCInfoByOIDs', 'Sent full NPC info packet. Size: ' + sendBuffLength.tostring());
end;

procedure SendFullPlayerInfo;
	var i:integer;
begin
	SendBuff[0] := $08;
	sendBuffLength := 0;	
	
	PutIntToBuff(CharList.Count, SendBuff, sendBuffLength);	
	for i:=0 to CharList.Count - 1 do begin	
		PutPlayerFullInfoToBuff(CharList.Items(i), SendBuff, sendBuffLength);
	end;
	
	PutMessageLengthToBuff(SendBuff, sendBuffLength);
	
	Script.MainProc(TCPSend1); 
	LogDebug('SendFullPlayerInfo', 'Sent full player info packet. Size: ' + sendBuffLength.tostring());

end;

procedure SendFullPlayerInfoByOIDs(OIDs : array of Integer);
var isFound : Boolean;
	playerCount : Integer;
begin
	SendBuff[0] := $08;
	sendBuffLength := 0;	
	
	PutIntToBuff(High(OIDs), SendBuff, sendBuffLength);
	playerCount := 0;
	for i:=0 to CharList.Count - 1 do begin		
		isFound := false;
		for j:=0 to High(OIDs) do
			if CharList.Items(i).OID = OIDs[j] then begin
				isFound := true;
				break;
			end;
		
		if isFound then begin
			Inc(playerCount);
			PutPlayerFullInfoToBuff(CharList.Items(i), SendBuff, sendBuffLength);
			
		end;
	end;
	
	//replace player count with actual value
	Move(playerCount, SendBuff[3], 4);
	
	PutMessageLengthToBuff(SendBuff, sendBuffLength);
	
	Script.MainProc(TCPSend1); 
	LogDebug('SendFullPlayerInfoByOIDs', 'Sent full player info packet. Size: ' + sendBuffLength.tostring());
end;

procedure ProcessQuickSelfInfoSend;
begin
	if not IsQuickSelfInfoSendingEnabled then exit;	
	if not IsInGame then exit;
	if GetTickCount() - lastQuickSelfnfoMessageTime < QUICK_SELF_INFO_MESSAGE_INTERVAL_MS then exit;
	
	SendQuickSelfInfo();
	lastQuickSelfnfoMessageTime := GetTickCount();
end;

procedure ProcessPingSend; 
begin
	if GetTickCount() - lastPingTime > PING_INTERVAL_MS then begin
      SendPing();
      lastPingTime := GetTickCount();
    end;
end;

procedure ProcessQuickNPCInfoSend;
var isLFTimeout, isHF: Boolean;
	npc : TL2Npc;
	npcCount : Integer;
begin
	npcCount := 0;
	if not IsQuickNPCInfoSendingEnabled then exit;	
	if not IsInGame then exit;
	if GetTickCount() - lastQuickNPCInfoHFMessageTime > QUICK_NPC_INFO_TX_HF_INTERAVAL_MS then begin
		isLFTimeout := GetTickCount() - lastQuickNPCInfoLFMessageTime > QUICK_NPC_INFO_TX_LF_INTERAVAL_MS;
		
		SendBuff[0] := $07;
		sendBuffLength := 0;
	
		PutIntToBuff(0, SendBuff, sendBuffLength);
		for i:=0 to NpcList.Count - 1 do begin
			npc := NpcList.Items(i);
			if isLFTimeout or 
					npc.InCombat or
					(npc.HP < npc.MaxHP) or
					(npc.AbnormalID <> 0)
			then begin
				PutNPCQuickInfoToBuff(npc, SendBuff, sendBuffLength);
				Inc(npcCount);
			end;
		end;
		
		lastQuickNPCInfoHFMessageTime := GetTickCount();
		if isLFTimeout then
			lastQuickNPCInfoLFMessageTime := GetTickCount();
			
		if npcCount > 0 then
		begin			
			//replace npc count with actual value
			Move(npcCount, SendBuff[3], 4);
		
			PutMessageLengthToBuff(SendBuff, sendBuffLength);
			Script.MainProc(TCPSend1);
			LogDebug('ProcessQuickNPCInfoSend', 'Sent info about ' + npcCount.tostring() + ' NPCs');
		end;
    end;
end;

procedure ProcessQuickPlayerInfoSend;
var isLFTimeout, isHF: Boolean;
	pl : TL2Char;
	playerCount : Integer;
begin
	playerCount := 0;
	if not IsQuickNPCInfoSendingEnabled then exit;	
	if not IsInGame then exit;
	if GetTickCount() - lastQuickPlayerInfoHFMessageTime > QUICK_PLAYER_INFO_TX_HF_INTERAVAL_MS then begin
		isLFTimeout := GetTickCount() - lastQuickPlayerInfoLFMessageTime > QUICK_PLAYER_INFO_TX_LF_INTERAVAL_MS;
		
		SendBuff[0] := $09;
		sendBuffLength := 0;
	
		PutIntToBuff(0, SendBuff, sendBuffLength);
		for i:=0 to CharList.Count - 1 do begin
			pl := CharList.Items(i);
			if isLFTimeout or 
					pl.InCombat or
					(pl.HP < pl.MaxHP) or
					(pl.CP < pl.MaxCP) or
					(pl.PvP) or
					(pl.PK) or
					(pl.AbnormalID <> 0)
			then begin
				PutPlayerQuickInfoToBuff(pl, SendBuff, sendBuffLength);
				Inc(playerCount);
			end;
		end;
		
		lastQuickPlayerInfoHFMessageTime := GetTickCount();
		if isLFTimeout then
			lastQuickPlayerInfoLFMessageTime := GetTickCount();
			
		if playerCount > 0 then
		begin			
			//replace pl count with actual value
			Move(playerCount, SendBuff[3], 4);
		
			PutMessageLengthToBuff(SendBuff, sendBuffLength);
			Script.MainProc(TCPSend1);
			LogDebug('ProcessQuickPlayerInfoSend', 'Sent info about ' + playerCount.tostring() + ' Players');
		end;
    end;
end;

procedure ProcessDataSend;
begin
	sendRes := -1;
	ProcessPingSend();
	ProcessQuickSelfInfoSend();	
	ProcessQuickNPCInfoSend();
	ProcessQuickPlayerInfoSend();
	{
	
	
    if GetTickCount() - lastDataMessageTime > STATIC_DATA_MESSAGE_INTERVAL_MS then begin
      SendSelfInfo();
      lastDataMessageTime := GetTickCount();
    end;
	}
	
end;