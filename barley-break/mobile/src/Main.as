package {
	import app.App;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	import utils.loka.asUtils.FPSGraphic;

	public class Main extends Sprite{
		public function Main() {
			new App(this);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
//			stage.scaleMode = StageScaleMode.EXACT_FIT;
			stage.frameRate = 60;
			addChild(new FPSGraphic());
		}
	}
}
