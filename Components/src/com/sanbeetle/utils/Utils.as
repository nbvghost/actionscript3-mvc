package com.sanbeetle.utils
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	
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
			if(int(te)==0){
				te = "--";
			}
			return te;
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
				if(target == obj){
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