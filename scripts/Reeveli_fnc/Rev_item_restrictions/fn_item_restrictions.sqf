/*
 * Author: Reeveli
 * Part of SPG Liberation item/role restriction system.
 * Client side function to remove unallowed item if they are not in the Rev_items  -array of allowed items.
 *
 * Arguments:
 * NONE
 *
 * Return: NONE
 *
 * Example:
 * [player] call Rev_fnc_item_restrictions;
 *
 1.2G
	Modified from whtelist to blacklist type removal
 1.1
	Weapon attachments left neutered as they have too many variations to specify in Rev_items 
 */


if !(hasInterface) exitWith {};
if !(Rev_item_enable) exitWith {};

params ["_unit","_blacklist"];

_blacklist = _blacklist apply {toUpperANSI _x};


fnc_get_name = {params ["_item"]; getText (configFile >> "CfgWeapons" >>_item >> "displayName")};
fnc_weapon_check = {params ["_item"]; isClass (configFile >> "CfgWeapons" >>_item)};
fnc_mag_check = {params ["_item"]; isClass (configFile >> "CfgMagazines" >>_item)};
fnc_mag_name = {params ["_item"]; getText (configfile >> "CfgMagazines" >> _item >> "displayNameShort")};
fnc_vehicle_name = {params ["_item"]; getText (configfile >> "CfgVehicles" >> _item >> "displayName")};
fnc_goggles_name = {params ["_item"]; getText (configfile >> "cfgGlasses" >> _item >> "displayName")};
fnc_parent_check = {
	private _return = false; 
	params ["_item","_list"];
	private _weapons = _list select {[_x] call fnc_weapon_check};
	{if (_item isKindOf [_x,configFile >> "CfgWeapons"]) exitWith {_return = true}} forEach _weapons;
	_return;
};


//Attachements
/*
private _muzzles = primaryWeaponItems _unit;
{
	if !((toUpperANSI _x) in _blacklist) then {
		private _name = [_x] call fnc_get_name;
		if !(_name isEqualTo "") then {
			private _text = format [ "<t size='0.9' color='#FF0000' font='RobotoCondensed' shadow=2>Unallowed item removed: %1</t>", _name];
			[_text, 0, 0.1*safeZoneH+safeZoneY, 5, 0, 0, 800] spawn BIS_fnc_dynamicText;
			diag_log format ["Rev_lib_fnc_item_restrictions: %1", _x];
			_unit removePrimaryWeaponItem _x;
		};		
	};
} forEach _muzzles;
*/
//Weapon
private _weap = primaryWeapon _unit;
if ([_weap,_blacklist] call fnc_parent_check) then {
	private _name = [primaryWeapon _unit] call fnc_get_name;
	if !(_name isEqualTo "") then {
			private _text = format [ "<t size='0.9' color='#FF0000' font='RobotoCondensed' shadow=2>Unallowed item removed: %1</t>", _name];
			[_text, 0, 0.1*safeZoneH+safeZoneY, 5, 0, 0, 800] spawn BIS_fnc_dynamicText;
			diag_log format ["Rev_lib_fnc_item_restrictions: %1", _weap];
			_unit removeWeapon _weap;
		};	
};

//Attachements 2nd
/*
private _attachemnts = secondaryWeaponItems _unit;
{
	if !((toUpperANSI _x) in _blacklist) then {
		private _name = [_x] call fnc_get_name;
		if !(_name isEqualTo "") then {
			private _text = format [ "<t size='0.9' color='#FF0000' font='RobotoCondensed' shadow=2>Unallowed item removed: %1</t>", _name];
			[_text, 0, 0.1*safeZoneH+safeZoneY, 5, 0, 0, 800] spawn BIS_fnc_dynamicText;
			diag_log format ["Rev_lib_fnc_item_restrictions: %1", _x];
			_unit removesecondaryWeaponItem _x;
		};
	};
} forEach _attachemnts;
*/
//Weapon 2nd
private _weap2 = secondaryWeapon _unit;
if ([_weap2,_blacklist] call fnc_parent_check) then {
	private _name = [_weap2] call fnc_get_name;
	if !(_name isEqualTo "") then {
			private _text = format [ "<t size='0.9' color='#FF0000' font='RobotoCondensed' shadow=2>Unallowed item removed: %1</t>", _name];
			[_text, 0, 0.1*safeZoneH+safeZoneY, 5, 0, 0, 800] spawn BIS_fnc_dynamicText;
			diag_log format ["Rev_lib_fnc_item_restrictions: %1", _weap2];
			_unit removeWeapon _weap2;
		};
};

