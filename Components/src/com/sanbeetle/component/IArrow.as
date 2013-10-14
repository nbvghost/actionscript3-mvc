package com.sanbeetle.component {
	
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.skin.IArrowSkin;
	
	
	public class IArrow extends UIComponent {
		
		private var _iconIndex:int=1;
		
		private var skin:IArrowSkin;
		
		public function IArrow() {
			
		}
		[Inspectable(defaultValue =1)]	
		public function get iconIndex():int
		{
			return _iconIndex;
		}

		public function set iconIndex(value:int):void
		{
			_iconIndex = value;
			skin.gotoAndStop(_iconIndex);
		}
		
		override protected function createUI():void
		{
			skin = new IArrowSkin();
			this.addChild(skin);
		}
		
		
	}
	
}
