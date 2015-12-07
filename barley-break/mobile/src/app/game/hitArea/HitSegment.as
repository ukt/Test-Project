package app.game.hitArea {
	import flash.geom.Point;

	import loka.asUtils.collider.primitive.Segment;

	public class HitSegment extends Segment{
		public var mask:uint = 0;
		public var prevP1:Point;
		public var prevP2:Point;
		public function HitSegment(p1:Point, p2:Point, mask:uint) {
			super(p1, p2);
			prevP1=new Point(p1.x, p1.y);
			prevP2=new Point(p2.x, p2.y);
			this.mask = mask;
		}

		public function moveOnX(xOffset:Number):void {
			prevP1=new Point(_p1.x, _p1.y);
			prevP2=new Point(_p2.x, _p2.y);
			_p1.x +=xOffset;
			_p2.x +=xOffset;
		}
	}
}
