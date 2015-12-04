package app.game.hitArea {
	import app.game.entities.Entity;

	import flash.geom.Point;

	import loka.asUtils.collider.primitive.Circle;
	import loka.asUtils.collider.primitive.Segment;

	public class HitArea {
		public var entity:Entity;
		public var segments:Vector.<HitSegment> = new <HitSegment>[];
		public var circles:Vector.<HitCircle> = new <HitCircle>[];

		public function HitArea(entity:Entity) {
			this.entity = entity;
		}

		public function addSegmentByPoints(mask:uint, p1:Point, p2:Point, ...points):void {
			addSegment(new HitSegment(p1, p2, mask));
			var prevPoints:Point = p2;
			for each (var point:* in points){
				if(point is Point){
					var nextPoint:Point = Point(point);
					addSegment(new HitSegment(prevPoints, nextPoint, mask));
					prevPoints = nextPoint;
				}
			}
		}

		public function addSegment(segment:HitSegment):void {
			segments.push(segment);
		}

		public function addCircle(circle:HitCircle):void {
			circles.push(circle);
		}


		private var _prevX:Number = 0;
		private var _prevY:Number = 0;

		public function moveToPrevXPosition():void {
			moveXPosition(_prevX);
		}

		public function moveToPrevYPosition():void {
			moveYPosition(_prevY);
		}

		public function moveXPosition(xOffset:Number):void {
			_prevX = -xOffset;
			for each(var segment:Segment in segments) {
				segment.point1.x += xOffset;
				segment.point2.x += xOffset;
			}

			for each(var circle:Circle in circles) {
				circle.point.x += xOffset;
			}
		}

		public function moveYPosition(yOffset:Number):void {
			_prevY = -yOffset;
			for each(var segment:Segment in segments) {
				segment.point1.y += yOffset;
				segment.point2.y += yOffset;
			}
			for each(var circle:Circle in circles) {
				circle.point.y += yOffset;
			}
		}
	}
}
