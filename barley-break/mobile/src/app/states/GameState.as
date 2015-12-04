package app.states {
	import app.App;
	import app.game.games.FirstGame;
	import app.game.games.Game;
	import app.game.games.SecondGame;
	import app.game.games.ThirdGame;

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
					game = new FirstGame(App.world, DOC);
					break;
				case 2:
					game = new SecondGame(App.world, DOC);
					break;
				case 3:
					game = new ThirdGame(App.world, DOC);
					break;
				default :
					game = new FirstGame(App.world, DOC);
					break;
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
