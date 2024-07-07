// HELP = 👍

import funkin.editors.EditorPicker;
import funkin.options.OptionsMenu;
import funkin.menus.ModSwitchMenu;

var optionList:Array<String> = ['start', 'options', 'mods'];
var buttonList:Array<FunkinSprite> = [];
var buttons:FunkinSprite;

var curSelected:Int = 0;
var playMode:String = 'normal';

function create() {
	CoolUtil.playMenuSong();

	FlxG.mouse.visible = FlxG.mouse.enabled = true;

	// var ref:FunkinSprite = new FunkinSprite();
	// ref.loadSprite(Paths.image('twiddle-menu/ref'));
	// ref.scrollFactor.set(); ref.zoomFactor = 0;
	// ref.alpha = 0.5;
	// add(ref);

	var maxdickpro1:FunkinText = new FunkinText(0, 21, 0, 'MAX DESIGN PRO', 48);
	maxdickpro1.font = Paths.font('Knicknack Regular.otf');
	maxdickpro1.screenCenter(0x01);
	add(maxdickpro1);

	var line:FunkinSprite = new FunkinSprite(0, 72).makeGraphic(FlxG.width, 5);
	add(line);

	line.color = maxdickpro1.color = 0xFF242320;

	var maxdickpro2:FunkinText = new FunkinText(0, 135, 0, 'MAX DESIGN PRO', 48);
	maxdickpro2.font = Paths.font('Knicknack Regular.otf');
	maxdickpro2.screenCenter(0x01);
	add(maxdickpro2);

	for (index => name in optionList) {
		var button:FunkinSprite = new FunkinSprite(0, 367);
		button.loadSprite(Paths.image('twiddle-menu/buttons'));
		button.screenCenter(0x01);
		button.x = switch name {
			default: button.x;
			case 'start': 274;
			case 'options': 490;
			case 'mods': button.x - 17;
		};
		if (name == 'mods') button.y += button.height + 25;
		button.animation.addByPrefix(name + '_idle', name + '_i', 24, true);
		button.animation.addByPrefix(name + '_select', name + '_s', 24, true);
		button.playAnim(name + (curSelected == index ? '_idle' : '_select'));
		add(button);
		buttonList.insert(index, button);
	}
}

function select(button:FunkinSprite) {
	curSelected = buttonList.indexOf(button);
	for (_index => _butt in buttonList) {
		_butt.playAnim(optionList[_index] + (curSelected == _index ? '_idle' : '_select'));
	}
}

function update(elapsed:Float) {
	for (button in buttonList)
		if (FlxG.mouse.overlaps(button)) {
			select(button);
			if (FlxG.mouse.justPressed) accept();
		}

	if (controls.LEFT_P || controls.RIGHT_P)
		select(buttonList[FlxMath.wrap(curSelected+(controls.LEFT_P ? -1 : 1), 0, optionList.length-1)]);

	if (controls.ACCEPT) accept(); 

	if (FlxG.keys.justPressed.SEVEN) {
		persistentUpdate = false;
		openSubState(new EditorPicker());
	}
}

function accept() {
	switch optionList[curSelected] {
		case 'start': play();
		case 'options': FlxG.switchState(new OptionsMenu());
		case 'mods':
			persistentUpdate = false;
			openSubState(new ModSwitchMenu());
	}
}

function play() {
	PlayState.loadSong("twiddlefinger", "twiddlefinger", playMode == 'opponent', playMode == 'coop');
	FlxG.switchState(new PlayState());
}