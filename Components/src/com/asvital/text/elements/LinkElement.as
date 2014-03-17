package com.asvital.text.elements
{
	import com.asvital.text.TextUtils;
	
	import flash.text.StyleSheet;
	import flash.text.engine.ElementFormat;

	public class LinkElement extends BaseTextElement
	{
		
		
		public function LinkElement(text:String,attribs:XMLList,textformat:ElementFormat,_styleSheet:StyleSheet)
		{
			
			
			
			super(text,attribs,textformat,_styleSheet);
			
			
			/*tf=TextUtils.GetTextForm(syteArr[i],_styleSheet);					
			defaultFormat = TextUtils.Style2ElementFormat(_defaultFormat,tf);
			
			tf=TextUtils.GetTextForm(syteArr[i],_styleSheet,"hover");					
			linkHoverFormat = TextUtils.Style2ElementFormat(_linkHoverFormat,tf);
			
			tf=TextUtils.GetTextForm(syteArr[i],_styleSheet,"active");			
			linkActiveFormat = TextUtils.Style2ElementFormat(_linkActiveFormat,tf);*/
			
			
		}
		
		override protected function getDefaultStyel(attributes:Object):void
		{
			var tf:Object=TextUtils.GetTextFormFix("a",styleSheet);					
			_defaultFormat = TextUtils.Style2ElementFormat(defaultFormat,tf);
			
			_linkHoverFormat = defaultFormat.clone();
			_linkActiveFormat = defaultFormat.clone();						
			
			tf=TextUtils.GetTextFormFix("a",styleSheet,"hover");					
			_linkHoverFormat = TextUtils.Style2ElementFormat(linkHoverFormat,tf);
			
			tf=TextUtils.GetTextFormFix("a",styleSheet,"active");			
			_linkActiveFormat = TextUtils.Style2ElementFormat(linkActiveFormat,tf);
		}
		
		
	}
}