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

		public function PointEntity(x:int, y:int, weight:Number = 1) {
			_hitArea = new PhysicalHitArea(this);
			var width:int = weight * 5;
			var i:int = 100;
			_hitArea.addSegmentByPoints(2,
					new Point(x + Math.random()*i, y+Math.random()* i),
					new Point(x + width + Math.random()*i, y + width + Math.random()*i),
					new Point(x + width * 2 + Math.random()*i, y + 0 + Math.random()*i),
					new Point(x + Math.random()*i, y + Math.random()*i)
			);
			_hitArea.weight = weight;
		}

		public function get hitArea():HitArea {
			return _hitArea;
		}

		private var _ani:MovieClip = new MovieClip();
		private var _useAcceleration:Boolean = true;

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
		public function set useAcceleration(value:Boolean){
			_useAcceleration = value;

		}
		public function updateDT(dt:uint):void {
			var world:World = App.world;
			var accelerometerVO:AccelerometerVO = world.accelerometerVO;
			_hitArea.update(dt);
			if(_useAcceleration) {
				_hitArea.speedX -= Acceleration.G * accelerometerVO.accelerationX;
				_hitArea.speedY += Acceleration.G * accelerometerVO.accelerationY;
			}
		}

		public function dispose():void {
			if(_ani.parent){
				_ani.parent.removeChild(_ani);
			}
		}
	}
}