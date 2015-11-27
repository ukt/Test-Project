package app.game {
	import app.App;
	import app.game.entities.BoxEntity;

	public class GameArea {
		public function GameArea() {
			for (var x:uint = 0; x < 10; x++) {
				for (var y:uint = 0; y < 10; y++) {
					App.world.addEntity(new BoxEntity(x + "_" + y, x, y));
				}
			}
		}
	}
}
