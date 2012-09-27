package nayael
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import mx.core.FlexSimpleButton;
	import nayael.ui.Button;
	
	import nayael.utils.Text;
	
	/**
	 * The main class for the snake game
	 * @author Nayael
	 */
	public class Main extends Sprite {
	
	////////////////////////
	// PROPERTIES
	//
		private var _textFields:Array;
	
	////////////////////////
	// CONSTRUCTOR
	//
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
	////////////////////////
	// METHODS
	//
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// The texts on the main menu
			_textFields = new Array(new Text('The Snake', 24, 0xFFFFFF, true), new Text('By Nayael', 10));
			_textFields[0].hCenter(stage);
			_textFields[0].y = 50;
			this.addChild(_textFields[0]);
			_textFields[1].pos(10, 270);
			this.addChild(_textFields[1]);
			
			// The button to launch the game
			var startBt:Button = new Button();
			startBt.hCenter(stage);
			startBt.y = 170;
			this.addChild(startBt);
			startBt.addEventListener(MouseEvent.CLICK, startGame);
		}
		
		/**
		 * Starts the game
		 * @param	e	MouseEvent_CLICK
		 */
		private function startGame(e:MouseEvent):void {
			removeChild(e.currentTarget as DisplayObject);
			removeChild(_textFields[0]);
			removeChild(_textFields[1]);
		}
		
	////////////////////////
	// GETTERS & SETTERS
	//
		
	}
	
}