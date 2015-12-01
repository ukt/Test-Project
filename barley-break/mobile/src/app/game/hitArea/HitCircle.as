package app.game.hitArea {
	import flash.geom.Point;

	import loka.asUtils.collider.primitive.Circle;

	import loka.asUtils.collider.primitive.Segment;

	public class HitCircle extends Circle {
		public var mask:uint = 0;
		public function HitCircle(p1:Point, r:uint, mask:uint) {
			super(p1, r);
			this.mask = mask;
		}
	}
}
