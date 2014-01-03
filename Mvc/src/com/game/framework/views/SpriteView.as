package com.game.framework.views {
	
	/**
	 * 一个空的视图，不需要加载任何东东。
	 *@author sixf
	 */
	public class SpriteView extends CreateView {
		public function SpriteView() {
			super();
		}
		
		override public function get needToLoad():Boolean {
			
			return false;
		}
		
	}
}