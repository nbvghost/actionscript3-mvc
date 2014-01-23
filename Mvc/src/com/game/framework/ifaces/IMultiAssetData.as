package com.game.framework.ifaces {
	/**
	 *
	 *@author sixf
	 */
	public interface IMultiAssetData extends IAssetsData {
		function asssetMultiComplete(datas:Vector.<IAssetItem>):void;
	}
}