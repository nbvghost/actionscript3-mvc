package com.game.framework.data
{
	import com.game.framework.ifaces.IURL;
	
	import flash.utils.ByteArray;

	/**
	 * @author sixf
	 * 日期：2014-3-26 下午4:27:02 2014
	 * Administrator
	 */
	public class CacheData
	{
		private static var modelObj:Object = {};
		public function CacheData()
		{
			
		}
		public static function writeByteArray(iurl:IURL,ba:ByteArray):void{
			modelObj[iurl.url] = ba;
		}
		public static function getSwfByteArray(iurl:IURL):ByteArray{
			if(modelObj[iurl.url]==undefined){
				return null;
			}else{
				return modelObj[iurl.url];
			}
		}
	}
}