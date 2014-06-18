package com.sanbeetle.component {
	
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.skin.IICon_HZ1;
	import com.sanbeetle.skin.IICon_HZ2;
	import com.sanbeetle.skin.IICon_HZ3;
	import com.sanbeetle.skin.IICon_HZ4;
	import com.sanbeetle.skin.IICon_HZ5;
	import com.sanbeetle.skin.IICon_HZ6;
	import com.sanbeetle.skin.IICon_HZ7;
	import com.sanbeetle.skin.IICon_HZ8;
	import com.sanbeetle.skin.IICon_JB_FZ;
	import com.sanbeetle.skin.IICon_JB_LS;
	import com.sanbeetle.skin.IICon_JB_MZ;
	import com.sanbeetle.skin.IICon_JB_OZ;
	import com.sanbeetle.skin.IICon_JB_YZ;
	import com.sanbeetle.skin.IICon_N;
	import com.sanbeetle.skin.IICon_SW1;
	import com.sanbeetle.skin.IICon_SW2;
	import com.sanbeetle.skin.IICon_SW3;
	import com.sanbeetle.skin.IICon_SW4;
	import com.sanbeetle.skin.IICon_SW5;
	import com.sanbeetle.skin.IICon_SW6;
	import com.sanbeetle.skin.IICon_SW7;
	import com.sanbeetle.skin.IICon_VIP1;
	import com.sanbeetle.skin.IICon_VIP2;
	import com.sanbeetle.skin.IICon_VIP3;
	import com.sanbeetle.skin.IICon_XYD_blue;
	import com.sanbeetle.skin.IICon_XYD_diamond;
	import com.sanbeetle.skin.IICon_XYD_gold;
	import com.sanbeetle.skin.IICon_XYD_green;
	import com.sanbeetle.skin.IICon_XYD_silver;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	
	
	public class IICon extends UIComponent {
		
		private var _icons:Array = [];	
		
		private var _labels:Array = [];
		
		private var _index:int =0;
		
		
		
		
		
		private var dis:Array = [];
		public function IICon() {
			
		}

		public function get labels():Array
		{
			return _labels;
		}

		public function set labels(value:Array):void
		{
			_labels = value;
		}

		/**
		 *  奖杯 亚洲
		 * @return 
		 * 
		 */		
		public static function get JB_YZ():BitmapData{
			return new IICon_JB_YZ;
		}
		/**
		 * 奖杯 欧洲 
		 * @return 
		 * 
		 */		
		public static function get JB_OZ():BitmapData{
			return new IICon_JB_OZ;
		}
		/**
		 * 奖杯  
		 * @return 
		 * 
		 */		
		public static function get JB_MZ():BitmapData{
			return new IICon_JB_MZ;
		}
		/**
		 *  奖杯  联赛
		 * @return 
		 * 
		 */		
		public static function get JB_LS():BitmapData{
			return new IICon_JB_LS;
		}
		/**
		 * 奖杯  非洲 
		 * @return 
		 * 
		 */		
		public static function get JB_FZ():BitmapData{
			return new IICon_JB_FZ;
		}
		/**
		 *  声望
		 * @return 
		 * 
		 */		
		public static function get SW1():BitmapData{
			return new IICon_SW1;
		}
		/**
		 * 声望 
		 * @return 
		 * 
		 */		
		public static function get SW2():BitmapData{
			return new IICon_SW2;
		}
		/**
		 * 声望 
		 * @return 
		 * 
		 */	
		public static function get SW3():BitmapData{
			return new IICon_SW3;
		}
		/**
		 * 声望 
		 * @return 
		 * 
		 */	
		public static function get SW4():BitmapData{
			return new IICon_SW4;
		}
		/**
		 * 声望 
		 * @return 
		 * 
		 */	
		public static function get SW5():BitmapData{
			return new IICon_SW5;
		}
		public static function get SW6():BitmapData{
			return new IICon_SW6;
		}
		public static function get SW7():BitmapData{
			return new IICon_SW7;
		}
		public static function get VIP_3():BitmapData
		{
			return new IICon_VIP3;
		}
		/**
		 * 稀有度
		 * @return 
		 * 
		 */		
		public static function get XYD_silver():BitmapData{
			return new IICon_XYD_silver;
		}
		/**
		 * 稀有度
		 * @return 
		 * 
		 */		
		public static function get XYD_diamond():BitmapData{
			return new IICon_XYD_diamond;
		}
		/**
		 * 稀有度
		 * @return 
		 * 
		 */		
		public static function get XYD_green():BitmapData{
			return new IICon_XYD_green;
		}
		/**
		 * 稀有度
		 * @return 
		 * 
		 */		
		public static function get XYD_blue():BitmapData{
			return new IICon_XYD_blue;
		}
		/**
		 * 稀有度
		 * @return 
		 * 
		 */		
		public static function get XYD_gold():BitmapData{
			return new IICon_XYD_gold;
		}
		
		public static function get VIP_2():BitmapData
		{
			return new IICon_VIP2;
			
		}		
		public static function get VIP_1():BitmapData
		{
			return new IICon_VIP1;
		}
		
		public static function get N():BitmapData
		{
			return new IICon_N;
		}
		
		public static function get HZ_8():BitmapData
		{
			return new IICon_HZ8;
		}
		
		public static function get HZ_7():BitmapData
		{
			return new IICon_HZ7;
		}
		
		public static function get HZ_6():BitmapData
		{
			return new IICon_HZ6;
		}
		
		public static function get HZ_5():BitmapData
		{
			return new IICon_HZ5;
		}
		
		public static function get HZ_4():BitmapData
		{
			return new IICon_HZ4;
		}
		
		public static function get HZ_3():BitmapData
		{
			return new IICon_HZ3;
		}
		
		public static function get HZ_2():BitmapData
		{
			return new IICon_HZ2;
		}
		
		public static function get HZ_1():BitmapData
		{
			return new IICon_HZ1;
		}
		
		[Deprecated(message="这个不在使用了")]
		public function get index():int
		{
			return _index;
		}
		
		public function set index(value:int):void
		{
			_index = value;
		}
		
		override public function dispose():void
		{
			// TODO Auto Generated method stub
			super.dispose();
			
			for(var i:int=0;i<_icons.length;i++){
				
				var cut:BitmapData = _icons[i];				
				cut.dispose();
				cut =null;
			}	
			
				
			_icons.splice(0,_icons.length);
		}
		
		
		public function get icons():Array{
			return _icons;
		}
		
		
		public function set icons(value:Array):void{
			w=0;
			if(_icons){
				_icons.splice(0,_icons.length);
			}
			_icons =value;
			
			if(_icons==null){
				
				_icons = [];
				
				this.removeChildren();
				
			}			
			
			for(var i:int=0;i<_icons.length;i++){
				push(_icons[i]);
			}
			this.removeChildren();
			drawIcon();
			
		}
		private var w:int=0;
		private var maxH:int = 0;
		/**
		 * 
		 * @param index IICon 静态属性
		 * 
		 */		
		private function push(bder:BitmapData):void{
			
			w = w+bder.width;			
			maxH = Math.max(maxH,bder.height);				
			
		}
		private function drawIcon():void{			
			
						
			var xx:int = 0;
			
			for(var i:int=0;i<_icons.length;i++){
				
				var cut:BitmapData = _icons[i];
				
				
				var bimap:Bitmap = new Bitmap(cut);
				
				var dispaly:UIComponent = new UIComponent();
				dispaly.graphics.beginFill(0xff0000,0);
				dispaly.graphics.drawRect(0,0,cut.width,cut.height);
				dispaly.graphics.endFill();
				
				
				dispaly.addChild(bimap);
				dispaly.mouseChildren = false;
				this.addChild(dispaly);
				dispaly.toolTip = _labels[i];
				dispaly.x = xx;
				xx=xx+cut.width+2;
				
				dispaly.y = (maxH-cut.height);
				
				//trace(dispaly.width,dispaly.height);
			}	
			
		}
		override protected function updateUI():void
		{
			//trueWidth = skin.width;
			//trueHeight = skin.height;
			
			//skin.x =(trueWidth-skin.width)/2;
			//skin.y =(trueHeight-skin.height)/2;
			
		}
		
		override public function get height():Number
		{
			// TODO Auto Generated method stub
			return maxH;
		}
		
		override public function get width():Number
		{
			
			return w;
		}
		
		
		override public function createUI():void
		{
			//this.addChild(skin);
			updateUI();
		}
		
	}
	
}
