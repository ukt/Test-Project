package app.game {
	import app.App;
	import app.World;
	import app.game.entities.BorderEntity;
	import app.game.entities.BoxEntity;
	import app.game.entities.HitAreaDrawerEntity;

	import flash.system.Capabilities;

	public class GameArea {
		public function GameArea(world:World) {
			var count:int = 4;
			for (var x:uint = 1; x <= count; x++) {
				var y:uint = 1;
				for (y; y <= count; y++) {
					world.addEntity(new BoxEntity(x + "_" + y, x, y, 100, 100));
				}
				/*for (y; y <= count*2; y++) {
					world.addEntity(new BoxEntity(x + "_" + y,x+count*2, y-2, 50, 50));
				}*/
			}
//			world.addEntity(new StaticBoxEntity("Box", 4, 10, 60, 60));
//			world.addEntity(new StaticBoxEntity("Box", 5, 14, 140, 60));
//			world.addEntity(new StaticBoxEntity("Box", 6, 5, 60, 60));
//			world.addEntity(new BoxEntitySpawner("Spawn", 6, 5, 100, 60));
//			world.addEntity(new BoxEntityAutoSpawner("AutoSpawn"));
			world.addEntity(new BorderEntity(10, 10, App.deviceSize.width - 20, App.deviceSize.height - 20));
			if(Capabilities.isDebugger) {
				world.addEntity(new HitAreaDrawerEntity());
			}
		}
	}
}
