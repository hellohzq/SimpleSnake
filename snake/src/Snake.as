package
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.events.EventDispatcher;
	import flash.utils.Timer;
	
	
	/**
	 *  @author Administrator Date: 2010-8-19
	 *
	 */
	public class Snake extends Sprite
	{
		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.
		 */
		
		public function Snake()
		{
			super();			
			
			draw();			
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 *  
		 */		
		public var color:uint = Config.SNAKE_HEAD_COLOR;
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		
		//----------------------------------
		//  property
		//----------------------------------
		/**
		 *  @private
		 */
		
		
		
		//--------------------------------------------------------------------------
		//
		//  override Methods
		//
		//--------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		public function draw():void{
			graphics.beginFill(color,0.7);
			//graphics.drawRect(0,0,Config.GRID_WIDTH,Config.GRID_WIDTH);
			graphics.drawCircle(0,0,Config.GRID_WIDTH/2);
			graphics.endFill();
		}		
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------	
				
	}
}