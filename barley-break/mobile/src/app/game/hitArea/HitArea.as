package app.game.hitArea {
	import app.game.entities.actions.Entity;

	import flash.geom.Point;

	import loka.asUtils.collider.primitive.Circle;
	import loka.asUtils.collider.primitive.Segment;

	public class HitArea {
		public var entity:Entity;
		private var _segments:Vector.<HitSegment> = new <HitSegment>[];
		public var _circles:Vector.<HitCircle> = new <HitCircle>[];
		public var centralCircle:Circle = new Circle(new Point());

		public function HitArea(entity:Entity) {
			this.entity = entity;
		}

		private function updateCentralPoint():void {
			var sumX:Number = 0;
			var minX:Number = Number.MAX_VALUE;
			var minY:Number = Number.MAX_VALUE;
			var maxX:Number = Number.MIN_VALUE;
			var radius:Number = 0;
			var sumY:Number = 0;
			for each(var segment:Segment in segments) {
				sumX += segment.point1.x;
				sumY += segment.point1.y;
				if(segment.point1.x<minX){
					minX = segment.point1.x;
				}if(segment.point1.y<minY){
					minY = segment.point1.y;
				}
				if(segment.point1.x>maxX){
					maxX = segment.point1.x;
				}
			}
			centralCircle.point.x = sumX / segments.length;
			centralCircle.point.y = sumY / segments.length;
			for each(var segment2:Segment in segments) {
				radius = Math.max(centralCircle.point.subtract(segment2.point1).length, radius);
			}
			centralCircle.radius = radius;
		}

		public function addSegmentByPoints(mask:uint, p1:Point, p2:Point, ...points):HitArea {
			addSegment(new HitSegment(p1, p2, mask));
			var prevPoints:Point = p2;
			for each (var point:* in points){
				if(point is Point){
					var nextPoint:Point = Point(point);
					addSegment(new HitSegment(prevPoints, nextPoint, mask));
					prevPoints = nextPoint;
				}
			}
			return this;
		}

		public function addSegment(segment:HitSegment):HitArea {
			_segments.push(segment);
			updateCentralPoint();
			return this;
		}

		public function addCircle(circle:HitCircle):void {
			_circles.push(circle);
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
			for each(var segment:HitSegment in segments) {
				segment.moveOnX(xOffset);
				/*segment.point1.x += xOffset;
				segment.point2.x += xOffset;*/
			}

			for each(var circle:Circle in _circles) {
				circle.point.x += xOffset;
			}
			updateCentralPoint();
		}

		public function moveYPosition(yOffset:Number):void {
			_prevY = -yOffset;
			for each(var segment:Segment in _segments) {
				segment.point1.y += yOffset;
				segment.point2.y += yOffset;
			}
			for each(var circle:Circle in _circles) {
				circle.point.y += yOffset;
			}
			updateCentralPoint();
		}

		public function get segments():Vector.<HitSegment> {
			return _segments;
		}
	}
}
