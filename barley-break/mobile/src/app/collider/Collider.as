package app.collider {
	import app.App;
	import app.game.entities.actions.Entity;
	import app.game.entities.actions.HittableEntity;
	import app.game.hitArea.HitArea;
	import app.game.hitArea.HitSegment;

	import loka.asUtils.collider.Collide;
	import loka.asUtils.collider.primitive.Segment;

	public class Collider {
		public function Collider() {
		}

		public function getCollidedEntities(hitArea:HitArea, limit:uint = int.MAX_VALUE):Vector.<Entity> {
			var result:Vector.<Entity> = new <Entity>[];

			App.world.forEach(HittableEntity, function (hittableEntity:HittableEntity):void {
				if (result.length >= limit) {
					return;
				}
				if (hittableEntity === hitArea.entity) {
					return;
				}
				if(!Collide.circleOnCircleIntersection(hitArea.centralCircle, hittableEntity.hitArea.centralCircle)){
					return;
				}
				for each(var segmentAtBody1:HitSegment in hitArea.segments) {
					for each(var segmentAtBody2:HitSegment in hittableEntity.hitArea.segments) {
						if (Collide.segmentsIntersection(segmentAtBody1, segmentAtBody2)) {
							result.push(hittableEntity);
							return;
						} else if (Collide.segmentsIntersection(new Segment(segmentAtBody1.prevP1, segmentAtBody1.point1), segmentAtBody2)) {
							result.push(hittableEntity);
							return;
						} else if (Collide.segmentsIntersection(new Segment(segmentAtBody1.prevP2, segmentAtBody1.point2), segmentAtBody2)) {
							result.push(hittableEntity);
							return;
						}
					}
				}
			});
			return result;
		}
	}
}
