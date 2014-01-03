package com.game.framework.logic
{
	import com.game.framework.ifaces.ITargetID;

	/**
	 * @author sixf
	 * 日期：2013-11-18 下午3:28:07 2013
	 * Administrator
	 */
	public class TargetID
	{
		public static var IDPool:uint =0;
		
		public function TargetID()
		{
			
		}
		public static function get NewTargetID():ITargetID{
			return new TargetIDMode(IDPool++);
		}
		public static function Convert(targetID:uint):ITargetID{
			return new TargetIDMode(targetID);
		}
		/**
		 * 得到一个新的ID，并在前加一个  name 变量
		 * @param name
		 * @return 
		 * 
		 */
		public static function PrefixNewTargetID(name:String):String{
			
			return name+"_"+NewTargetID.id;
		}
	}
}
import com.game.framework.ifaces.ITargetID;

/**
 * 窗口ID 对象类。
 * @author sixf
 * 
 */
class TargetIDMode implements ITargetID{
	private var _id:uint =0 ;
	
	public function get id():uint
	{
		return _id;
	}
	public function TargetIDMode(pid:uint){
		_id =pid;
	}
	
	public function set id(value:uint):void
	{
		_id = value;
	}
}