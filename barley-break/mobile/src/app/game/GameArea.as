package app.game {
	import app.World;
	import app.game.entities.BoxEntity;
	import app.game.entities.BoxEntitySpawner;
	import app.game.entities.StaticBoxEntity;

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
			world.addEntity(new StaticBoxEntity("Box", 4, 10, 30, 30));
			world.addEntity(new StaticBoxEntity("Box", 5, 14, 70, 30));
			world.addEntity(new StaticBoxEntity("Box", 6, 5, 30, 30));
			world.addEntity(new BoxEntitySpawner("Spawn", 5, 8, 50, 30));
		}
	}
}
