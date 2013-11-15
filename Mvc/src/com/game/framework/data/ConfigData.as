package com.game.framework.data
{
	import com.game.framework.ifaces.IURL;
	
	/**
	 *
	 *@author sixf
	 */
	public class ConfigData
	{
		private static var dialogView:IURL;
		public function ConfigData()
		{
		}
		public static function getDialogView():IURL{
			return dialogView;
		}
		public static function setDialogView(valur:IURL):void{
			dialogView = valur;
		}
	}
}