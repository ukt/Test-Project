package app.game.hitArea {
	import app.game.entities.Entity;

	public class HitArea {
		public var entity:Entity;
		public var segmets:Vector.<HitSegment> = new <HitSegment>[];
		public var circles:Vector.<HitCircle> = new <HitCircle>[];
		public function HitArea(entity:Entity) {
			this.entity = entity;
		}

		public function addSegment(segment:HitSegment):void{
			segmets.push(segment);
		}

		public function addCircle(circle:HitCircle):void{
			circles.push(circle);
		}
	}
}
