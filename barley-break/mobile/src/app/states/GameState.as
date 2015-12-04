package app.states {
	import app.App;
	import app.game.Game;
	import app.game.GameArea;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import loka.app.view.stateMachine.StateMachine;
	import loka.app.view.stateMachine.states.BaseState;
	import loka.button.Buttones;

	public class GameState extends BaseState {
		public static const NAME:String = "GameState";

		private var btnBack:MovieClip;
		private var game:Game;

		public function GameState() {
			super(new Sprite(), NAME);
		}

		override public function init():void {
			btnBack = Buttones.createRectBtn(App.deviceSize.width - 110, 5, 100, "Back");
			DOC.addChild(btnBack)
		}

		public override function activate(gameNumber:* = null):void {
			super.activate(gameNumber);
			switch (gameNumber) {
				case 1:
					game = new GameArea(App.world, DOC);
			}
			game.start();
		}

		override public function deactivate():void{
			game.dispose();
		}

		override protected function initEventListeners():void {
			super.initEventListeners();
			btnBack.addEventListener(MouseEvent.CLICK, clickBack);
		}

		private static function clickBack(event:MouseEvent):void {
			StateMachine.gotoState(MenuState.NAME);
		}
	}
}
