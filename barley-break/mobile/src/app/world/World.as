package app.world {
	import app.*;
	import app.accelerometer.AccelerometerVO;
	import app.collider.Collider;
	import app.game.entities.actions.Actioner;
	import app.game.entities.actions.Entity;
	import app.game.hitArea.HitArea;

	import flash.display.DisplayObjectContainer;
	import flash.events.AccelerometerEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.sensors.Accelerometer;
	import flash.system.Capabilities;
	import flash.utils.Timer;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;

	public class World {
		private var main:DisplayObjectContainer;
		private var entities:Vector.<Entity> = new <Entity>[];
		private var functions:Vector.<Function> = new <Function>[];
		public var accelerometerVO:AccelerometerVO = new AccelerometerVO();
		public var collider:Collider = new Collider();
		private var accelerometer:Accelerometer = new Accelerometer();
		private var worldListeners:Vector.<IWorldListener> = new <IWorldListener>[];

		public function World() {
		}

		public function addWorldListener(worldListener:IWorldListener):void {
			worldListeners.push(worldListener);
			worldListener.initialize(this);
		}

		public function dispose():void {
			for each(var entity:Entity in entities) {
				removeEntity(entity);
			}
			onEnterFrame();
			if (this.main) {
				main.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				accelerometer.removeEventListener(AccelerometerEvent.UPDATE, updateAccelerometer);
				this.main = null;
			}
			if(_timer){
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER, updateDt);
			}
			worldListeners = new <IWorldListener>[];
		}


		private var _intervalId:uint;

		private var _timer:Timer;

		public function initialize(main:DisplayObjectContainer):void {
			dispose();
			this.main = main;
			main.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			_timer = new Timer(1000 / 30);
			_timer.addEventListener(TimerEvent.TIMER, updateDt);
			_timer.start();
			_updateDt = getTimer();
			accelerometer.addEventListener(AccelerometerEvent.UPDATE, updateAccelerometer);
			updateAccelerometerData();
			clearInterval(_intervalId);
			if (Capabilities.isDebugger) {
				_intervalId = setInterval(updateAccelerometerData, 2000);
			}
			worldListeners = new <IWorldListener>[];
		}

		public function updateAccelerometerData():void {
			var accelerometerEvent:AccelerometerEvent = new AccelerometerEvent(AccelerometerEvent.UPDATE);
			accelerometerEvent.accelerationX = Math.random() * 2 - 1;
			accelerometerEvent.accelerationY = Math.random() * 2 - 1;
			accelerometerEvent.accelerationZ = Math.random() * 2 - 1;
			updateAccelerometer(accelerometerEvent)
		}

		private function updateAccelerometer(event:AccelerometerEvent):void {
			accelerometerVO = new AccelerometerVO();
			accelerometerVO.accelerationX = event.accelerationX;
			accelerometerVO.accelerationY = event.accelerationY;
			accelerometerVO.accelerationZ = event.accelerationZ;
			App.tf.text = "accelerationX: " + accelerometerVO.accelerationX + "\n" + "accelerationY: " + accelerometerVO.accelerationY + "\n";

		}

		private var _collideTime:uint = 0;
		private var _collideCount:uint = 0;

		public function collide(entityToCollide:HitArea, limit:int = int.MAX_VALUE):Vector.<Entity> {
			var time:uint = getTimer();
			var collidedEntities:Vector.<Entity> = collider.getCollidedEntities(entityToCollide, limit);
			_collideTime += getTimer() - time;
			_collideCount++;
			return collidedEntities;
		}

		public function isCollided(entityToCollide:HitArea):Boolean {
			return collide(entityToCollide, 1).length > 0;
		}

		private var _frameTime:uint = 0;
		private var _updateDt:uint = getTimer();


		private function updateDt(event:TimerEvent):void {
			var time:int = getTimer();
			var dt:int;
			for each(var entity:Entity in entities) {
				dt = getTimer() - _updateDt;
				entity.updateDT(Math.min(100, dt));
			}
			trace("updateDt:\t", getTimer() - time, "  \t", dt);
			_updateDt = getTimer();
			for each (var worldListener:IWorldListener in worldListeners){
				worldListener.updateDtComplete(dt);
			}
		}
		private function onEnterFrame(event:Event = null):void {
			var dt:int = getTimer() - _frameTime;
			for each(var entity:Entity in entities) {
				entity.update();
			}
			for each (var worldListener:IWorldListener in worldListeners){
				worldListener.updateComplete();
			}
			for each(var action:Entity in entities) {
				if (action is Actioner) {
					Actioner(action).action();
				}
			}
			for each(var f:Function in functions) {
				f.call();
			}
//			trace("collideTime:	", _collideTime, "collideCount:	", _collideCount, "dt:	", dt);
			_collideTime = 0;
			_collideCount = 0;
			if (dt > 16) {
				_frameTime = getTimer();
			}

		}

		public function getForEach(entityClass:Class):Array {
			var result:Array = [];
			for each(var entity:Entity in entities) {
				if (entity is entityClass) {
					result.push(entity);
				}
			}
			return result;
		}

		public function forEach(entityClass:Class, func:Function):void {
			for each(var entity:Entity in entities) {
				if (entity is entityClass) {
					func.call(null, entity);
				}
			}
		}

		public function addEntity(entity:Entity):void {
			entity.initialize();
			entities.push(entity);
//			main.addChild(entity.ani);
			for each (var worldListener:IWorldListener in worldListeners){
				worldListener.entityAdded(entity);
			}
		}

		public function removeEntity(entity:Entity):void {
			functions.push(function ():void {
				var indexOf:Number = entities.indexOf(entity);
				if (indexOf > 0) {
					entities.splice(indexOf, 1);
					entity.dispose();
					for each (var worldListener:IWorldListener in worldListeners){
						worldListener.entityRemoved(entity);
					}
				}
			});

		}
	}
}
