const
	PING_INTERVAL_MS = 5000;
	STATIC_DATA_MESSAGE_INTERVAL_MS = 60000;
	QUICK_SELF_INFO_MESSAGE_INTERVAL_MS = 2000;
	QUICK_NPC_INFO_TX_HF_INTERAVAL_MS = 500;
	QUICK_NPC_INFO_TX_LF_INTERAVAL_MS = 5000;
	QUICK_PLAYER_INFO_TX_HF_INTERAVAL_MS = 500;
	QUICK_PLAYER_INFO_TX_LF_INTERAVAL_MS = 5000;

	{$I PacketIDs.pas}
	
var 
	i, j: integer;
	
	//TCP Socket variables
	TCPSocket: TTCPBlockSocket;
	IP, Port: string;
	RecvBuff:array[0..2000] of byte;
	recvBuffPos : Integer;
	SendBuff:array[0..100000] of byte;
	sendBuffLength: integer;	
	sendRes, recvRes: Integer;
	waitingDataAmount: Integer;
	
	//Buffer2
	SendBuff2:array[0..50000] of byte;
	sendBuffLength2: integer;	
	sendRes2:integer;
	
	//Threads
	IsBGThreadsEnabled : Boolean;
	
	// State variables  
	IsInGame : Boolean;
	IsQuickSelfInfoSendingEnabled : Boolean;
	IsQuickNPCInfoSendingEnabled : Boolean;
	IsQuickPlayerInfoSendingEnabled : Boolean;

	// Time variables
	lastPingTime : Longint;
	lastDataMessageTime : Longint;
	lastQuickSelfnfoMessageTime : Longint;
	lastQuickNPCInfoHFMessageTime : Longint;
	lastQuickNPCInfoLFMessageTime : Longint;
	lastQuickPlayerInfoHFMessageTime : Longint;
	lastQuickPlayerInfoLFMessageTime : Longint;
	
	//Configuration
	IsDebugLogEnabled: Boolean = true;
	
	//Other
	Login : string;
	Password : string;
	