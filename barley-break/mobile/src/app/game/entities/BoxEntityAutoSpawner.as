package app.game.entities {
	import app.App;
	import app.World;
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
			while (world.isCollided(boxEntity)) {
				var deviceSize:Rectangle = App.deviceSize;
				boxEntity.ani.x = Math.random() * deviceSize.width - boxEntity.ani.width;
				boxEntity.ani.y = Math.random() * deviceSize.height - boxEntity.ani.height;
			}
		}

		public function update():void {
		}

		public function collide(entity:Entity):Boolean {
			var ani2:MovieClip = entity.ani;
			if (entity === this) {
				return false;
			}
			var isAniInCubeByXAsLeft:Boolean = ani.x <= ani2.x && ani.x + ani.width >= ani2.x;
			var isAniInCubeByXAsRight:Boolean = ani.x >= ani2.x && ani.x <= ani2.x + ani2.width;
			var isAniInCubeByYAsTop:Boolean = ani.y >= ani2.y && ani.y <= ani2.y + ani2.height;
			var isAniInCubeByYAsBottom:Boolean = ani.y <= ani2.y && ani.y + ani.height >= ani2.y;

			var isCollided:Boolean = false;
			if (isAniInCubeByXAsLeft && isAniInCubeByYAsTop) {
				isCollided = true;
			}
			if (isAniInCubeByXAsLeft && isAniInCubeByYAsBottom) {
				isCollided = true;
			}
			if (isAniInCubeByXAsRight && isAniInCubeByYAsTop) {
				isCollided = true;
			}
			if (isAniInCubeByXAsRight && isAniInCubeByYAsBottom) {
				isCollided = true;
			}
			return isCollided;
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
	}
}
