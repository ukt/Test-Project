package app.game.games {
	import app.game.entities.HitAreaDrawerEntity;
	import app.game.worldListener.CollideWorldListener2;
	import app.world.World;

	import flash.display.DisplayObjectContainer;
	import flash.system.Capabilities;

	public class BaseGame implements Game {

		protected var world:World;
		protected var DOC:DisplayObjectContainer;

		public function BaseGame(world:World, DOC:DisplayObjectContainer) {
			this.world = world;
			this.DOC = DOC;
		}

		public function start():void {
			world.initialize(DOC);
			if (Capabilities.isDebugger) {
				world.addEntity(new HitAreaDrawerEntity());
			}
			world.addWorldListener(new CollideWorldListener2());
		}

		public function dispose():void {
			world.dispose();
		}
	}
}
