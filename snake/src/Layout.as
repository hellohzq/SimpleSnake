package
{
	
	import flash.display.Sprite;
	import flash.events.*;
	import flash.utils.Timer;
	
	/**
	 *  @author bigbigdotnet.cnblogs.com Date: 2010-8-19
	 *
	 */
	public class Layout extends Sprite
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
		
		public function Layout()
		{
			super();	
			
			if(stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE,onADDEDHandler);
					
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
		private var db:DisplayBoard;
		private var map:Array 			= [];	//地图数组
		private var snakeList:Array 	= [];	//贪吃蛇数组
		private var timer:Timer;				//定时器，让贪吃蛇移动
		private var snakeFood:Snake;			//食物
		private var direct:String		= Config.DIRECT_RIGHT;	//按键方向
		private var snakeFoodCount:int;		//被吃掉的食物记数
		private var mk:Mask					//游戏暂停时候的界面遮罩
		private var isDead:Boolean;			//是否游戏结束
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
		private function init():void{		
			
			
			//加载显示面板
			db = new DisplayBoard();
			addChild(db);			
			db.y = -20;
			db.addEventListener("GameStatusChange",GameStatusChangeHandler);
			
			//创建地图	
			createMap();			
			
			//加载蛇头
			var snakeHead:Snake = new Snake();
			addChild(snakeHead);
			snakeList.push(snakeHead);
			
			//加载食物
			createSnakeFood();
			
			//定时器，移动贪吃蛇
			timer = new Timer(Config.SNAKE_SPEED_LEVEL0);
			timer.addEventListener(TimerEvent.TIMER,onTimerHandler);
			//timer.start();		
			
			//加载游戏暂停时候的遮罩效果
			mk = new Mask();
			addChild( mk );
			mk.visible = true;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDownHandler);
		}
		
		private function createMap():void{
			for(var i:int=0;i<Config.GRID_X_NUMBER;i++)
			{
				map.push( new Array() );
				for(var j:int=0;j<Config.GRID_Y_NUMBER;j++)
				{
					var box:Grid = new Grid();
					addChild(box);
					box.x = i * Config.GRID_WIDTH;
					box.y = j * Config.GRID_WIDTH;
					map[i].push( box );				
				}
			}		
		}
		
		private function createSnakeFood():void{	
			var xx:int = Math.random() * Config.GRID_X_NUMBER;
			var yy:int = Math.random() * Config.GRID_Y_NUMBER;
			var grid:Grid = map[xx][yy];
			snakeFood = new Snake();
			addChild(snakeFood);
			snakeFood.color = Config.SNAKE_FOOD_COLOR;
			snakeFood.draw();			
			snakeFood.x = grid.x;
			snakeFood.y = grid.y;			
		}
		
		private function setSnakeSpeed(snakeFoodCount:int):void{
			switch(snakeFoodCount){
				case Config.SNAKE_FOOD_LEVEL0:	
					db.setLEVEL( Config.SNAKE_FOOD_LEVEL0 );
					timer.stop();
					timer = new Timer(Config.SNAKE_SPEED_LEVEL0);
					timer.addEventListener(TimerEvent.TIMER,onTimerHandler);
					timer.start();
					break;
				case Config.SNAKE_FOOD_LEVEL1:	
					db.setLEVEL( Config.SNAKE_FOOD_LEVEL1 );
					timer.stop();
					timer = new Timer(Config.SNAKE_SPEED_LEVEL1);
					timer.addEventListener(TimerEvent.TIMER,onTimerHandler);
					timer.start();
					break;
				case Config.SNAKE_FOOD_LEVEL2:		
					db.setLEVEL( Config.SNAKE_FOOD_LEVEL2 );
					timer.stop();
					timer = new Timer(Config.SNAKE_SPEED_LEVEL2);
					timer.addEventListener(TimerEvent.TIMER,onTimerHandler);
					timer.start();
					break;
				case Config.SNAKE_FOOD_LEVEL3:
					db.setLEVEL( Config.SNAKE_FOOD_LEVEL3 );
					timer.stop();
					timer = new Timer(Config.SNAKE_SPEED_LEVEL3);
					timer.addEventListener(TimerEvent.TIMER,onTimerHandler);
					timer.start();
					break;
				case Config.SNAKE_FOOD_LEVEL4:
					db.setLEVEL( Config.SNAKE_FOOD_LEVEL4 );
					timer.stop();
					timer = new Timer(Config.SNAKE_SPEED_LEVEL4);
					timer.addEventListener(TimerEvent.TIMER,onTimerHandler);
					timer.start();
					break;
				case Config.SNAKE_FOOD_LEVEL5:
					db.setLEVEL( Config.SNAKE_FOOD_LEVEL5 );	
					timer.stop();
					timer = new Timer(Config.SNAKE_SPEED_LEVEL5);
					timer.addEventListener(TimerEvent.TIMER,onTimerHandler);
					timer.start();
					break;
				case Config.SNAKE_FOOD_LEVEL6:
					db.setLEVEL( Config.SNAKE_FOOD_LEVEL6 );	
					timer.stop();
					timer = new Timer(Config.SNAKE_SPEED_LEVEL6);
					timer.addEventListener(TimerEvent.TIMER,onTimerHandler);
					timer.start();
					break;
				case Config.SNAKE_FOOD_LEVEL7:
					db.setLEVEL( Config.SNAKE_FOOD_LEVEL7 );	
					timer.stop();
					timer = new Timer(Config.SNAKE_SPEED_LEVEL7);
					timer.addEventListener(TimerEvent.TIMER,onTimerHandler);
					timer.start();
					break;
				default:
					break;		
				
			}				
		}
		
		private function moveSnake(xHead:int=0,yHead:int=0):void{	
			//判断贪吃蛇吃食物的处理
			if( snakeList[0].x == snakeFood.x && snakeList[0].y == snakeFood.y )
			{
				//被吃掉的食物，做变色处理，变成蛇身颜色
				snakeFood.color = Config.SNAKE_BODY_COLOR;
				snakeFood.draw();
				//食物计数器自增
				snakeFoodCount++;
				//升级贪吃蛇速度
				setSnakeSpeed( snakeFoodCount );
				//更新面板的显示
				db.setsnakeFoodCount( snakeFoodCount );
				//增长贪吃蛇的蛇身
				snakeList.push(snakeFood);
				//重新生成食物
				createSnakeFood();
			}
			
			//snakeList数组的成员都向蛇头方向的格子移动一位
			for(var i:int=snakeList.length-1;i>0;i--)
			{				
				if(snakeList[i])
				{					
					snakeList[i].x = snakeList[i-1].x;
					snakeList[i].y = snakeList[i-1].y;				
				}				
			}			
			
			//头部是否碰到地图边界处理，未到边界就将蛇头snakeList[0]向按键方向前移一格			
			if(snakeList[0].x >= map[Config.GRID_X_NUMBER-1][Config.GRID_Y_NUMBER-1].x && direct == Config.DIRECT_RIGHT )			
			{				
				snakeList[0].x = 0;
			}
			else if(snakeList[0].x <= 0 && direct == Config.DIRECT_LEFT )		
			{
				snakeList[0].x = map[Config.GRID_X_NUMBER-1][Config.GRID_Y_NUMBER-1].x;
			}
			else if(snakeList[0].y >= map[Config.GRID_X_NUMBER-1][Config.GRID_Y_NUMBER-1].y && direct == Config.DIRECT_DOWM )			
			{
				snakeList[0].y = 0;
			}
			else if(snakeList[0].y <= 0 && direct == Config.DIRECT_UP )		
			{
				snakeList[0].y = map[Config.GRID_X_NUMBER-1][Config.GRID_Y_NUMBER-1].y;		
			}
			else
			{
				snakeList[0].x = snakeList[0].x + xHead;
				snakeList[0].y = snakeList[0].y + yHead;
			}
			
			//检测是否吃到自己,吃到自己就游戏结束
			for(var ii:int=1;ii<snakeList.length;ii++)
			{				
				if( snakeList[0].x == snakeList[ii].x && snakeList[0].y == snakeList[ii].y )
				{					
					
					snakeList[ii].color = Config.SNAKE_HEAD_COLOR;
					snakeList[ii].draw();
										
					stop();
				}
			}
		}
		
		private function reStart():void
		{	
			isDead = false;
			//食物计数器重置为0
			snakeFoodCount = 0;
			//清除上一次放置的食物
			this.removeChild( snakeFood );
			//清除上一次的贪吃蛇
			for(var i:int=0;i<snakeList.length;i++){
				this.removeChild( snakeList[i] );				
			}
			snakeList.length = 0;
			//加载蛇头
			var snakeHead:Snake = new Snake();
			addChild(snakeHead);
			snakeList.push(snakeHead);			
			//加载食物
			createSnakeFood();			
			//设置显示面板
			db.setOnOff( Config.PAUSE );			
			db.setTimersOn();
			db.setsnakeFoodCount(0);
			db.setLEVEL();
			db.setTimers(0);
			mk.visible = mk.visible ? false  : true;
			//定时器速度重置为第一关的速度，并qidong
			timer = new Timer(Config.SNAKE_SPEED_LEVEL0);
			timer.addEventListener(TimerEvent.TIMER,onTimerHandler);
			timer.start();
		}		
		private function stop():void{
			isDead = true;
			timer.stop();
			db.setOnOff( Config.START );
			db.setTimersOff();
			mk.visible = mk.visible ? false  : true;			
			mk.tf.htmlText = "<font size=\"40\" >Game Over!</font><br/><font size=\"30\" >按空格键---重新开始！</font>" ;
		}
		private function pause():void{
			timer.stop();
			db.setOnOff( Config.START );
			db.setTimersOff();
			mk.visible = mk.visible ? false  : true;
			mk.tf.htmlText = "<font size=\"30\" >按空格键---开始/暂停！</font>";
		}
		
		private function run():void{
			timer.start();
			db.setOnOff( Config.PAUSE );			
			db.setTimersOn();
			mk.visible = mk.visible ? false  : true;
		}
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		private function onKeyDownHandler(event:KeyboardEvent):void{							
					
			switch(event.keyCode)
			{
				case 38 :		
					if(direct!=Config.DIRECT_DOWM)  direct = Config.DIRECT_UP;
					break;
				case 40 :	
					if(direct!=Config.DIRECT_UP) direct = Config.DIRECT_DOWM;
					break;
				case 37 :		
					if(direct!=Config.DIRECT_RIGHT) direct = Config.DIRECT_LEFT;
					break;
				case 39 :		
					if(direct!=Config.DIRECT_LEFT) direct = Config.DIRECT_RIGHT;
					break;
				case 32 : //如果按下的是空格键
					GameStatusChangeHandler( new MouseEvent("space") );
					break;
				default:					
					break;
			}					
		}		
		
		private function onTimerHandler(event:Event):void{
			var xSnakeHead:int;
			var ySnakeHead:int;
			switch(direct)
			{
				case Config.DIRECT_UP :					
					ySnakeHead = -Config.GRID_WIDTH;					
					break;
				case Config.DIRECT_DOWM :					
					ySnakeHead = Config.GRID_WIDTH;					
					break;
				case Config.DIRECT_LEFT :					
					xSnakeHead = -Config.GRID_WIDTH;					
					break;
				case Config.DIRECT_RIGHT :					
					xSnakeHead = Config.GRID_WIDTH;				
					break;
				default :					
					break;
			}		
			moveSnake(xSnakeHead,ySnakeHead);
		}
		
		private function onADDEDHandler(event:Event):void{
			init();
		}
		
		private function GameStatusChangeHandler(evemt:MouseEvent):void{
			
			if(isDead) 
				reStart();			
			else if(timer.running )
				pause();
			else
				run();
		}
		
		
	}
}