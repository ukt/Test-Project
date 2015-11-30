package app.game {
	import app.World;
	import app.game.entities.BoxEntity;

	public class GameArea {
		public function GameArea(world:World) {
			var count:int = 3;
			for (var x:uint = 1; x <= count; x++) {
				var y:uint = 0;
				for (y; y <= count; y++) {
					world.addEntity(new BoxEntity(x + "_" + y, x, y, 60, 60));
				}
				for (y; y <= count*2; y++) {
					world.addEntity(new BoxEntity(x + "_" + y, x*y, y, 30, 30));
				}
			}
		}
	}
}
