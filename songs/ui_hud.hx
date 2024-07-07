function postCreate() {
	defaultHudZoom = camHUD.zoom = 0.8;

	var ref:FunkinSprite = new FunkinSprite();
	ref.loadSprite(Paths.image('ref'));
	ref.scrollFactor.set(); ref.zoomFactor = 0;
	ref.alpha = 0.5;
	add(ref);
}

function onStrumCreation(event) {
	event.strum.x = (event.player == 0 ? -60 : 570) + ((Note.swagWidth) * event.strumID);
	event.strum.y -= 100;
}