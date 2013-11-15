package com.sanbeetle.component {
	import com.sanbeetle.component.child.ExtendButton;
	import com.sanbeetle.skin.TabButtonA_left_down;
	import com.sanbeetle.skin.TabButtonA_left_over;
	import com.sanbeetle.skin.TabButtonA_left_up;
	import com.sanbeetle.skin.TabButtonA_mid_down;
	import com.sanbeetle.skin.TabButtonA_mid_over;
	import com.sanbeetle.skin.TabButtonA_mid_up;
	import com.sanbeetle.skin.TabButtonA_right_down;
	import com.sanbeetle.skin.TabButtonA_right_over;
	import com.sanbeetle.skin.TabButtonA_right_up;
	
	
	
	
	public class ITabButtonA extends ITabButton {
		
		
		public function ITabButtonA() {
			// constructor code
		}
		
		override protected function createLeftButton():ExtendButton
		{
			// TODO Auto Generated method stub
			return new ExtendButton(new TabButtonA_left_up,new TabButtonA_left_over,new TabButtonA_left_down);
		}
		
		override protected function createMidButton():ExtendButton
		{
			// TODO Auto Generated method stub
			return new ExtendButton(new TabButtonA_mid_up,new TabButtonA_mid_over,new TabButtonA_mid_down);
		}
		
		override protected function createRightButton():ExtendButton
		{
			// TODO Auto Generated method stub
			return new ExtendButton(new TabButtonA_right_up,new TabButtonA_right_over,new TabButtonA_right_down);
		}
		
	}
	
}
