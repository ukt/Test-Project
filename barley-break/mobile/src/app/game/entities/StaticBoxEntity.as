package app.game.entities {
	import flash.display.Graphics;
	import flash.display.MovieClip;

	public class StaticBoxEntity implements Entity {
		private var _ani:MovieClip = new MovieClip();

		private var name:String;


		public function StaticBoxEntity(name:String, x:Number, y:Number, width:int = 20, height:int = 20) {
			this.name = name;
			_ani.x = x * width + x * 15;
			_ani.y = y * height + y * 15;
			trace(x, y);
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
	}
}
