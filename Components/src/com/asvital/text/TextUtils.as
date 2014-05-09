package com.asvital.text
{
	import flash.text.StyleSheet;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	
	public class TextUtils
	{
		private static const cacheStyle:Object = new Object();
		public function TextUtils()
		{
			
		}
		public static function getTextForm(styleName:String,styleSheet:StyleSheet,fixName:String=null):Object{
			
			if(styleName==null || styleName=="undefined" || styleName=="null"){
				return null;
			}
			
			if(cacheStyle[styleName+":"+fixName]!=undefined){
				
				return cacheStyle[styleName+":"+fixName];
			}
			
			var tf:Object={};
			var cu:Object;
			var key:String;
			
			if(fixName=="link" || fixName=="" || fixName==null){				
				cu = styleSheet.getStyle(styleName);
				for(key in cu ){
					tf[key] = cu[key];
				}
				
				cu = styleSheet.getStyle(styleName+":link");
				for(key in cu ){
					tf[key] = cu[key];
				}
				
			}else if(fixName=="hover"){				
				
				cu = styleSheet.getStyle(styleName+":hover");
				for(key in cu ){
					tf[key] = cu[key];
				}
				
			}else if(fixName=="active"){
				cu = styleSheet.getStyle(styleName+":active");
				for(key in cu ){
					tf[key] = cu[key];
				}
			}
			
			
			cacheStyle[styleName+":"+fixName] = tf;
			
			return tf;
		}
		public static function GetTextFormFix(styleName:String,styleSheet:StyleSheet,fixName:String=null):Object{
			
			return getTextForm("."+styleName,styleSheet,fixName);
			
		}
		public static function Style2ElementFormat(elementFormat:ElementFormat,textFormat:Object):ElementFormat{
			
			if(elementFormat==null){
				return elementFormat;
			}
		
			elementFormat.color = textFormat.hasOwnProperty("color")?uint(String(textFormat.color).replace("#","0x")):elementFormat.color;
			elementFormat.fontSize = textFormat.hasOwnProperty("fontSize")?textFormat.fontSize:elementFormat.fontSize;
			
			var copyFontDes:FontDescription;
			
			if(elementFormat.fontDescription){
				if(elementFormat.fontDescription.locked){
					 copyFontDes = elementFormat.fontDescription.clone();
					
				}
			}else{
				copyFontDes = new FontDescription();
			}			
			copyFontDes.fontWeight = textFormat.hasOwnProperty("fontWeight")?textFormat.fontWeight:copyFontDes.fontWeight;
			
			//copyFontDes.cffHinting = CFFHinting.HORIZONTAL_STEM;
			
			elementFormat.fontDescription = copyFontDes;
			return elementFormat;
		}
		
	}
}