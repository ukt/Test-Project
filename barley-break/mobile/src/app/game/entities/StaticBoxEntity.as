package app.game.entities {
	import app.App;
	import app.game.entities.actions.Entity;
	import app.game.entities.actions.EntityMover;
	import app.game.entities.actions.HittableEntity;
	import app.game.hitArea.HitArea;
	import app.game.hitArea.HitSegment;
	import app.game.hitArea.PhysicalHitArea;

	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class StaticBoxEntity implements Entity, EntityMover, HittableEntity {
		private var _ani:MovieClip = new MovieClip();

		private var name:String;
		private var _hitArea:PhysicalHitArea;
		public function get hitArea():HitArea {
			return _hitArea;
		}

		public function StaticBoxEntity(name:String, x:Number, y:Number, width:int = 20, height:int = 20) {
			_hitArea = new PhysicalHitArea(this);
			width = width * App.appScale;
			height = height * App.appScale;
			this.name = name + x + "_" + y;
			_ani.x = x * width + x * 5;
			_ani.y = y * height + y * 5;
			trace(x, y);
			var textField:TextField = new TextField();
			textField.text = this.name;
			textField.width = width - 1;
			textField.height = height - 1;
			textField.selectable = false;
			textField.cacheAsBitmap = true;
			textField.autoSize = TextFieldAutoSize.CENTER;
			if (Capabilities.isDebugger) {
				_ani.addChild(textField);
			}
			var graphics:Graphics = _ani.graphics;
			var colorArray:Array = [0xCECECE];
			var randomColorID:Number = Math.floor(Math.random() * colorArray.length);
			var color:uint = colorArray[randomColorID];
			graphics.lineStyle(4, 0xbebebe, 1, true);
			graphics.beginFill(color, 1);
			graphics.drawRoundRect(0, 0, width, height, 10);
			graphics.endFill();
			ani.cacheAsBitmap = true;
		}

		public function initialize():void {
			_hitArea = new PhysicalHitArea(this);
			_hitArea.weight=1000;
			_hitArea.addSegment(new HitSegment(new Point(_ani.x, _ani.y), new Point(_ani.x, _ani.y + _ani.height), 2));
			_hitArea.addSegment(new HitSegment(new Point(_ani.x, _ani.y), new Point(_ani.x + _ani.width, _ani.y), 2));
			_hitArea.addSegment(new HitSegment(new Point(_ani.x + _ani.width, _ani.y), new Point(_ani.x + _ani.width, _ani.y + _ani.height), 2));
			_hitArea.addSegment(new HitSegment(new Point(_ani.x, _ani.y + _ani.height), new Point(_ani.x + _ani.width, _ani.y + _ani.height), 2));

		}

		public function updateDT(dt:uint):void {
			_hitArea.update(dt);
		}

		public function update():void {
			_ani.x = hitArea.centralCircle.point.x - _ani.width/2;
			_ani.y = hitArea.centralCircle.point.y - _ani.height/2;
		}

		public function get ani():MovieClip {
			return _ani;
		}

		public function dispose():void {
			if (_ani.parent) {
				_ani.parent.removeChild(_ani);
			}
		}

		public function addSpeed(target:EntityMover, xSpeed:int, ySpeed:int):void {
			target.addSpeed(this, xSpeed, ySpeed);
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
