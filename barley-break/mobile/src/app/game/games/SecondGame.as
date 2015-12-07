package app.game.games {
	import app.App;
	import app.game.entities.AccelerometerShower;
	import app.game.entities.BorderEntity;
	import app.game.entities.BoxEntity;
	import app.game.entities.StaticBoxEntity;
	import app.world.World;

	import flash.display.DisplayObjectContainer;

	public class SecondGame extends BaseGame {
		public function SecondGame(world:World, DOC:DisplayObjectContainer) {
			super(world, DOC);
		}

		override public function start():void {
			super.start();
			var countX:int = 6;
			var countY:int = 2;
			for (var x:uint = 1; x <= countX; x++) {
				for (var y:uint = 1; y <= countY; y++) {
					world.addEntity(new BoxEntity(x + "_" + y, x, y, 90, 90));
				}
			}
			for (x = 2; x <= 15; x++) {
				if(x==7){
					world.addEntity(new AccelerometerShower("", x, 5, 50, 50));
				} else {
					world.addEntity(new StaticBoxEntity("", x, 5, 50, 50));
				}
			}
			//			world.addEntity(new StaticBoxEntity("Box", 5, 14, 140, 60));
			//			world.addEntity(new StaticBoxEntity("Box", 6, 5, 60, 60));
			//			world.addEntity(new BoxEntitySpawner("Spawn", 6, 5, 100, 60));
			//			world.addEntity(new BoxEntityAutoSpawner("AutoSpawn"));
			world.addEntity(new BorderEntity(10, 40, App.deviceSize.width - 20, App.deviceSize.height - 50));
		}
	}
}
