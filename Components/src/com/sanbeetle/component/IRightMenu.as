package com.sanbeetle.component {
	
	import com.sanbeetle.skin.IListBox;
	
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	
	
	public class IRightMenu extends IListBox {
		
		
		public function IRightMenu() {
			
		}
		
		override protected function createUI():void
		{
			// TODO Auto Generated method stub
			super.createUI();
			filters=[new DropShadowFilter(1, 60, 0x000000, 0.3, 10, 10, 1,BitmapFilterQuality.LOW, false, false)];
		}
		
	}
	
}
