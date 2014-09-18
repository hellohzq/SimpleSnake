package
{
	import flash.accessibility.Accessibility;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.events.EventDispatcher;
	import flash.text.TextField;
	import flash.utils.Timer;

	/**
	 *  @author Administrator Date: 2010-8-21
	 *
	 */
	public class DisplayBoard extends Sprite
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
		
		public function DisplayBoard()
		{
			super();
			
			
			//定时器，计算游戏时间
			//timerGameTime = new Timer(1000);
			timerGameTime.addEventListener(TimerEvent.TIMER,onGameTimeHandler);
			
			
			txtFood = new TextField();
			addChild(txtFood);			
				
			txtLEVEL = new TextField();
			addChild(txtLEVEL);
			txtFood.x = 100;

			txtTimes = new TextField();
			addChild(txtTimes);
			txtTimes.x = 200;
			
			var sp:Sprite = new Sprite();			
			txtSetOnOff = new TextField();	
			txtSetOnOff.border = true;
			txtSetOnOff.width = 42;
			txtSetOnOff.height = 18;
			txtSetOnOff.background = true;
			txtSetOnOff.backgroundColor = 0xffffff;
			sp.addChild(txtSetOnOff);
			addChild( sp );
			sp.buttonMode = true;
			sp.mouseChildren = false;
			sp.x = 300;
			sp.addEventListener(MouseEvent.CLICK,onClickHandler);
			
			///加载游戏说明
			var txtHelp:TextField = new TextField();
			addChild(txtHelp);
			txtHelp.y = 420;
			txtHelp.multiline = true;
			txtHelp.width = 400;
			
			txtHelp.htmlText = "游戏说明：<br/>红色方块=蛇头，绿色方块=食物，蓝色方块=蛇身。<br/>上下左右键=移动蛇头。空格键=开始/暂停<br/>可以撞墙，当蛇头吃到自己，游戏结束！看谁用时最少，吃的食物最多！<br/> QQ:196110720";
			
			setsnakeFoodCount();
			setLEVEL();
			setTimers();
			setOnOff();
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
		private var txtFood		:TextField;
		private var txtLEVEL		:TextField;
		private var txtTimes		:TextField;
		private var txtSetOnOff	:TextField;
		private var gameTimers		:int; 
		public  var timerGameTime	:Timer = new Timer(1000);//统计游戏时间
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
		public function setsnakeFoodCount(snakeFoodCount:int=0):void{
			txtFood.text = "食物："+snakeFoodCount.toString();
		}
		public function setLEVEL(LEVEL:int=10):void{
			txtLEVEL.text = "关数："+(LEVEL/10).toString() + "/8";
		}
		public function setTimers(Times:int=0):void{
			txtTimes.text = "时间："+Times;
		}
		public function setOnOff(str:String=Config.PAUSE):void{
			txtSetOnOff.text = str;
		}
		public function setTimersOff():void{
			timerGameTime.stop();
		}
		public function setTimersOn():void{
			timerGameTime.start();
		}
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		private function onGameTimeHandler(event:Event):void{
			setTimers( gameTimers++ );
		}
		
		private function onClickHandler(evemt:MouseEvent):void{
			
			dispatchEvent( new MouseEvent("GameStatusChange") );
		}
	}
}