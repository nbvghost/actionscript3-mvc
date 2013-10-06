package com.game.framework.interfaces
{
	/**
	 *
	 *@author sixf
	 */
	public interface IXMLCfg
	{
		/**
		 * 
		 * @return 数组中的每一项必须是IURL
		 * 
		 */
		function arequestXMLCfg():Array;
		function ahanderXMLCfg(type:IURL,notifyDatas:IAssetItem):void;		
	}
}