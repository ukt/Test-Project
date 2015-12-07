package app.game.entities {
	import app.App;
	import app.game.entities.actions.Entity;
	import app.game.entities.actions.EntityMover;
	import app.game.entities.actions.HittableEntity;
	import app.world.World;

	import flash.display.MovieClip;

	public class ColliderEntity implements Entity {
		private var _movieClip:MovieClip = new MovieClip();

		public function ColliderEntity() {
		}

		public function update():void {
		}

		public function initialize():void {
		}

		public function get ani():MovieClip {
			return _movieClip;
		}

		public function updateDT(dt:uint):void {
			var world:World = App.world;
			world.forEach(EntityMover, function(entityMover:EntityMover):void{
				var entities:Vector.<Entity> = world.collide(HittableEntity(entityMover).hitArea);
			})
		}

		public function dispose():void {
		}
	}
}
