
TUT_fnc_OpenVehUI = 
{	
	disableSerialization;
	createDialog "RscTUTVehDialog";
	[] call TUT_gui_LoadVeh;
	_serverTitleCbo = ((findDisplay 1601) displayCtrl (10));
	_plr = profileName;
	_price=0;
	_title = "目前所有载具";
	_serverTitleCbo ctrlSetStructuredText parseText format ["<t align='left'>%1,召唤费用:%2</t><t align='right'>%3</t>",_plr,_price,_title];

};
TUT_gui_LoadVeh = 
{
	_kind = ["car","air","tank"];
	_cbo = ((findDisplay 1601) displayCtrl (7));
	lbCLear _cbo;
	
	[player] remoteExecCall ['ExileServer_Get_Vehicle_List', 2];
	_vhc = VipVehicleList;
	[player, "toastRequest", ["SuccessTitleOnly", [format["载具%1",_vhc]]]] call ExileServer_system_network_send_to;
	_count1= count (_vhc);
	
	
	for "_x" from 0 to (_count1-1) do
	{
		_veh = (_vhc select _x);
		
		

		if (_veh isKindOf (_kind select 0) or _veh isKindOf (_kind select 1) or _veh isKindOf (_kind select 2)) then
		{
			_index = _cbo lbAdd(getText(configFile >> "cfgVehicles" >> _veh>> "displayName"));
			_cbo lbSetData[(lbSize _cbo)-1,  _veh];
			_picture = (getText(configFile >> "cfgVehicles" >> _veh >> "picture"));
			_cbo lbSetPicture[(lbSize _cbo)-1,_picture];
		};
		
		
	};
};
TUT_gui_VehInfo = 
{
	private ["_weapArray","_class","_crewCount","_model","_maxSpeed","_invSpace","_armor"];
	disableSerialization;
	_id =  lbCurSel 7;
	_class = lbData [7, _id];
	_weapons = [];
	_weaponsClass = getArray(configFile >> "cfgVehicles" >> _class >> "weapons");
	{
	_name = getText (configFile >> "cfgWeapons" >> _x >> "displayName");
	_weapons = _weapons + [ _name];
	}forEach _weaponsClass; 
	if (isClass (configFile >> "cfgVehicles" >> _class >> "Turrets" >> "M2_Turret")) then 
		{
			_weapArray = getArray(configFile >> "cfgVehicles" >> _class >> "Turrets" >> "M2_Turret" >> "weapons");
			
		} else
		{
			_weapArray = getArray(configFile >> "cfgVehicles" >> _class >> "Turrets" >> "MainTurret" >> "weapons");
			_weapArray = _weapArray + (getArray(configFile >> "cfgVehicles" >> _class >> "Turrets" >> "FrontTurret" >> "weapons"));
			_weapArray = _weapArray + (getArray(configFile >> "cfgVehicles" >> _class >> "Turrets" >> "RearTurret" >> "weapons"));
			
		};
		{
			_name = getText (configFile >> "cfgWeapons" >> _x >> "displayName");
			_weapons = _weapons + [ _name];
		}forEach _weapArray;
	_crewCount = [_class,true] call BIS_fnc_crewCount;
	_model = getText(configFile >> "cfgVehicles" >> _class >> "model");
	_maxSpeed = getNumber(configFile >> "cfgVehicles" >> _class >> "maxSpeed");
	_invSpace = getNumber(configFile >> "cfgVehicles" >> _class >> "maximumLoad");
	_armor = getNumber(configFile >> "cfgVehicles" >> _class >> "armor");
	_textCbo = ((findDisplay 1601) displayCtrl (8));
	
	_textCbo ctrlSetStructuredText parseText format 
	["<t align='left'>武器:</t><br/>
	<t align='left'>%1</t>
	<t align='left'>%6</t><br/>
	<t align='left'>可容乘客:</t> <t align='right'>%2</t>
	<t align='left'>%6</t><br/>
	<t align='left'>最大时速:</t> <t align='right'>%3</t>
	<t align='left'>%6</t><br/>
	<t align='left'>容量:</t> <t align='right'>%4</t>
	<t align='left'>%6</t><br/>
	<t align='left'>护甲:</t> <t align='right'>%5</t>
	<t align='left'>%6</t><br/>",_weapons,_crewCount,_maxSpeed,_invSpace,_armor];	
};
TUT_gui_VehCreate = 
{
	_price=0;
	_idVeh =  lbCurSel 7;
	_classVeh = lbData [7, _idVeh];
	_emptyPos = position player findEmptyPosition [5,50,_classVeh];
	if (count _emptyPos == 0) then { hint "请选择要召唤的载具"; }
	else
	{	
		player playMove "AinvPknlMstpSnonWnonDr_medic3";
		[player,_classVeh] remoteExecCall ['ExileServer_Deploy_Vehicle', 2];
		closeDialog 1601;
	};
		

};

TUT_gui_VehDelete = 
{

	[player] remoteExecCall ['ExileServer_Scrap_Vehicle', 2];
		
};

