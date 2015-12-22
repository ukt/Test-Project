package app.game.entities {
	import app.App;
	import app.accelerometer.AccelerometerVO;
	import app.game.Acceleration;
	import app.game.entities.actions.Entity;
	import app.game.entities.actions.HittableEntity;
	import app.game.hitArea.HitArea;
	import app.game.hitArea.PhysicalHitArea;
	import app.world.World;

	import flash.display.MovieClip;
	import flash.geom.Point;

	public class PointEntity implements Entity, HittableEntity {
		private var _hitArea:PhysicalHitArea;

		public function PointEntity(x:int, y:int) {
			_hitArea = new PhysicalHitArea(this);
			_hitArea.addSegmentByPoints(2,
					new Point(x, y),
					new Point(x + 10, y + 10),
					new Point(x + 20, y + 0),
					new Point(x, y)
			)
		}

		public function get hitArea():HitArea {
			return _hitArea;
		}

		private var _ani:MovieClip = new MovieClip();

		public function get ani():MovieClip {
			return _ani;
		}

		public function update():void {
			/*_hitArea.update(dt)
			_hitArea.moveXPosition(Math.random() -.5);
			_hitArea.moveYPosition(Math.random() -.5);*/
		}

		public function initialize():void {
		}

		public function updateDT(dt:uint):void {
			var world:World = App.world;
			var accelerometerVO:AccelerometerVO = world.accelerometerVO;
			_hitArea.update(dt);
			_hitArea.speedX -=Acceleration.G * accelerometerVO.accelerationX;
			_hitArea.speedY +=Acceleration.G * accelerometerVO.accelerationY;
		}

		public function dispose():void {
		}
	}
}