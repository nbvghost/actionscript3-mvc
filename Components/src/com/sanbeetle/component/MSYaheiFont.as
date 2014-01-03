package com.sanbeetle.component  {
	
	import flash.display.MovieClip;
	import flashx.textLayout.compose.ISWFContext;
	
	
	public class MSYaheiFont extends MovieClip implements ISWFContext {
		
		
		public function MSYaheiFont() {
			// constructor code
		}
		
		public function callInContext(fn:Function, thisArg:Object, argArray:Array, returns:Boolean=true):*
		{
			if (returns)
				return fn.apply(thisArg, argArray);
			fn.apply(thisArg, argArray);
		}
	}
	
}
