package com.game.framework.data
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	
	[Event(name="viewChange", type="com.game.framework.data.DialogDataItem")]
	[Event(name="labelChange", type="com.game.framework.data.DialogDataItem")]
	/**
	 *
	 *@author sixf
	 */
	public class DialogDataItem extends EventDispatcher
	{
		public static const viewChange:String="viewChange";
		public static const labelChange:String="labelChange";
		private var _view:DisplayObjectContainer;
		private var _label:String="undefined";
		
		public function DialogDataItem(label:String,view:DisplayObjectContainer)
		{
			this._label = label;
			this._view = view;	
			
		}	
		
		[Bindable(event=labelChange)]
		public function get label():String
		{
			return _label;
		}

		public function set label(value:String):void
		{
			if( _label !== value)
			{
				_label = value;
				dispatchEvent(new Event(labelChange));
			}
		}

		[Bindable(event=viewChange)]
		public function get view():DisplayObjectContainer
		{
			return _view;
		}

		public function set view(value:DisplayObjectContainer):void
		{
			if( _view !== value)
			{
				_view = value;
				dispatchEvent(new Event(viewChange));
			}
		}

	}
}