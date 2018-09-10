private["_payload", "_clientId", "_player", "_result","_gethasBet"];
_payload = _this;
_player = _payload select 0; // player

	_gethasBet = format ["GetVipVehicle:%1", getPlayerUID _player] call ExileServer_system_database_query_selectSingle;
[_player, "toastRequest", ["SuccessTitleOnly", [format["当前载具: %1", _gethasBet]]]] call ExileServer_system_network_send_to;
	
	
	if !(isNil "_gethasBet") then {
	
		VipVehicleList = _gethasBet select 0;
		_clientId = owner _player;
		_clientId publicVariableClient "VipVehicleList";
	}else
	{
		VipVehicleList = ["C_Kart_01_Vrana_F"];
		_clientId = owner _player;
		_clientId publicVariableClient "VipVehicleList";
		
	};

_result