//Attachements pistol
/*
private _attach = handgunItems _unit;
{
	if !((toUpperANSI _x) in _blacklist) then {
		private _name = [_x] call fnc_get_name;
		if !(_name isEqualTo "") then {
			private _text = format [ "<t size='0.9' color='#FF0000' font='RobotoCondensed' shadow=2>Unallowed item removed: %1</t>", _name];
			[_text, 0, 0.1*safeZoneH+safeZoneY, 5, 0, 0, 800] spawn BIS_fnc_dynamicText;
			diag_log format ["Rev_lib_fnc_item_restrictions: %1", _x];
			_unit removeHandgunItem _x;
		};
	};
} forEach _attach;
*/
//Pistol
private _weap3 = handgunWeapon _unit;
if ([_weap3,_blacklist] call fnc_parent_check) then {
	private _name = [_weap3] call fnc_get_name;
	if !(_name isEqualTo "") then {
			private _text = format [ "<t size='0.9' color='#FF0000' font='RobotoCondensed' shadow=2>Unallowed item removed: %1</t>", _name];
			[_text, 0, 0.1*safeZoneH+safeZoneY, 5, 0, 0, 800] spawn BIS_fnc_dynamicText;
			diag_log format ["Rev_lib_fnc_item_restrictions: %1", _weap3];
			_unit removeWeapon _weap3;
		};	
};

//helmet
private _item1 = headgear _unit;
if ((toUpperANSI _item1) in _blacklist) then {
	private _name = [_item1] call fnc_get_name;
	if !(_name isEqualTo "") then {
			private _text = format [ "<t size='0.9' color='#FF0000' font='RobotoCondensed' shadow=2>Unallowed item removed: %1</t>", _name];
			[_text, 0, 0.1*safeZoneH+safeZoneY, 5, 0, 0, 800] spawn BIS_fnc_dynamicText;
			diag_log format ["Rev_lib_fnc_item_restrictions: %1", _item1];
			removeHeadgear _unit;
		};	
};

//Uniform items
private _items2 = uniformItems _unit;
{
	if ((toUpperANSI _x) in _blacklist) then {
		
		if ([_x] call fnc_mag_check) then {
			private _name = [_x] call fnc_mag_name;
			if !(_name isEqualTo "") then {
				private _text = format [ "<t size='0.9' color='#FF0000' font='RobotoCondensed' shadow=2>Unallowed item removed: %1</t>", _name];
				[_text, 0, 0.1*safeZoneH+safeZoneY, 5, 0, 0, 800] spawn BIS_fnc_dynamicText;
				diag_log format ["Rev_lib_fnc_item_restrictions: %1", _x];
				_unit removeItemFromUniform _x;
			};
			
		};

		if ([_x] call fnc_weapon_check) then {
			private _name = [_x] call fnc_get_name;
			if !(_name isEqualTo "") then {
				private _text = format [ "<t size='0.9' color='#FF0000' font='RobotoCondensed' shadow=2>Unallowed item removed: %1</t>", _name];
				[_text, 0, 0.1*safeZoneH+safeZoneY, 5, 0, 0, 800] spawn BIS_fnc_dynamicText;
				diag_log format ["Rev_lib_fnc_item_restrictions: %1", _x];
				_unit removeItemFromUniform _x;
			};			
		};

	};
} forEach _items2;

//clothing
private _item3 = uniform _unit;
if ((toUpperANSI _item3) in _blacklist) then {
	private _name = [_item3] call fnc_get_name;
	if !(_name isEqualTo "") then {
			private _text = format [ "<t size='0.9' color='#FF0000' font='RobotoCondensed' shadow=2>Unallowed item removed: %1</t>", _name];
			[_text, 0, 0.1*safeZoneH+safeZoneY, 5, 0, 0, 800] spawn BIS_fnc_dynamicText;
			diag_log format ["Rev_lib_fnc_item_restrictions: %1", _item3];
			removeUniform _unit;
		};	
};

