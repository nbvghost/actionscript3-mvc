package com.sanbeetle.core
{
	
	public class TextBox extends TLFTextBox
	{
		
		
		private var _isRichText:Boolean = false;
		
		
		
		public function TextBox()
		{
			
			_isRichText = true;
			
			this.paddingTop = 5;
			this.paddingLeft = 2;
			this.paddingBottom =2;
			this.paddingRight = 2;
			
			
		}	
		
		public function get isRichText():Boolean
		{
			return _isRichText;
		}

		public function set isRichText(value:Boolean):void
		{
			_isRichText = value;
		}

	}
	
}


