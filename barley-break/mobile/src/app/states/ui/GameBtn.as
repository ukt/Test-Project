package app.states.ui {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	import loka.button.Buttones;

	public class GameBtn extends MovieClip {
		public var gameNumber:uint;
		public function GameBtn(gameNumber:uint, text:String) {
			super();
			this.gameNumber = gameNumber;
			addChild(Buttones.createRectBtn(10, 30, 100, text));
			addEventListener(MouseEvent.CLICK, openGame);
		}

		private function openGame(event:MouseEvent):void {
			/*switch (gameNumber){
				case 1:
					new GameArea(App.world);
			}*/
		}
	}
}
