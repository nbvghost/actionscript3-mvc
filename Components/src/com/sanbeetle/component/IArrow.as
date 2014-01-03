package com.sanbeetle.component {
	
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.skin.IArrowSkin;
	
	
	public class IArrow extends UIComponent {
		
		private var _iconIndex:int=1;
		
		private var skin:IArrowSkin;
		
		public function IArrow() {
			skin = new IArrowSkin();
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
		
		override public function createUI():void
		{
		
			this.addChild(skin);
		}
		
		
	}
	
}
