package {
	import app.App;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	import loka.asUtils.FPSGraphic;

	public class Main extends Sprite{
		public function Main() {
			new App(this);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
//			stage.scaleMode = StageScaleMode.EXACT_FIT;
			stage.frameRate = 60;
			var fpsGraphic:FPSGraphic = new FPSGraphic();
			addChild(fpsGraphic);
			fpsGraphic.scaleX = fpsGraphic.scaleY = App.appScale;
		}
	}
}
