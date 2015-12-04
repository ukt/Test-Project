package app.collider {
	import app.App;
	import app.game.entities.Entity;
	import app.game.entities.HittableEntity;
	import app.game.hitArea.HitArea;

	import loka.asUtils.collider.Collide;
	import loka.asUtils.collider.primitive.Segment;

	public class Collider {
		public function Collider() {
		}

		public function getCollidedEntities(hitArea:HitArea):Vector.<Entity> {
			var result:Vector.<Entity> = new <Entity>[];

			App.world.forEach(HittableEntity, function (hittableEntity:HittableEntity):void {
				if(hittableEntity === hitArea.entity){
					return;
				}
				for each(var segmentAtBody1:Segment in hitArea.segments) {
					for each(var segmentAtBody2:Segment in hittableEntity.hitArea.segments) {
						if (Collide.segmentsIntersection(segmentAtBody1, segmentAtBody2)) {
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
