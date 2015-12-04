package app.game.games {
	import app.World;
	import app.game.entities.HitAreaDrawerEntity;

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
		}

		public function dispose():void {
			world.dispose();
		}
	}
}
