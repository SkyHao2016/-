/**
 * 插件：载具召唤
 * 版权：SkyHao
 * 版本：1.0
 */
 
private["_payload", "_sessionId", "_player", "_result", "_hasBet","_vehicle","_spawnPos","_position","_spawnDir","_gethasBet","_used"];
_payload = _this;
_vehicle= _payload select 1;
_result = true;
//_vehicle="Mrshounka_a3_smart_civ_noir";
_used=0;
try 
{
    _player = _payload select 0; // player

	_gethasBet = format ["GetVipVehicleC:%1", getPlayerUID _player] call ExileServer_system_database_query_selectSingle;
	if !(isNil "_gethasBet") then {
		_used = _gethasBet select 0;
	};
	if (_used >0) then{
		[_player, "toastRequest", ["SuccessTitleOnly", [format["您的座驾还没有收回,请回收后再使用!"]]]] call ExileServer_system_network_send_to;
	}else{
		
		// send the updated scratchieCount
		_position = _player modelToWorld [0,3,0];
		_spawnDir = (getDir player) - 90;
		_veh = createVehicle[_vehicle, [0,0,0], [], 0, "CAN_COLLIDE"];
		clearWeaponCargoGlobal 		_veh;
		clearItemCargoGlobal 		_veh;
		clearMagazineCargoGlobal 	_veh;
		clearBackpackCargoGlobal 	_veh;
		_veh setposATL _position;
        _veh setDir _spawnDir;
		format["SeveVipVehicle:%1:%2", getPlayerUID _player, netId _veh] call ExileServer_system_database_query_insertSingle;
		[_player, "toastRequest", ["SuccessTitleOnly", [format["当前载具: %1", _vehicle]]]] call ExileServer_system_network_send_to;
		
	};
}
catch
{
    format["召唤载具返回错误: %1", _exception]  call ExileServer_util_log;
};
_result