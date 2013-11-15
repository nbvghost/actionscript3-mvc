package  com.game.framework.data
{
	
	/**
	 *
	 *@author sixf
	 */
	public class DialogButtonData
	{
		/**
		 * 确定 
		 */
		public static const Positive:String="Positive";
		/**
		 * 否
		 */
		public static const Negative:String="Negative";	
		
		private var _type:String =Positive;
		private var _label:String;
	

		private var _clickHandler:Function;
		private var _btnWidth:int=79;
		private var _btnHeight:int=21;
		
	

		public function get btnHeight():int
		{
			return _btnHeight;
		}

		public function set btnHeight(value:int):void
		{
			_btnHeight = value;
		}

		public function get btnWidth():int
		{
			return _btnWidth;
		}

		public function set btnWidth(value:int):void
		{
			_btnWidth = value;
		}	
		public function DialogButtonData(_label:String,_clickHandler:Function,btnWidth:int =79,btnHeight:int=21)
		{
			this._label = _label;
			this._clickHandler = _clickHandler;
			this.btnWidth = btnWidth;
			this.btnHeight = btnHeight;			
		}

		public function get label():String
		{
			return _label;
		}
		public function get clickHandler():Function
		{
			return _clickHandler;
		}
		
		public function set clickHandler(value:Function):void
		{
			_clickHandler = value;
		}
		public function set label(value:String):void
		{
			_label = value;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

	}
}