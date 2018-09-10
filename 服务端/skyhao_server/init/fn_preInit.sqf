/**
 * 插件：载具召唤
 * 版权：SkyHao
 * 版本：1.0
 */
private ['_code', '_function', '_file'];

{
    _code = '';
    _function = _x select 0;
    _file = _x select 1;
	
    _code = compileFinal (preprocessFileLineNumbers _file);

    missionNamespace setVariable [_function, _code];
}
forEach 
[

	['ExileServer_Deploy_Vehicle', 'skyhao_server\code\ExileServer_Deploy_Vehicle.sqf'],
	['ExileServer_Get_Vehicle_List', 'skyhao_server\code\ExileServer_Get_Vehicle_List.sqf'],
	['ExileServer_Scrap_Vehicle', 'skyhao_server\code\ExileServer_Scrap_Vehicle.sqf']
			
];

diag_log "[载具召唤] 成功加载插件...";

true