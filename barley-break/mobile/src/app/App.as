package app {
	import app.states.GameState;
	import app.states.MenuState;
	import app.world.World;

	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	import loka.app.view.stateMachine.StateMachine;

	public class App {
		public static const world:World = new World();
		public static var main:Sprite;
		public static var tf:TextField;
		public static var appScale:Number = 1;
		public static var appSize:Rectangle;
		public static var appLeftOffset:int;
		public static var deviceSize:Rectangle;

		public function App(main:Sprite) {
			App.main = main;
			initializeAppGUI(main);
			initializeUIStates(main);
			tf = new TextField();
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.border = true;
			tf.mouseEnabled = false;
			main.addChild(tf);
			main.addEventListener(Event.ENTER_FRAME, updateUI);
		}

		private static function initializeUIStates(main:Sprite):void {
			StateMachine.init(main);
			StateMachine.registerState(new MenuState());
			StateMachine.registerState(new GameState());
			StateMachine.gotoState(MenuState.NAME);
		}

		private static function updateUI(event:Event):void {
			tf.parent.addChild(tf);
		}

		private static function initializeAppGUI(main:Sprite):void {
			var guiSize:Rectangle = new Rectangle(0, 0, 1024, 600);
			var stage:Stage = main.stage;
			deviceSize = new Rectangle(0, 0,
					Math.max(stage.fullScreenWidth, stage.fullScreenHeight),
					Math.min(stage.fullScreenWidth, stage.fullScreenHeight)
			);

			appSize = guiSize.clone();
			appLeftOffset = 0;

			// if device is wider than GUI's aspect ratio, height determines scale
			if ((deviceSize.width / deviceSize.height) > (guiSize.width / guiSize.height)) {
				appScale = deviceSize.height / guiSize.height;
				appSize.width = deviceSize.width / appScale;
				appLeftOffset = Math.round((appSize.width - guiSize.width) / 2);
			}
			// if device is taller than GUI's aspect ratio, width determines scale
			else {
				appScale = deviceSize.width / guiSize.width;
				appSize.height = deviceSize.height / appScale;
				appLeftOffset = 0;
			}
		}
	}
}
