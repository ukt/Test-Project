package app.states {
	import app.App;
	import app.game.games.FirstGame;
	import app.game.games.Game;
	import app.game.games.SecondGame;
	import app.game.games.ThirdGame;
	import app.world.World;

	import cdn.Assets;

	import flash.display.Bitmap;
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
		private var btnPause:MovieClip;
		private var btnStart:MovieClip;
		private var btnNext:MovieClip;

		public function GameState() {
			super(new Sprite(), NAME);
		}

		private var _world:World;

		override public function init():void {
			var background:Bitmap = new Assets.background();
			var backgroundMc:Sprite = new Sprite();
			backgroundMc.addChild(background);
			DOC.addChild(backgroundMc);
			backgroundMc.name = "background";
			background.x = 10;
			background.y = 40;
			background.height = 430;
			background.width = 780;
			background.alpha = .2;
			btnBack = Buttones.createRectBtn(App.deviceSize.width - 110, 5, 100, "Back");
			btnPause = Buttones.createRectBtn(App.deviceSize.width - 220, 5, 100, "Pause");
			btnStart = Buttones.createRectBtn(App.deviceSize.width - 220, 5, 100, "Start");
			btnNext = Buttones.createRectBtn(App.deviceSize.width - 330, 5, 100, "Next Step");
			DOC.addChild(btnBack);
			DOC.addChild(btnPause);
			DOC.addChild(btnStart);
			DOC.addChild(btnNext);
			btnStart.visible = false;
			btnNext.visible = false;
		}

		public override function activate(gameNumber:* = null):void {
			super.activate(gameNumber);
			_world = App.world;
			switch (gameNumber) {
				case 1:
					game = new FirstGame(_world, DOC);
					break;
				case 2:
					game = new SecondGame(_world, DOC);
					break;
				case 3:
					game = new ThirdGame(_world, DOC);
					break;
				default :
					game = new FirstGame(_world, DOC);
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
			btnPause.addEventListener(MouseEvent.CLICK, clickStartPause);
			btnStart.addEventListener(MouseEvent.CLICK, clickStartPause);
			btnNext.addEventListener(MouseEvent.CLICK, clickNextBtn);
		}

		private function clickNextBtn(event:MouseEvent):void {
			_world.next();
		}

		private function clickStartPause(event:MouseEvent):void {
			if(btnStart.visible) {
				_world.start();
				btnNext.visible = false;
			} else {
				_world.pause();
				btnNext.visible = true;
			}
			btnStart.visible = btnPause.visible;
			btnPause.visible = !btnPause.visible;
		}

		private static function clickBack(event:MouseEvent):void {
			StateMachine.gotoState(MenuState.NAME);
		}
	}
}
