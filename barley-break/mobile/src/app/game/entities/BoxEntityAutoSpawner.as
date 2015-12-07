package app.game.entities {
	import app.App;
	import app.World;
	import app.game.entities.actions.Actioner;
	import app.game.entities.actions.Entity;
	import app.game.entities.actions.SquareGetter;
	import app.game.hitArea.HitArea;

	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;

	public class BoxEntityAutoSpawner implements Entity, Actioner {
		private var _ani:MovieClip = new MovieClip();
		private var _timeToCheck:int;
		private var _hitArea:HitArea;
		private var name:String;
		public function get hitArea():HitArea {
			return _hitArea;
		}

		public function BoxEntityAutoSpawner(name:String, timeToCheck:int = 5000) {
			_hitArea = new HitArea(this);
			this.name = name;
			_timeToCheck = timeToCheck
		}

		private var count:uint = 0;
		private var _timer:int = -1;

		private function spawnNewEntity():void {
			var size:int = 40 + Math.floor(Math.random() * 80);
			var boxEntity:BoxEntity = new BoxEntity("" + count++, 1, 1, size, size);
			var world:World = App.world;
			world.addEntity(boxEntity);
			while (world.isCollided(boxEntity.hitArea)) {
				var deviceSize:Rectangle = App.deviceSize;
				boxEntity.ani.x = Math.random() * deviceSize.width - boxEntity.ani.width;
				boxEntity.ani.y = Math.random() * deviceSize.height - boxEntity.ani.height;
			}
		}
		public function updateDT(dt:uint):void {

		}
		public function update():void {
		}

		public function get ani():MovieClip {
			return _ani;
		}

		public function dispose():void {
		}

		public function action():void {
			if (_timer < 0) {
				_timer = getTimer();

			}
			if (getTimer() - _timer > _timeToCheck) {
				var forEach:Array = App.world.getForEach(SquareGetter);
				var square:uint = 0;
				for each(var squareGetter:SquareGetter in forEach) {
					square += squareGetter.square;
				}
				if (square < 1500) {
					spawnNewEntity();
				}
				_timer =-1;
			}

		}

		//			trace("square", square);
		public function initialize():void {
		}
	}
}
