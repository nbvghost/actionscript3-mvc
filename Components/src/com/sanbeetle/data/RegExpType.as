package com.sanbeetle.data
{
	public class RegExpType
	{
		
		/**
		 * 匹配浮点数
		 */
		public static const NUMBER:RegExp=new RegExp(/^(-?\d+)(\.\d+)?$/);		
		/**
		 *  匹配整数
		 */
		public static const INT:RegExp=new RegExp(/^-?\d+$/);
		/**
		 * 过虑符号 
		 */
		public static const ILLEGAL:RegExp =new RegExp(/^[`~!@#$%^&*()+=|{}':;,\[\].<>\?]+$/);
		
		public function RegExpType()
		{
			
		}
	}
}