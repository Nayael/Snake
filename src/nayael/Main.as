package nayael
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * The main class for the snake game
	 * @author Nayael
	 */
	public class Main extends Sprite {
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		}
		
	}
	
}