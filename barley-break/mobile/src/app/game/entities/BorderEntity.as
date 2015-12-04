package app.game.entities {
	import app.App;
	import app.game.hitArea.HitArea;

	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	import loka.asUtils.collider.primitive.Segment;

	public class BorderEntity implements Entity, HittableEntity {
		private var _ani:MovieClip = new MovieClip();
		private var _hitArea:HitArea;

		public function BorderEntity(x:Number, y:Number, width:int = 800, height:int = 600) {
			_hitArea = new HitArea(this);
			_hitArea.addSegmentByPoints(2,
					new Point(x, y),
					new Point(x + width, y),
					new Point(x + width, y + height),
					new Point(x, y + height),
					new Point(x, y)
			);
			ani.cacheAsBitmap = true;
		}

		public function initialize():void {
		}

		private static function onClick(event:MouseEvent):void {
			App.world.updateAccelerometerData();
		}

		public function update():void {
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

		public function get ani():MovieClip {
			return _ani;
		}

		public function dispose():void {
			if (_ani.parent) {
				_ani.removeEventListener(MouseEvent.CLICK, onClick);
				_ani.parent.removeChild(_ani);
			}
		}

		public function get hitArea():HitArea {
			return _hitArea;
		}
	}
}
