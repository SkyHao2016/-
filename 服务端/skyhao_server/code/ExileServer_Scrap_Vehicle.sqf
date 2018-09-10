/**
 * 插件：载具召唤
 * 版权：SkyHao
 * 版本：1.0
 */
private["_payload","_player","_Vehicle","_NetId","_gethasBet","_used","_hasBet"];
_payload = _this;
_player = _payload select 0; // player
_vehicle= _payload select 1;
	

	_gethasBet = format ["GetVipVehicleC:%1", getPlayerUID _player] call ExileServer_system_database_query_selectSingle;
	if !(isNil "_gethasBet") then {
	
		_NetId = format ["%1:%2]", _gethasBet select 1, _gethasBet select 2]; 
		
		deletevehicle objectFromNetId _NetId;
		[_player, "toastRequest", ["SuccessTitleOnly", [format["载具已入库"]]]] call ExileServer_system_network_send_to;
		format['DeleteVipVehicle:%1', getPlayerUID _player] call ExileServer_system_database_query_fireAndForget;
		
		
	}else
	{
		[_player, "toastRequest", ["SuccessTitleOnly", [format["您的座驾还在您的车库里,不需要回收!"]]]] call ExileServer_system_network_send_to;
	}; 

