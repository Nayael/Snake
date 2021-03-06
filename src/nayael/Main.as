package nayael
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.ui.Keyboard;
	
	import nayael.characters.Snake;
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
		private var _textFields:Vector.<Text>;
		private var _mainTimer:Timer;
		private var _snake:Snake;
	
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
			
			_mainTimer = new Timer(150);
			
			// We create the snake instance
			_snake = Snake.getInstance();
			
			// The texts on the main menu
			_textFields = new Vector.<Text>(2, true);
			_textFields[0] = new Text('The Snake', 24, 0xFFFFFF, true);
			_textFields[1] = new Text('By Nayael', 10);
			_textFields[0].hCenter(stage);
			_textFields[0].y = 50;
			this.addChild(_textFields[0]);
			_textFields[1].pos(10, 270);
			this.addChild(_textFields[1]);
			
			// The button to launch the game
			var startBt:Button = new Button('Play');
			startBt.hCenter(stage);
			startBt.y = 170;
			this.addChild(startBt);
			startBt.addEventListener(MouseEvent.CLICK, startGame);
		}
		
		/**
		 * Starts the game
		 * @param	e	MouseEvent.CLICK
		 */
		private function startGame(e:MouseEvent = null):void {
			if (e != null) {					
				removeChild(e.currentTarget as DisplayObject);
				removeChild(_textFields[0]);
				removeChild(_textFields[1]);
			}
			
			// We create the snake's body
			for each (var item:Shape in _snake.body) {
				addChild(item);
			}
			addApple();	// We add the first apple for the snake to eat
			
			stage.focus = null;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_mainTimer.addEventListener(TimerEvent.TIMER, gameLoop);
			_mainTimer.start();
		}
		
		/**
		 * Handles a key press (moves the snake)
		 * @param	e	KeyboardEvent.KEY_DOWN
		 */
		private function onKeyDown(e:KeyboardEvent):void {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			if ((e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.RIGHT) && (_snake.direction == Snake.DOWN || _snake.direction == Snake.UP)) {
				_snake.direction = (e.keyCode == Keyboard.LEFT) ? Snake.LEFT: Snake.RIGHT;
			}else if ((e.keyCode == Keyboard.UP || e.keyCode == Keyboard.DOWN) && (_snake.direction == Snake.LEFT || _snake.direction == Snake.RIGHT)) {
				_snake.direction = (e.keyCode == Keyboard.UP) ? Snake.UP: Snake.DOWN;
			}
		}
		
		/**
		 * Reactivates the key press
		 * @param	e	KeyboardEvent.KEY_UP
		 */
		private function onKeyUp(e:KeyboardEvent):void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		/**
		 * The main game loop
		 * @param	e	TimerEvent.TIMER
		 */
		private function gameLoop(e:TimerEvent):void {
			// If the snake's head touches the apple
			if (getChildAt(numChildren - 1).hitTestPoint(_snake.body[0].x + 7.5, _snake.body[0].y + 7.5)) {
				_snake.eat(getChildAt(numChildren - 1) as Shape, removeChild, addChild);
				addApple();
			}
			
			// We check if the snake's head touches an other part of the snake
			for each (var item:Shape in _snake.body) {
				if (item != _snake.body[0] && _snake.body[0].x == item.x && _snake.body[0].y == item.y) {
					stopGame();
				}
			}
			
			// If the snake's head goes out of the stage, the player loses
			if (_snake.body[0].x < 0 || _snake.body[0].x >= stage.stageWidth - 10 || _snake.body[0].y < 0 || _snake.body[0].y > stage.stageHeight) {
				stopGame();
			}
			
			_snake.move();
		}
		
		/**
		 * Adds an apple for the snake to eat
		 */
		private function addApple():void {
			var apple:Shape = new Shape();
			apple.graphics.beginFill(0xFFFFFF);
			apple.graphics.drawRect(0, 0, 15, 15);
			apple.graphics.endFill();
			
			// Randomly position the apple
			var randomX:Number = (0 + Math.random() * ((int(stage.stageWidth / 15) - 1) * 15)),
				randomY:Number = (0 + Math.random() * ((int(stage.stageHeight / 15) - 1) * 15)),
				appleX:int = int(randomX / 15) * 15,
				appleY:int = int(randomY / 15) * 15;
			for (var i:int = 0, length:int = _snake.body.length; i < length; i++) {
				if (_snake.body[i].hitTestPoint(appleX, appleY)) {	// If one of the bit collides with the new positions
					randomX = (0 + Math.random() * ((Math.floor(stage.stageWidth / 15) - 1) * 15));
					randomY = (0 + Math.random() * ((Math.floor(stage.stageHeight / 15) - 1) * 15));
					appleX = int(randomX / 15) * 15;
					appleY = int(randomY / 15) * 15;
					i = 0;	// We restart the iteration, to recheck with the new coordinates
				}
			}
			apple.x = appleX;
			apple.y = appleY;
			addChild(apple);
		}
		
		/**
		 * Stops the game
		 */
		private function stopGame():void {
			_mainTimer.stop();
			var text:Text = new Text('You lose !', 24, 0xFFFFFF, true);
			text.hCenter(stage);
			text.y = 50;
			this.addChild(text);
			
			// The button to restart the game
			var restartBt:Button = new Button('Replay');
			restartBt.hCenter(stage);
			restartBt.y = 170;
			this.addChild(restartBt);
			restartBt.addEventListener(MouseEvent.CLICK, restartGame);
			
			/**
			 * Restarts the game
			 * @param	e	MouseEvent.CLICK
			 */
			function restartGame(e:MouseEvent):void {
				restartBt.removeEventListener(MouseEvent.CLICK, restartGame);
				
				// We remove everything from the stage
				restartBt.remove();
				text.remove();
				removeChild(getChildAt(numChildren - 1));
				_snake.removeFromStage(removeChild);
				
				_snake.init();
				startGame();
			}
		}
	}
}