package com.sanbeetle.component
{
	import com.sanbeetle.skin.IVSamllScrollBarSkin_bar;
	import com.sanbeetle.skin.IVSamllScrollBarSkin_bg;
	import com.sanbeetle.skin.IVScrollBarSkin_buttom;
	import com.sanbeetle.skin.IVScrollBarSkin_top;

	/**
	 * @author sixf
	 * 日期：2013-11-26 下午5:59:02 2013
	 * Administrator
	 */
	public class IVSamllScrollBar extends IVScrollBar
	{
		public function IVSamllScrollBar()
		{
			s_left=new IVScrollBarSkin_top;
			s_left.visible =false;
			s_left.height = 0;
			s_right=new IVScrollBarSkin_buttom;
			s_right.visible =false;
			s_right.height = 0;
			s_bar=new IVSamllScrollBarSkin_bar;
			bg=new IVSamllScrollBarSkin_bg;
			//bg.width = s_bar.width;
		}
		override public function createUI():void
		{			
			super.createUI();	
			
			s_bar.y=int(s_left.height);
			s_bar.x =2;
			
			bg.height = this.trueHeight;			
			s_right.y = this.trueHeight-s_right.height;		
			
		}
	}
}