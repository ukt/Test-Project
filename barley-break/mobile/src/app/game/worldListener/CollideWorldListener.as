package app.game.worldListener {
	import app.game.entities.actions.Entity;
	import app.game.entities.actions.EntityMover;
	import app.game.entities.actions.HittableEntity;
	import app.game.hitArea.HitSegment;
	import app.world.IWorldListener;
	import app.world.World;

	import flash.utils.Dictionary;

	import loka.asUtils.collider.Collide;
	import loka.asUtils.collider.primitive.Segment;

	public class CollideWorldListener implements IWorldListener {
		private var world:World;

		public function CollideWorldListener() {
		}

		public function updateDtComplete(dt:int):void {
			collide();
		}

		private function collide():void {
			var dict:Dictionary = new Dictionary();
			world.forEach(HittableEntity, function (hittableEntity1:HittableEntity):void {
				world.forEach(HittableEntity, function (hittableEntity2:HittableEntity):void {
					if (hittableEntity1 === hittableEntity2) {
						return;
					}
					if (dict[hittableEntity1 + hittableEntity2] || dict[hittableEntity2 + hittableEntity1]) {
						return;
					}
					if (hittableEntity1 is EntityMover && hittableEntity2 is EntityMover) {
						for each(var segmentAtBody1:HitSegment in hittableEntity1.hitArea.segments) {
							for each(var segmentAtBody2:HitSegment in hittableEntity2.hitArea.segments) {
								if (
										Collide.segmentsIntersection(segmentAtBody1, segmentAtBody2)||
										Collide.segmentsIntersection(
												new Segment(segmentAtBody1.prevP1, segmentAtBody1.point1),
												new Segment(segmentAtBody2.prevP1, segmentAtBody2.point1)
										)&&
										Collide.segmentsIntersection(
												new Segment(segmentAtBody1.prevP2, segmentAtBody1.point2),
												new Segment(segmentAtBody2.prevP2, segmentAtBody2.point2)
										)
								) {
									dict[hittableEntity1 + hittableEntity2] = true;
									dict[hittableEntity2 + hittableEntity1] = true;
									var entityMover1:EntityMover = EntityMover(hittableEntity1);
									var entityMover2:EntityMover = EntityMover(hittableEntity2);
									var speedX2:Number = entityMover2.speedX;
									var speedX1:Number = entityMover1.speedX;
									var speedY2:Number = entityMover2.speedY;
									var speedY1:Number = entityMover1.speedY;
									entityMover1.moveBack();
									entityMover2.moveBack();
									entityMover1.addSpeed(entityMover2, speedX2 - speedX1, speedY2 - speedY1);
									entityMover2.addSpeed(entityMover1, speedX1 - speedX2, speedY1 - speedY2);
									return;
								}
							}
						}
					}

				});
			});
		}

		public function updateComplete():void {
//			collide();
		}

		public function entityAdded(entity:Entity):void {
		}

		public function entityRemoved(entity:Entity):void {
		}

		public function initialize(world:World):void {
			this.world = world
		}
	}
}
