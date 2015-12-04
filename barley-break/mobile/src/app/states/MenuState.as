package app.states {
	import app.states.ui.GameBtn;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import loka.app.view.stateMachine.StateMachine;
	import loka.app.view.stateMachine.states.BaseState;

	public class MenuState extends BaseState {
		public static const NAME:String = "MenuState";

		public function MenuState() {
			super(new Sprite(), NAME);
		}

		override public function init():void {
			var gameBtn:MovieClip = new GameBtn(1, "First Game");
			gameBtn.addEventListener(MouseEvent.CLICK, openGame);
			DOC.addChild(gameBtn)
		}

		private static function openGame(event:MouseEvent):void {
			StateMachine.gotoState(GameState.NAME, GameBtn(event.currentTarget).gameNumber);
			/*switch (GameBtn(event.currentTarget).gameNumber){
				case 1:
					new GameArea(App.world);
			}*/
		}
	}
}
