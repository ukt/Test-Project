package app.game.entities {
	import app.game.entities.actions.Entity;
	import app.game.entities.actions.EntityMover;
	import app.game.entities.actions.HittableEntity;
	import app.game.hitArea.HitArea;
	import app.game.hitArea.PhysicalHitArea;

	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.geom.Point;

	import loka.asUtils.collider.primitive.Segment;

	public class BorderEntity implements Entity, HittableEntity, EntityMover {
		private var _ani:MovieClip = new MovieClip();
		private var _hitArea:PhysicalHitArea;

		public function BorderEntity(x:Number, y:Number, width:int = 800, height:int = 600) {
			_hitArea = new PhysicalHitArea(this);
			_hitArea.addSegmentByPoints(2, new Point(x, y), new Point(x + width, y), new Point(x + width, y + height), new Point(x, y + height), new Point(x, y));
			_hitArea.weight = 100;
			ani.cacheAsBitmap = true;
		}

		public function initialize():void {
			var graphics:Graphics = _ani.graphics;
			graphics.clear();
			for each(var segment:Segment in hitArea.segments) {
				graphics.lineStyle(4, 0xcecece, 1, true);
				graphics.moveTo(segment.point1.x, segment.point1.y);
				graphics.lineTo(segment.point2.x, segment.point2.y);
				graphics.endFill();
			}
			graphics.endFill();
		}

		public function updateDT(dt:uint):void {
//			_hitArea.update(dt);
		}

		public function update():void {

		}

		public function get ani():MovieClip {
			return _ani;
		}

		public function dispose():void {
			if (_ani.parent) {
				_ani.parent.removeChild(_ani);
			}
		}

		public function get hitArea():HitArea {
			return _hitArea;
		}

		public function addSpeed(target:EntityMover, xSpeed:int, ySpeed:int):void {
			target.addSpeed(this, -xSpeed*.5, -ySpeed*.5);
		}

		public function get speedX():Number {
			return 0;
		}

		public function get speedY():Number {
			return 0;
		}

		public function moveBack():void {
		}
	}
}
