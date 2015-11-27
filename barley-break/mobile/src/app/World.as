package app {
	import app.accelerometer.AccelerometerVO;
	import app.game.entities.Entity;

	import flash.display.Sprite;
	import flash.events.AccelerometerEvent;
	import flash.events.Event;
	import flash.sensors.Accelerometer;

	public class World {
		private var main:Sprite;
		private var entities:Vector.<Entity> = new <Entity>[];
		public var accelerometerVO:AccelerometerVO = new AccelerometerVO();

		public function World() {
		}

		public function initialize(main:Sprite):void {
			this.main = main;
			main.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			var accelerometer:Accelerometer = new Accelerometer();
			accelerometer.addEventListener(AccelerometerEvent.UPDATE, updateAccelerometer);
		}


		private function updateAccelerometer(event:AccelerometerEvent):void {
			accelerometerVO = new AccelerometerVO();
			accelerometerVO.accelerationX = event.accelerationX;
			accelerometerVO.accelerationY = event.accelerationY;
			accelerometerVO.accelerationZ = event.accelerationZ;

			App.tf.text =   "accelerationX: " + accelerometerVO.accelerationX + "\n" +
							"accelerationY: " + accelerometerVO.accelerationY + "\n";

		}

		private function onEnterFrame(event:Event):void {
			for each(var entity1:Entity in entities) {
				entity1.update();
				for each(var entity2:Entity in entities) {
					entity2.collide(entity1);
				}
			}
		}

		public function addEntity(entity:Entity):void {
			entities.push(entity);
			main.addChild(entity.ani);
		}
	}
}
