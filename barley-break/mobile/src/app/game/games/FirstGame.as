package app.game.games {
	import app.App;
	import app.game.entities.BorderEntity;
	import app.game.entities.PointEntity;
	import app.world.World;

	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;

	public class FirstGame extends BaseGame {
		public function FirstGame(world:World, DOC:DisplayObjectContainer) {
			super(world, DOC);
		}

		override public function start():void {
			super.start();



//			world.addEntity(new BoxEntity(5 + "_" + 5, 5, 2, 100, 100));
			world.addEntity(new PointEntity(100, 100));
			world.addEntity(new PointEntity(200, 100));
			world.addEntity(new PointEntity(100, 200));
			world.addEntity(new PointEntity(200, 200));
//			world.addEntity(new ColliderEntity());
			App.main.stage.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void{
				world.addEntity(new PointEntity(event.stageX, event.stageY + 20));
			});
//			world.addEntity(new BoxEntity(5 + "_" + 5, 7, 2, 100, 100));
			/*var count:int = 4;
			for (var x:uint = 1; x <= count; x++) {
				var y:uint = 1;
				for (y; y <= count; y++) {
					world.addEntity(new BoxEntity(x + "_" + y, x, y, 100, 100));
				}
			}*/
//			world.addEntity(new StaticBoxEntity("Box", 4, 10, 60, 60));
			//			world.addEntity(new StaticBoxEntity("Box", 5, 14, 140, 60));
			//			world.addEntity(new StaticBoxEntity("Box", 6, 5, 60, 60));
			//			world.addEntity(new BoxEntitySpawner("Spawn", 6, 5, 100, 60));
			//			world.addEntity(new BoxEntityAutoSpawner("AutoSpawn"));
			world.addEntity(new BorderEntity(10, 40, App.deviceSize.width - 20, App.deviceSize.height - 50));
		}
	}
}
