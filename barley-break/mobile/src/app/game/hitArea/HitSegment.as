package app.game.hitArea {
	import flash.geom.Point;

	import loka.asUtils.collider.primitive.Segment;

	public class HitSegment extends Segment{
		public var mask:uint = 0;
		public var prevP1:Point;
		public var prevP2:Point;
		public function HitSegment(p1:Point, p2:Point, mask:uint) {
			super(p1, p2);
			prevP1=p1.clone();
			prevP2=p2.clone();
			this.mask = mask;
		}

		public function moveOnX(xOffset:Number):void {
			prevP1=point1.clone();
			prevP2=point2.clone();
			point1.x +=xOffset;
			point2.x +=xOffset;
		}
	}
}
