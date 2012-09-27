package nayael.utils
{
	import flash.display.Stage;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * A label text field
	 * @author Nayael
	 */
	public class Text extends TextField implements IDisplayObject{
		
	////////////////////////
	// PROPERTIES
	//
		
	////////////////////////
	// CONSTRUCTOR
	//
		/** [Constructor]
		 * A label text field
		 * @param	initText Le texte
		 * @param	font La police du texte
		 * @param	size La taille du texte
		 * @param	color La couleur du texte\n0xFF0000 est le rouge, 0x00FF00 est le vert, etc.
		 * @param	bold Indique si le texte est en gras ou non
		 * @param	italic Indique si le texte est en italique ou non
		 */
		public function Text(initText:String, font:String = 'Arial', size:int = 24, color:Object = 0xFFFFFF, bold:Boolean = false, italic:Boolean = false) {
			text = initText;
			var textFormat:TextFormat = new TextFormat(font, size, color, bold, italic);
			textFormat.align = TextFormatAlign.LEFT;
			this.autoSize = TextFieldAutoSize.LEFT;
			this.antiAliasType = AntiAliasType.ADVANCED;
			this.setTextFormat(textFormat);
			this.selectable = false;
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