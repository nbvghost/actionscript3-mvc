package com.sanbeetle.core
{
	
	public class TextBox extends NormalTextBox
	{
		
		
		private var _isRichText:Boolean = false;
		
		
		
		public function TextBox()
		{
			
			_isRichText = false;
			
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


