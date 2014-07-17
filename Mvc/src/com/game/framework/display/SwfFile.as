package com.game.framework.display
{
	import com.game.framework.ifaces.ISwfFile;
	import com.game.framework.ifaces.IURL;
	import com.game.framework.views.CreateView;
	import com.game.framework.views.Mediator;
	
	import flash.display.Sprite;
	
	/**
	 * @author sixf
	 * 日期：2014-6-3 上午9:29:16 2014
	 * Administrator
	 */
	public class SwfFile extends Sprite implements ISwfFile
	{
		
		public function SwfFile()
		{
			super();
		}
		
		public function get getMediator():Mediator
		{
			return null;
		}
		
		public function get getCreateView():CreateView
		{
			return null;
		}
		
		public function get getSkinURL():IURL
		{
			return null;
		}
		
		public function get getSkinClass():Class
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		
	}
}