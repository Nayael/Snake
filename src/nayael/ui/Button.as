package nayael.ui 
{
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import nayael.utils.IDisplayObject;
	import nayael.utils.Text;
	
	/**
	 * 
	 * @author Nayael
	 */
	public class Button extends Sprite implements IDisplayObject {
		
	////////////////////////
	// PROPERTIES
	//
		
	////////////////////////
	// CONSTRUCTOR
	//
		public function Button(pText:String) {
			var background:Shape = new Shape(),
				line:Shape = new Shape(),
				text:Text = new Text(pText, 16, 0x000000, true);
			background.graphics.beginFill(0xAAAAAA);
			background.graphics.drawRect(0, 0, 100, 40);
			background.graphics.endFill();
			addChild(background);
			
			line.graphics.lineStyle(3, 0xEEEEEE);
			line.graphics.lineTo(100, 0);
			line.graphics.lineTo(100, 40);
			line.graphics.lineTo(0, 40);
			line.graphics.lineTo(0, 0);
			addChild(line);
			
			text.hCenter(background);
			text.vCenter(background);
			addChild(text);
			
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
	////////////////////////
	// METHODS
	//
		private function onMouseOver(e:MouseEvent):void {
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			var background:Shape = new Shape();
			background.graphics.beginFill(0xCCCCCC);
			background.graphics.drawRect(0, 0, 100, 40);
			background.graphics.endFill();
			removeChildAt(0);
			addChildAt(background, 0);
		}
		
		private function onMouseOut(e:MouseEvent):void {
			this.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			var background:Shape = new Shape();
			background.graphics.beginFill(0xAAAAAA);
			background.graphics.drawRect(0, 0, 100, 40);
			background.graphics.endFill();
			removeChildAt(0);
			addChildAt(background, 0);
		}
		
		private function onMouseDown(e:MouseEvent):void {
			var background:Shape = new Shape();
			background.graphics.beginFill(0x888888);
			background.graphics.drawRect(0, 0, 100, 40);
			background.graphics.endFill();
			removeChildAt(0);
			addChildAt(background, 0);
		}
		
		////////////////////////
		// IDisplayObject methods
		/**
		 * Positions the object on the stage
		 * @param	xPos	The position on the X axis 
		 * @param	yPos	The position on the Y axis
		 */ 
		public function pos(xPos:Number, yPos:Number):void {
			this.x = xPos;
			this.y = yPos;
		}
		
		/**
		 * Centers the object on the X axis
		 * @param	pParent	The object to center to
		 */
		public function hCenter(pParent:*):void {
			if (pParent is Stage) {
				this.x = pParent.stageWidth / 2 - this.width / 2;
			}else {
				this.x = pParent.width / 2 - this.width / 2;
			}
		}
		
		/**
		 * Centers the object on the Y axis
		 * @param	pParent	The object to center to
		 */
		public function vCenter(pParent:*):void {
			if (pParent is Stage) {
				this.y = pParent.stageHeight / 2 - this.height / 2;
			}else {
				this.y = pParent.height / 2 - this.height / 2;
			}
		}
		
		/**
		 * Removes the object from the stage
		 */
		public function remove():void {
			this.parent.removeChild(this);
		}
	}
}