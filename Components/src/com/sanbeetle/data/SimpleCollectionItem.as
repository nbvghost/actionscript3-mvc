// Copyright 2007. Adobe Systems Incorporated. All Rights Reserved.
package com.sanbeetle.data{
	import com.sanbeetle.interfaces.IFListItem;
	
	/**
	 * The SimpleCollectionItem class defines a single item in an inspectable
	 * property that represents a data provider. A SimpleCollectionItem object
	 * is a collection list item that contains only <code>label</code> and
	 * <code>data</code> properties--for example, a ComboBox or List component.
     *
     * @internal Is this revised description correct?
	 * Adobe: [LM} Yes, its ok.
     *
	 * @includeExample examples/SimpleCollectionItemExample.as -noswf
	 *
     * @langversion 3.0
     * @playerversion Flash 9.0.28.0
	 *  
	 *  @playerversion AIR 1.0
	 *  @productversion Flash CS3
	 */
	dynamic public class SimpleCollectionItem implements IFListItem {
		
		private var _label:String;		
		private var _data:Object;
		private var _itemColor:String="0x000000";
		private var _itemOverColor:String="0xffffff";
		private var _enable:Boolean =true;
		
		private var _type:String;
		
		
		/**
         * Creates a new SimpleCollectionItem object.
         * @param label
		 * @param data
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 *  
		 *  @playerversion AIR 1.0
		 *  @productversion Flash CS3
		 */	
		public function SimpleCollectionItem(label:String=null,data:Object=null) {
			this.label = label;
			this.data = data;
		}		
		
		

		[Inspectable()]
		/**
		 * The <code>label</code> property of the object.
		 *
		 * The default value is <code>label(<em>n</em>)</code>, where <em>n</em> is the ordinal index.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 *  
		 *  @playerversion AIR 1.0		 *  @productversion Flash CS3
		 */
		public function get label():String
		{
			return _label;
		}

		/**
		 * @private
		 */
		public function set label(value:String):void
		{
			_label = value;
		}
		[Inspectable]		
		public function get type():String
		{
			return _type;
		}
		
		public function set type(value:String):void
		{
			_type = value;
		}
		[Inspectable]
		/**
		 * The <code>data</code> property of the object.
		 *
		 * @default null
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 *  
		 *  @playerversion AIR 1.0
		 *  @productversion Flash CS3
		 */
		public function get data():Object
		{
			return _data;
		}
		
		/**
		 * @private
		 */
		public function set data(value:Object):void
		{
			_data = value;
		}
		[Inspectable(defaultValue=true)]
		public function get enable():Boolean
		{
			// TODO Auto Generated method stub
			return _enable;
		}
		
		public function set enable(value:Boolean):void
		{
			// TODO Auto Generated method stub
			_enable = value;
		}
		[Inspectable(defaultValue="0x000000")]
		public function get itemColor():String
		{
			// TODO Auto Generated method stub
			return _itemColor;
		}
		
		public function set itemColor(value:String):void
		{
			// TODO Auto Generated method stub
			_itemColor=value;
		}
		[Inspectable(defaultValue="0xffffff")]
		public function get itemOverColor():String
		{
			// TODO Auto Generated method stub
			return _itemOverColor;
		}
		
		public function set itemOverColor(value:String):void
		{
			_itemOverColor = value;			
		}
		/**
         * @private
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 */
		/*public function toString():String {
			return "[SimpleCollectionItem: "+label+","+data+"]";	
		}*/
	}	
}