// THX Larrow from BIS forum <3 
if !(hasInterface) exitWith {};


while { true } do
{
	waitUntil { !isNull (findDisplay 49) };

	_CEH = ((findDisplay 49) displayCtrl 1010) ctrlAddEventHandler ["MouseButtonDown",
	{ 
		(findDisplay 49) closeDisplay 0;

		_handle = createdialog (call DK_menu_RespawnButton);
	}]; 
	
	waitUntil {isNull (findDisplay 49)};
};