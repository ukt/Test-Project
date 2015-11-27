package app {
	import app.game.GameArea;

	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class App {
		public static const world:World = new World();
		public static var main:Sprite;
		public static var tf:TextField;
		public function App(main:Sprite) {
			App.main = main;
			tf = new TextField();
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.border = true;
			main.addChild(tf);
			world.initialize(main);
			new GameArea();
		}
	}
}
