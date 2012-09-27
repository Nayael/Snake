package nayael.utils
{	
	/**
	 * Interface for any element displayed for the game Wizards Of 1990
	 * @author Nayael
	 */
	public interface IDisplayObject {
		/**
		 * Positions the object on the stage
		 * @param	xPos	The position on the X axis 
		 * @param	yPos	The position on the Y axis
		 */ 
		function pos(xPos:Number, yPos:Number):void;
		
		/**
		 * Centers the object on the X axis
		 * @param	pParent	The object to center to
		 */
		function hCenter(pParent:*):void;
		
		/**
		 * Removes the object from the stage
		 */
		function remove():void;
	}
}