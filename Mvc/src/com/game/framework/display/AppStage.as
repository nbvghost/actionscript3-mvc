package com.game.framework.display
{
	import flash.display.Sprite;
	import flash.display.Stage;
	/**
	 * 伪装的一个 Stage 对象
	 *@author sixf
	 */
	public class AppStage extends Sprite
	{
		private var _trueStage:Stage;
		/**
		 * 传真正的 Stage 对象 
		 * @param stage
		 * 
		 */
		public function AppStage(stage:Stage)
		{
			super();
			_trueStage = stage;
		}

		/**
		 * 获取真正的 Stage 对象 
		 * @return 
		 * 
		 */
		public function get trueStage():Stage
		{
			return _trueStage;
		}

		public function set trueStage(value:Stage):void
		{
			_trueStage = value;
		}

	}
}