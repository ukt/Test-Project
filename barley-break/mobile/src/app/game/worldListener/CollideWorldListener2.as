package app.game.worldListener {
	import app.App;
	import app.game.entities.actions.Entity;
	import app.game.entities.actions.HittableEntity;
	import app.game.hitArea.PhysicalHitArea;
	import app.world.IWorldListener;
	import app.world.World;

	import flash.utils.Dictionary;

	import loka.asUtils.ObjectUtils;

	public class CollideWorldListener2 implements IWorldListener {
		private var world:World;

		public function CollideWorldListener2() {
		}

		public function updateDtComplete(dt:int):void {
			collide();
		}

		private function collide():void {
			var world:World = App.world;
			var dict:Dictionary = new Dictionary();
			world.forEach(HittableEntity, function (entityMover:HittableEntity):void {
				var entities:Vector.<Entity> = world.collide(HittableEntity(entityMover).hitArea);
				for each (var entity:Entity in entities) {
					if (HittableEntity(entity).hitArea is PhysicalHitArea && entityMover.hitArea is PhysicalHitArea) {
						var uniqueKeyForEntity:uint = ObjectUtils.getUniqueKey(entity);
						var uniqueKeyForEntityMover:uint = ObjectUtils.getUniqueKey(entityMover);

						var duplicateKey:String = uniqueKeyForEntityMover + "_" + uniqueKeyForEntity;
						var duplicateKeyInvert:String = uniqueKeyForEntity + "_" + uniqueKeyForEntityMover;
						if (dict[duplicateKey] || dict[duplicateKeyInvert]) {
							trace("collide twice");
							continue;
						}
						if (entityMover === entity) {
							trace("collide")
						}
						var physicalHitArea1:PhysicalHitArea = PhysicalHitArea(HittableEntity(entity).hitArea);
						var physicalHitArea2:PhysicalHitArea = PhysicalHitArea(entityMover.hitArea);

						var speedXSum1:Number = physicalHitArea2.speedX - physicalHitArea1.speedX;
						var speedXSum2:Number = physicalHitArea1.speedX - physicalHitArea2.speedX;
						var needAddSpeedXToEntity1:Number = speedXSum1 / (physicalHitArea1.weight);
						var needAddSpeedXToEntity2:Number = speedXSum2 / (physicalHitArea2.weight);
						physicalHitArea1.moveToPrevXPosition();
						physicalHitArea2.moveToPrevXPosition();
						var duration:Number = .4;
						physicalHitArea1.speedX = needAddSpeedXToEntity1 * duration;
						physicalHitArea2.speedX = needAddSpeedXToEntity2 * duration;

						var speedYSum1:Number = physicalHitArea2.speedY - physicalHitArea1.speedY;
						var speedYSum2:Number = physicalHitArea1.speedY - physicalHitArea2.speedY;
						var needAddSpeedYToEntity1:Number = speedYSum1 / (physicalHitArea1.weight);
						var needAddSpeedYToEntity2:Number = speedYSum2 / (physicalHitArea2.weight);
						physicalHitArea1.moveToPrevYPosition();
						physicalHitArea2.moveToPrevYPosition();
						physicalHitArea1.speedY = needAddSpeedYToEntity1 * duration;
						physicalHitArea2.speedY = needAddSpeedYToEntity2 * duration;

						dict[duplicateKey] = entityMover;
						dict[duplicateKeyInvert] = entity;
					}
				}
			})
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
