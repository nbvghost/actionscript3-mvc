package com.sanbeetle.component {
	
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.skin.IIConSkin;
	
	
	public class IICon extends UIComponent {
		
		public static const HZ_1:int=20;
		public static const HZ_2:int=21;
		public static const HZ_3:int=22;
		public static const HZ_4:int=23;
		public static const HZ_5:int=24;
		public static const HZ_6:int=25;
		public static const HZ_7:int=26;
		public static const HZ_8:int=27;
		public static const N:int=28;
		
		public static const VIP_1:int=1;
		public static const VIP_2:int=2;
		
		private var skin:IIConSkin;
		
		
		private var _index:int=1;
		
		public function IICon() {
			skin = new IIConSkin();
		}
		[Inspectable(defaultValue=1)]
		/**
		 * IICon.HZ_1
		 */
		public function get index():int
		{
			return _index;
		}
		public function set index(value:int):void
		{
			_index = value;			
			skin.gotoAndStop(_index);
			//Console.out("components"+skin.width,skin.height);
			//trueWidth = skin.width;
			//trueHeight = skin.height;		
			this.updateUI();
			
		}		
		override protected function updateUI():void
		{
			//trueWidth = skin.width;
			//trueHeight = skin.height;
			
			skin.x =(trueWidth-skin.width)/2;
			skin.y =(trueHeight-skin.height)/2;
			
		}
		
		override public function get height():Number
		{
			// TODO Auto Generated method stub
			return 56;
		}
		
		override public function get width():Number
		{
			// TODO Auto Generated method stub
			return 50;
		}
		
		
		override protected function createUI():void
		{
			this.addChild(skin);
			updateUI();
		}
		
	}
	
}
