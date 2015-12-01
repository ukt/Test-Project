package app.game.hitArea {
	import flash.geom.Point;

	import loka.asUtils.collider.primitive.Segment;

	public class HitSegment extends Segment{
		public var mask:uint = 0;
		public function HitSegment(p1:Point, p2:Point, mask:uint) {
			super(p1, p2);
			this.mask = mask;
		}
	}
}
