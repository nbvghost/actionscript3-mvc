package com.sanbeetle.utils
{
	
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
	}
}