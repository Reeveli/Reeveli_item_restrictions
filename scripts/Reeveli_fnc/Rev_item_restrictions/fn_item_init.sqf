/*
 * Author: Reeveli
 * Client side function for restricting items to certain unit classes.
 * Called as a post init
 *
 * Arguments:
 * NONE
 *
 * Return: BOOLEAN
 *
 * Example:
 * call Rev_fnc_item_init
 *
 */

if !(hasInterface) exitWith {false};


//Resticted engineer items
private _willy = ["vn_m34_grenade_mag"];
//Resticted RTO items
private _phones = ["vn_b_pack_lw_06","vn_b_pack_prc77_01","vn_b_pack_trp_04_02","vn_b_pack_03_02","vn_b_pack_03","vn_b_pack_trp_04","vn_b_pack_m41_05"];
//Resticted Bazooka items
private _tubes = ["vn_m20a1b1_01"];

//All of the above, very important
Rev_items = _willy + _phones + _tubes;


private _unitType = typeOf vehicle player;
private _whitelist = [];

//These are the unit classes that determine restrictions
switch (_unitType) do
{
	//Engineer
	case ("vn_b_men_sog_07") : {{_whitelist pushBackUnique _x} forEach _willy};
	case ("B_engineer_F") : {{_whitelist pushBackUnique _x} forEach _willy};

	//RTO
	case ("vn_b_men_sog_05") : {{_whitelist pushBackUnique _x} forEach _phones};
	case ("vn_b_men_usmc_recon_68_08") : {{_whitelist pushBackUnique _x} forEach _phones};

	//AT
	case ("vn_b_men_usmc_recon_68_08") : {{_whitelist pushBackUnique _x} forEach _tubes};
	case ("B_soldier_AT_F") : {{_whitelist pushBackUnique _x} forEach _tubes};

	//SL, has access to both Engineer and RTO items (but not AT)
	case ("vn_b_men_sog_04") : {{_whitelist pushBackUnique _x} forEach _willy;{_whitelist pushBackUnique _x} forEach _phones};
	case ("B_Soldier_SL_F") : {{_whitelist pushBackUnique _x} forEach _willy;{_whitelist pushBackUnique _x} forEach _phones};
};

//Creating blacklist
{
	private _index = Rev_items find _x;
	if (_index != -1) then
	{
		Rev_items deleteAt _index;
	};
} forEach _whitelist;


//Adding EH
['loadout', {[player,Rev_items] call Rev_fnc_item_restrictions}] call CBA_fnc_addPlayerEventHandler;


true;