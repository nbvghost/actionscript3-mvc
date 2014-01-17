package com.game.framework.net
{
	import com.game.framework.ifaces.IURL;
	import com.game.framework.views.CreateView;
	import com.game.framework.views.Mediator;
	
	import flash.events.TimerEvent;
	
	/**
	 * @author sixf
	 * 日期：2013-11-22 下午2:57:03 2013
	 * Administrator
	 */
	public class DialogContentAssetItem extends MediaAssetItem
	{
		public function DialogContentAssetItem(url:IURL, currentDomain:Boolean=true)
		{
			super(url, currentDomain);
		}
		public function getCreateView():CreateView{
			return this.createView;	
		}
		public function getMediator():Mediator{
			return this.mediator;
		}
		
		override protected function notifyMediator():void
		{
			super.notifyMediator();
		}
		
		protected function dsfs(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			super.notifyMediator();
		}
		
	}
}