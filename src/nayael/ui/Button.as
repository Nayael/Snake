package nayael.ui 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
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
		public function Button() {
			var background:Shape = new Shape(),
				text:Text = new Text('Play', 'Arial', 16, 0x000000, true);
			background.graphics.beginFill(0xCCCCCC);
			background.graphics.drawRect(0, 0, 100, 40);
			background.graphics.endFill();
			addChild(background);
			
			text.hCenter(background);
			text.vCenter(background);
			addChild(text);
		}
		
	////////////////////////
	// METHODS
	//
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
		
	////////////////////////
	// GETTERS & SETTERS
	//
		
	}
	
}