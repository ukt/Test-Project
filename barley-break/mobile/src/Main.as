package {
	import app.App;
	import app.game.SpeedDemonstration;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;

	import loka.asUtils.FPSGraphic;

	public class Main extends Sprite{
		public function Main() {
			new App(this);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
//			stage.scaleMode = StageScaleMode.EXACT_FIT;
			stage.frameRate = 60;
			if(Capabilities.isDebugger) {
				var fpsGraphic:FPSGraphic = new FPSGraphic();
				fpsGraphic.scaleX = fpsGraphic.scaleY = App.appScale;
				addChild(fpsGraphic);
			}

			stage.addEventListener(MouseEvent.CLICK, add)
		}


		private function add(event:MouseEvent):void {
			var speedDemostration:SpeedDemonstration = new SpeedDemonstration();
			addChild(speedDemostration);
			speedDemostration.x = event.stageX;
			speedDemostration.y = event.stageY;
		}
	}
}
