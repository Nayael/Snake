package nayael.characters 
{
	import flash.display.Shape;
	
	/**
	 * The snake
	 * @author Nayael
	 */
	public class Snake
	{
		
	////////////////////////
	// PROPERTIES
	//
		public static const UP:String = 'up';
		public static const DOWN:String = 'down';
		public static const LEFT:String = 'left';
		public static const RIGHT:String = 'right';
		
		private static var instance:Snake;
		
		public var direction:String;
		private var _body:Array;
	
	////////////////////////
	// CONSTRUCTOR
	//
		/**
		 * The snake
		 */
		public function Snake(pSnake:SnakeSingleton) {
			if (pSnake == null) {
				throw new Error('Échec de l\'instanciation : utilisez Snake.getInstance() à la place de new.');
			}
			
			init();
		}
		
		/**
		 * Initialises the character
		 */
		public function init():void {
			direction = DOWN;
			_body = new Array();
			for (var i:int = 0; i < 3; i++) {	// We create the body
				var bit:Shape = new Shape();
				bit.graphics.beginFill(0xFFFFFF);
				bit.graphics.drawRect(0, 0, 15, 15);
				bit.graphics.endFill();
				bit.x = 195;
				bit.y = 150 - (i * 15);
				_body[i] = bit;
			}
		}
		
		public static function getInstance():Snake{
			if (instance == null) {
				instance = new Snake(new SnakeSingleton());
			}
			return instance;
		}
		
	////////////////////////
	// METHODS
	//
		/**
		 * Adds a bit to the snake's body
		 * @param	bit	The bit to add (the apple)
		 * @param	remove	The removeChild() function from the Main class
		 * @param	add	The addChild() function from the Main class
		 */
		public function eat(bit:Shape, remove:Function, add:Function):void {
			remove(bit);
			var newBit:Shape = new Shape();
			newBit.graphics.beginFill(0xFFFFFF);
			newBit.graphics.drawRect(0, 0, 15, 15);
			newBit.graphics.endFill();
			add(newBit);
			_body.push(newBit);
		}
		
		/**
		 * Moves the snake
		 */
		public function move():void {
			// First, we move the snake's head following it's direction
			var prevCoord:Array = [[_body[0].x, _body[0].y]],
				i:int = 0;
			switch (direction) {
				case DOWN:
					_body[0].y += 15;
					break;
				case UP:
					_body[0].y -= 15;
					break;
				case LEFT:
					_body[0].x -= 15;
					break;
				case RIGHT:
					_body[0].x += 15;
					break;
			}
			
			// Then, we move the rest of the body
			for each (var item:Shape in _body) {
				if (item !== _body[0]) {
					prevCoord.push([item.x, item.y]);
					item.x = prevCoord[i][0];
					item.y = prevCoord[i][1];
					i++;
				}
			}
		}
		
		/**
		 * Removes the snake's body from the stage
		 * @param	removeChild	The removeChild() function from the Main class
		 */
		public function removeFromStage(removeChild:Function):void {
			for each (var item:Shape in _body) {
				removeChild(item);
			}
		}
		
	////////////////////////
	// GETTERS & SETTERS
	//
		public function get body():Array {
			return _body;
		}
	}
}

////////////////////////
// SINGLETON CLASS
//
internal class SnakeSingleton
{
	private static var _instancied:Boolean = false;
	
	/** [Constructor]
	 * The Snake Singleton for the snake game
	 */
	public function SnakeSingleton(){
		if (_instancied) {
			throw new Error('Pattern Singleton : une seule instance est permise');
		}
		
		_instancied = true;
	}
}