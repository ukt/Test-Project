package app.game.entities {
	import app.App;
	import app.World;
	import app.game.hitArea.HitArea;

	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class BoxEntitySpawner implements Entity {
		private var _ani:MovieClip = new MovieClip();

		private var name:String;
		private var _hitArea:HitArea;

		public function BoxEntitySpawner(name:String, x:Number, y:Number, width:int = 20, height:int = 20) {
			_hitArea = new HitArea(this);
			this.name = name;
			width = width*App.appScale;
			height = height*App.appScale;
			_ani.x = x * width + x * 15;
			_ani.y = y * height + y * 15;
			trace(x, y);
			var graphics:Graphics = _ani.graphics;
			var colorArray:Array = [0xCECECE];
			var randomColorID:Number = Math.floor(Math.random() * colorArray.length);
			var color:uint = colorArray[randomColorID];
			var textField:TextField = new TextField();
			textField.text = name;
			textField.width = width - 1;
			textField.height = height - 1;
			textField.selectable = false;
			textField.cacheAsBitmap = true;
			textField.autoSize = TextFieldAutoSize.CENTER;
			_ani.addChild(textField);

			graphics.lineStyle(4, 0xaeaeae, 1, true);
			graphics.beginFill(color, 1);
			graphics.drawRoundRect(0, 0, width, height, 10);
			graphics.endFill();
			ani.cacheAsBitmap = true;
			ani.addEventListener(MouseEvent.CLICK, spawnNewEntity)
		}
		private var count:uint = 0;
		private function spawnNewEntity(event:MouseEvent):void {
			var size:int = 40 + Math.floor(Math.random() * 80);
			var boxEntity:BoxEntity = new BoxEntity("" + count++, 1, 1, size, size);
			var world:World = App.world;
			world.addEntity(boxEntity);
			while(world.isCollided(boxEntity)){
				var deviceSize:Rectangle = App.deviceSize;
				boxEntity.ani.x = Math.random() *deviceSize.width - boxEntity.ani.width;
				boxEntity.ani.y = Math.random() *deviceSize.height - boxEntity.ani.height;
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
		public function get hitArea():HitArea {
			return _hitArea;
		}
	}
}
