package app.game.entities {
	import app.App;
	import app.game.entities.actions.Entity;
	import app.game.entities.actions.HittableEntity;
	import app.game.entities.actions.SpeedAdder;
	import app.game.hitArea.HitArea;
	import app.game.hitArea.HitSegment;

	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class StaticBoxEntity implements Entity, SpeedAdder, HittableEntity {
		private var _ani:MovieClip = new MovieClip();

		private var name:String;
		private var _hitArea:HitArea;
		public function get hitArea():HitArea {
			return _hitArea;
		}

		public function StaticBoxEntity(name:String, x:Number, y:Number, width:int = 20, height:int = 20) {
			_hitArea = new HitArea(this);
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
			if(Capabilities.isDebugger) {
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
			_hitArea = new HitArea(this);
			_hitArea.addSegment(new HitSegment(new Point(_ani.x, _ani.y), new Point(_ani.x, _ani.y + _ani.height), 2));
			_hitArea.addSegment(new HitSegment(new Point(_ani.x, _ani.y), new Point(_ani.x + _ani.width, _ani.y), 2));
			_hitArea.addSegment(new HitSegment(new Point(_ani.x + _ani.width, _ani.y), new Point(_ani.x + _ani.width, _ani.y + _ani.height), 2));
			_hitArea.addSegment(new HitSegment(new Point(_ani.x, _ani.y + _ani.height), new Point(_ani.x + _ani.width, _ani.y + _ani.height), 2));

		}

		public function addSpeed(target:Entity, xSpeed:int, ySpeed:int):void {
			if(target is SpeedAdder){
				SpeedAdder(target).addSpeed(this, xSpeed, ySpeed);
			}
		}

		public function update():void {
		}

		public function get ani():MovieClip {
			return _ani;
		}

		public function dispose():void {
		}
	}
}