//vest items
private _items4 = vestItems _unit;
{
	if ((toUpperANSI _x) in _blacklist) then {
		
		if ([_x] call fnc_mag_check) then {
			private _name = [_x] call fnc_mag_name;
			if !(_name isEqualTo "") then {
				private _text = format [ "<t size='0.9' color='#FF0000' font='RobotoCondensed' shadow=2>Unallowed item removed: %1</t>", _name];
				[_text, 0, 0.1*safeZoneH+safeZoneY, 5, 0, 0, 800] spawn BIS_fnc_dynamicText;
				diag_log format ["Rev_lib_fnc_item_restrictions: %1", _x];
				_unit removeItemFromVest _x;
			};			
		};

		if ([_x] call fnc_weapon_check) then {
			private _name = [_x] call fnc_get_name;
			if !(_name isEqualTo "") then {
				private _text = format [ "<t size='0.9' color='#FF0000' font='RobotoCondensed' shadow=2>Unallowed item removed: %1</t>", _name];
				[_text, 0, 0.1*safeZoneH+safeZoneY, 5, 0, 0, 800] spawn BIS_fnc_dynamicText;
				diag_log format ["Rev_lib_fnc_item_restrictions: %1", _x];
				_unit removeItemFromVest _x;
			};			
		};

	};
} forEach _items4;

//vest
private _item5 = vest _unit;
if ((toUpperANSI _item5) in _blacklist) then {
	private _name = [_item5] call fnc_get_name;
	if !(_name isEqualTo "") then {
			private _text = format [ "<t size='0.9' color='#FF0000' font='RobotoCondensed' shadow=2>Unallowed item removed: %1</t>", _name];
			[_text, 0, 0.1*safeZoneH+safeZoneY, 5, 0, 0, 800] spawn BIS_fnc_dynamicText;
			diag_log format ["Rev_lib_fnc_item_restrictions: %1", _item5];
			removeVest _unit;
		};	
};

//backpack items
private _items6 = backpackItems _unit;
{
	if ((toUpperANSI _x) in _blacklist) then {
		
		if ([_x] call fnc_mag_check) then {
			private _name = [_x] call fnc_mag_name;
			if !(_name isEqualTo "") then {					
				private _text = format [ "<t size='0.9' color='#FF0000' font='RobotoCondensed' shadow=2>Unallowed item removed: %1</t>", _name];
				[_text, 0, 0.1*safeZoneH+safeZoneY, 5, 0, 0, 800] spawn BIS_fnc_dynamicText;
				diag_log format ["Rev_lib_fnc_item_restrictions: %1", _x];
				_unit removeItemFrombackpack _x;
			};
		};

		if ([_x] call fnc_weapon_check) then {
			private _name = [_x] call fnc_get_name;
			if !(_name isEqualTo "") then {			
				private _text = format [ "<t size='0.9' color='#FF0000' font='RobotoCondensed' shadow=2>Unallowed item removed: %1</t>", _name];
				[_text, 0, 0.1*safeZoneH+safeZoneY, 5, 0, 0, 800] spawn BIS_fnc_dynamicText;
				diag_log format ["Rev_lib_fnc_item_restrictions: %1", _x];
				_unit removeItemFromBackpack _x;
			};
		};

	};
} forEach _items6;

//backpack
private _item7 = backpack _unit;
if ((toUpperANSI _item7) in _blacklist) then {
	private _name = [_item7] call fnc_vehicle_name;
	if !(_name isEqualTo "") then {
		private _text = format [ "<t size='0.9' color='#FF0000' font='RobotoCondensed' shadow=2>Unallowed item removed: %1</t>", _name];
		[_text, 0, 0.1*safeZoneH+safeZoneY, 5, 0, 0, 800] spawn BIS_fnc_dynamicText;
		diag_log format ["Rev_lib_fnc_item_restrictions: %1", _item7];
		removeBackpack _unit;
	};
};

//facewear
private _item8 = goggles _unit;
if ((toUpperANSI _item8) in _blacklist) then {
	private _name = [_item8] call fnc_goggles_name;
	if !(_name isEqualTo "") then {
			private _text = format [ "<t size='0.9' color='#FF0000' font='RobotoCondensed' shadow=2>Unallowed item removed: %1</t>", _name];
			[_text, 0, 0.1*safeZoneH+safeZoneY, 5, 0, 0, 800] spawn BIS_fnc_dynamicText;
			diag_log format ["Rev_lib_fnc_item_restrictions: %1", _item8];
		};	
			removeGoggles _unit;
};

//Assigned Items
private _items9 = assignedItems _unit;
{
	if ((toUpperANSI _x) in _blacklist) then {
		if ([_x] call fnc_weapon_check) then {
			private _name = [_x] call fnc_get_name;
			private _text = format [ "<t size='0.9' color='#FF0000' font='RobotoCondensed' shadow=2>Unallowed item removed: %1</t>", _name];
			[_text, 0, 0.1*safeZoneH+safeZoneY, 5, 0, 0, 800] spawn BIS_fnc_dynamicText;
			_unit unlinkItem _x;
			diag_log format ["Rev_lib_fnc_item_restrictions: %1", _x];
			_unit removeWeapon _x;
		};
	};
} forEach _items9;