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
	import com.sanbeetle.skin.IICon_N;
	import com.sanbeetle.skin.IICon_VIP1;
	import com.sanbeetle.skin.IICon_VIP2;
	import com.sanbeetle.skin.IICon_VIP3;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	
	
	public class IICon extends UIComponent {
		
		public static const HZ_1:BitmapData=new IICon_HZ1;
		public static const HZ_2:BitmapData=new IICon_HZ2;
		public static const HZ_3:BitmapData=new IICon_HZ3;
		public static const HZ_4:BitmapData=new IICon_HZ4;
		public static const HZ_5:BitmapData=new IICon_HZ5;
		public static const HZ_6:BitmapData=new IICon_HZ6;
		public static const HZ_7:BitmapData=new IICon_HZ7;
		public static const HZ_8:BitmapData=new IICon_HZ8;
		public static const N:BitmapData=new IICon_N;
		
		public static const VIP_1:BitmapData=new IICon_VIP1;
		public static const VIP_2:BitmapData=new IICon_VIP2;
		public static const VIP_3:BitmapData = new IICon_VIP3;
		
		
		private var _icons:Array = [];		
		
		private var _index:int =0;
		
		
		
		private var bitMapData:BitmapData;
		private var bitMap:Bitmap;
		private var dis:Array = [];
		public function IICon() {
			bitMap=new Bitmap();
			bitMapData = new BitmapData(16,16,false,0xff0000);
			bitMap.bitmapData = bitMapData;
			this.addChild(bitMap);
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
		
		public function get icons():Array{
			return _icons;
		}
		
		public function set icons(value:Array):void{
			_icons =value;
			
			if(_icons==null){
				
				_icons = [];
				
				bitMapData = new BitmapData(16,16,true,0xff0000);
				bitMap.bitmapData = bitMapData;
			}			
			
			for(var i:int=0;i<_icons.length;i++){
				push(_icons[i]);
			}
		}
		private var w:int=0;
		private var maxH:int = 0;
		/**
		 * 
		 * @param index IICon 静态属性
		 * 
		 */		
		private function push(index:BitmapData):void{
			/*	if(_icons.indexOf(index)!=-1){
			return;
			}*/
			//_icons.push(index);			
			w = w+index.width;			
			maxH = Math.max(maxH,index.height);	
			
			drawIcon();
		}
		private function drawIcon():void{			
			
			bitMapData = new BitmapData(w+(_icons.length*2),maxH,true,0xffff00);			
			
			var xx:int = 0;
			
			for(var i:int=0;i<_icons.length;i++){
				
				var cut:BitmapData = _icons[i];
				
				
				
				
				var mxx:Matrix = new Matrix();
				mxx.translate(xx,0);
				bitMapData.draw(cut,mxx);		
				bitMap.bitmapData = bitMapData;				
				xx=xx+cut.width+2;
			}	
		}
		override public function updateUI():void
		{
			//trueWidth = skin.width;
			//trueHeight = skin.height;
			
			//skin.x =(trueWidth-skin.width)/2;
			//skin.y =(trueHeight-skin.height)/2;
			
		}
		
		override public function get height():Number
		{
			// TODO Auto Generated method stub
			return bitMap.height;
		}
		
		override public function get width():Number
		{
			// TODO Auto Generated method stub
			return bitMap.width;
		}
		
		
		override public function createUI():void
		{
			//this.addChild(skin);
			updateUI();
		}
		
	}
	
}
