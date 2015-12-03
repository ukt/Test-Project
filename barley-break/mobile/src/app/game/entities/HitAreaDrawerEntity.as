package app.game.entities {
	import app.App;
	import app.game.hitArea.HitArea;
import app.game.hitArea.HitSegment;

import flash.display.DisplayObjectContainer;

import flash.display.Graphics;
	import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

import loka.asUtils.collider.primitive.Segment;

public class HitAreaDrawerEntity implements Entity {
		private var _ani:MovieClip = new MovieClip();

		private var _hitArea:HitArea;
		public function get hitArea():HitArea {
			return _hitArea;
		}
		public function HitAreaDrawerEntity() {

		}

		public function initialize():void {
			_ani = new MovieClip();
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

		public function update():void {
			var graphics:Graphics = _ani.graphics;
			graphics.clear();
			graphics.lineStyle(4, 0x000, 1, true);
			graphics.beginFill(0xcecece, .1);
			graphics.drawRoundRect(0, 0, App.deviceSize.width, App.deviceSize.height, 10);
			graphics.endFill();


			App.world.forEach(HitableEntity, function(entity:HitableEntity):void{
				for each(var segment:Segment in entity.hitArea.segments) {
					graphics.lineStyle(4, 0xff0000, 1, true);
					graphics.moveTo(segment.point1.x, segment.point1.y);
					graphics.lineTo(segment.point2.x, segment.point2.y);
					graphics.endFill();
				}
			});

		}

		public function collide(entity:Entity):Boolean {
			return false;
		}

		public function get ani():MovieClip {
			return _ani;
		}

		public function dispose():void {
			if(_ani.parent){
				_ani.parent.removeChild(_ani);
			}
		}
	}
}
