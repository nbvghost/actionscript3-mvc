package com.game.framework.geom
{
	import com.game.framework.net.MediaAssetItem;
	
	/**
	 * 使用页面切换，所需装载的对象。out and into 的 MediaAssetItem 对象
	 * @see com.game.framework.net.MediaAssetItem
	 *@author sixf
	 */
	public class AnimationTarget
	{
		private var _outMedia:MediaAssetItem;
		private var _intoMedia:MediaAssetItem;
		public function AnimationTarget(out:MediaAssetItem=null,into:MediaAssetItem=null)
		{
			this._intoMedia = into;
			this._outMedia = out;
		}

		public function get intoMedia():MediaAssetItem
		{
			return _intoMedia;
		}

		public function set intoMedia(value:MediaAssetItem):void
		{
			_intoMedia = value;
		}

		public function get outMedia():MediaAssetItem
		{
			return _outMedia;
		}

		public function set outMedia(value:MediaAssetItem):void
		{
			_outMedia = value;
		}

	}
}