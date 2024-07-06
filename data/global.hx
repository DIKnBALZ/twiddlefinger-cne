import openfl.system.Capabilities;
import hxvlc.util.Handle;
import funkin.menus.BetaWarningState;

function new() {
	FlxG.width = FlxG.initialWidth = 960;
	window.resize(FlxG.width, FlxG.height);
	for (camera in FlxG.cameras.list) camera.setSize(FlxG.width, FlxG.height);

	window.x = (Capabilities.screenResolutionX / 2) - (window.width / 2);
	window.y = (Capabilities.screenResolutionY / 2) - (window.height / 2);

	Handle.initAsync([]);
}

var _redirectStates:Map<FlxState, String> = [
	BetaWarningState => 'MainMenu',
	TitleState => 'MainMenu',
	MainMenuState => 'MainMenu',
	FreeplayState => 'MainMenu'
];
function preStateSwitch() for (stupid => smart in _redirectStates) if (FlxG.game._requestedState is stupid) FlxG.game._requestedState = new ModState(smart);

var leavingMe:Bool = false;
function postStateSwitch() if (!leavingMe) window.title = "...";
function destroy() {
	leavingMe = true;
	FlxG.width = FlxG.initialWidth = 1280;
	window.resize(FlxG.width, FlxG.height);
	for (camera in FlxG.cameras.list) camera.setSize(FlxG.width, FlxG.height);

	window.x = (Capabilities.screenResolutionX / 2) - (window.width / 2);
	window.y = (Capabilities.screenResolutionY / 2) - (window.height / 2);
}