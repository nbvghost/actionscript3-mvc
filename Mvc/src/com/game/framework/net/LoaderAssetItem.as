package com.game.framework.net
{
	import com.game.framework.interfaces.IURL;
	
	
	/**
	 * 类似于Loader
	 *@author sixf
	 */
	public class LoaderAssetItem extends AssetItem
	{
		public function LoaderAssetItem(url:IURL,currentDomain:Boolean =true)
		{
			super(url,currentDomain);
		}
		
		
		
	}
}