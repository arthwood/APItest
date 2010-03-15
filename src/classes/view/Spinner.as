package view {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Spinner extends MovieClip {
		public var speed = 5;
		
		public function Spinner() {
			visible = false;
		}
		
		public function spin():void {
			addEventListener(Event.ENTER_FRAME, onEF);
			visible = true;
		}
		
		public function unspin():void {
			removeEventListener(Event.ENTER_FRAME, onEF);
			visible = false;
		}
		
		private function onEF(e_:Event):void {
			rotation += speed;
		}
	}
}