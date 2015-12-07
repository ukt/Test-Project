/**
 * Created by hsavenko on 12/7/2015.
 */
package app.game {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class SpeedDemonstration extends Sprite{
		public function SpeedDemonstration() {
			addEventListener(Event.ENTER_FRAME, update)
			graphics.beginFill(0x000);
			graphics.drawCircle(0,0,2);
		}

		private function update(event:Event):void {
			x+=10;
		}
	}
}
