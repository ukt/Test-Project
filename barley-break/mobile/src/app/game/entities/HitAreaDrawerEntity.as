package app.game.entities {
	import app.App;
	import app.game.entities.actions.Entity;
	import app.game.entities.actions.HittableEntity;
	import app.game.hitArea.HitArea;
	import app.game.hitArea.HitSegment;

	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.utils.getTimer;

	import loka.asUtils.collider.primitive.Circle;

	public class HitAreaDrawerEntity implements Entity {
		private var _ani:MovieClip = new MovieClip();

		private var _hitArea:HitArea;
		public function get hitArea():HitArea {
			return _hitArea;
		}
		public function HitAreaDrawerEntity() {
			_hitArea = new HitArea(this)
		}

		public function initialize():void {
			_ani = new MovieClip();
			_ani.mouseEnabled = false;
			_ani.x = 0;
			_ani.y = 0;
			var graphics:Graphics = _ani.graphics;
			graphics.lineStyle(4, 0x000, 1, true);
			graphics.beginFill(0xcecece, .1);
			graphics.drawRoundRect(0, 0, App.deviceSize.width, App.deviceSize.height, 10);
			graphics.endFill();
			ani.cacheAsBitmap = true;

			_hitArea = new HitArea(this);
		}
		public function updateDT(dt:uint):void {

		}
		private var _time:uint = 0;
		public function update():void {
			if(getTimer() - _time<50){
				return;
			}
			var graphics:Graphics = _ani.graphics;
			graphics.clear();
			graphics.lineStyle(4, 0x000, 1, true);
			graphics.beginFill(0xcecece, .1);
			graphics.drawRoundRect(0, 0, App.deviceSize.width, App.deviceSize.height, 10);
			graphics.endFill();


			App.world.forEach(HittableEntity, function(entity:HittableEntity):void{
				graphics.lineStyle(2, 0xcecece, 1, true);
				var centralCircle:Circle = entity.hitArea.centralCircle;
				var point:Point = centralCircle.point;
				graphics.drawCircle(point.x, point.y, centralCircle.radius);

				for each(var segment:HitSegment in entity.hitArea.segments) {
					if(segment.point1.x<0 || segment.point1.x>App.deviceSize.width || segment.point1.y<0 || segment.point1.y>App.deviceSize.height){
						continue;
					}
					graphics.lineStyle(1, 0xff0000, 1, true);
					graphics.moveTo(segment.point1.x, segment.point1.y);
					graphics.lineTo(segment.point2.x, segment.point2.y);

					graphics.drawCircle(segment.point1.x, segment.point1.y, 2);
					graphics.drawCircle(segment.point2.x, segment.point2.y, 2);

					graphics.lineStyle(1, 0x0000ff, .5, true);

					graphics.drawCircle(segment.prevP1.x, segment.prevP1.y, 2);
					graphics.drawCircle(segment.prevP2.x, segment.prevP2.y, 2);

					graphics.moveTo(segment.prevP1.x, segment.prevP1.y);
					graphics.lineTo(segment.point1.x, segment.point1.y);
					graphics.moveTo(segment.prevP2.x, segment.prevP2.y);
					graphics.lineTo(segment.point2.x, segment.point2.y);

					graphics.endFill();
				}
			});
			_time = getTimer();
			if(_ani.parent) {
				_ani.parent.addChild(_ani);
			} else {
				App.main.addChild(_ani);
			}
		}

		public function get ani():MovieClip {
			return _ani;
		}

		public function dispose():void {
			if(_ani.parent){
				_ani.graphics.clear();
				_ani.parent.removeChild(_ani);
			}
		}
	}
}
