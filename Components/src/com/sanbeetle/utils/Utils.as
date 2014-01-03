package com.sanbeetle.utils
{
	import com.sanbeetle.Component;
	import com.sanbeetle.core.BoundDisplayObject;
	import com.sanbeetle.core.TextBox;
	import com.sanbeetle.model.LocationRect;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.geom.Point;
	
	import flashx.textLayout.conversion.ConversionType;
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.elements.TextFlow;
	
	/**
	 *
	 *@author sixf
	 */
	public class Utils
	{
		public function Utils()
		{
		}
		/**
		 * 个位数前面加0， 转成字符
		 * @param number
		 * @return 
		 * 
		 */
		public static function NumberPrefix(number:Number):String{
			if(number<10){
				return "0"+number;
			}else{
				return number+"";
			}
		}
		public static function  TimeDataPrefix(number:Number):String{
			var te:String=NumberPrefix(number);
			if(Number(te)==0){
				te = "--";
			}
			return te;
		}
		
		/**
		 *  
		 * @param textCom
		 * @param text 不带  p 标签
		 * @return 
		 * 
		 */
		public static function copyTextFlowStyle(textCom:TextFlow,text:XMLList):String{
			var textXML:XML = XML(TextConverter.export(getTextFlow(textCom),TextConverter.TEXT_LAYOUT_FORMAT,ConversionType.STRING_TYPE));
			textXML.@whiteSpaceCollapse = "collapse";
			var xmll:XMLList = textXML.children();
			
			for(var i:int=xmll.length()-1;i>=0;i--){
				delete xmll[i];
			}
			textXML.appendChild(text);
			return textXML.toXMLString();
		}
		private static function getTextFlow(textCom:TextFlow):TextFlow{
			var textflow:TextFlow;
			
			var xml:XML = XML(TextConverter.export(textCom,TextConverter.TEXT_LAYOUT_FORMAT,ConversionType.STRING_TYPE));
			
			
			var xmll:XMLList = xml.children();
			
			for(var i:int=xmll.length()-1;i>=0;i--){
				delete xmll[i];
			}	
			
			textflow = TextConverter.importToFlow(xml,TextConverter.TEXT_LAYOUT_FORMAT);		
			
			return textflow;
		}
		/**
		 *  
		 * @param disTarget 对象的注册点都必须在左上角上。 这个是根据注册点来计算的，如果注册不在左上角 0，0 位置上，计算出来的结果将不准确。
		 * @return 上下左右各边的距离
		 * @see com.sanbeetle.model.LocationRect
		 */
		public static function getBounds(disTarget:DisplayObjectContainer):LocationRect{
			var rect:LocationRect = new LocationRect();
			var cc:BoundDisplayObject  = Component.component.contentContainer;
			
			var point:Point =  disTarget.localToGlobal(new Point(disTarget.x,disTarget.y));
			
			//trace("sdfds",point,new Point(disTarget.x,disTarget.y));
			
			var ccLocalPoint:Point = cc.localToGlobal(point);
					
		
			rect.top = ccLocalPoint.y;
			rect.left = ccLocalPoint.x;
			rect.right = cc.width-rect.left-disTarget.width;
			rect.buttom = cc.height -rect.top-disTarget.height;
			
			
			return rect;
		}
		/**
		 *  child 是否是 obj 的子对象
		 * @param obj 
		 * @param child
		 * @return 
		 * 
		 */
		public static function isChild(obj:DisplayObject,child:DisplayObject):Boolean{
			var ischild:Boolean =false;		
			
			var target:DisplayObject = child;
			while(target!=null){
				if(target is Stage){
					ischild =false;
					break;
				}else if(target == obj){
					ischild =true;
					break;
				}else{
					target = target.parent;	
					//Console.out("components"+target);
				}
			}
			return ischild;
		}
	}
}