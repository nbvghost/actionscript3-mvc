package com.game.framework.views
{
	import com.asvital.debug.Console;
	import com.game.framework.data.AlertDialogBuilder;
	import com.game.framework.data.ConfigData;
	import com.game.framework.events.DialogEvent;
	import com.game.framework.ifaces.IDialogID;
	import com.game.framework.net.DialogAssetItem;
	
	import flash.events.EventDispatcher;
	
	/**
	 * 
	 * 已经关闭
	 * 
	 */
	[Event(name="dismiss",type="com.game.framework.events.DialogEvent")]
	/**
	 * 窗口被打开
	 */
	[Event(name="show",type="com.game.framework.events.DialogEvent")]
	/**
	 * 正在关闭
	 */
	[Event(name="dismissing",type="com.game.framework.events.DialogEvent")]
	/**
	 * 窗口实例 
	 *@author sixf
	 */
	public class AlertDialog extends EventDispatcher
	{
		private static var builder:AlertDialogBuilder;
		private var dialogAssetItem:DialogAssetItem;
		private var mediator:Mediator;
		
		private var ID:IDialogID;
		
		public static var DialogPool:Object=new Object;
		public static var IDPool:int =0;
		
		private var _isDismiss:Boolean = false;
		public function AlertDialog(mediator:Mediator)
		{	
			this.ID = AlertDialog.dialogID;
			builder = new AlertDialogBuilder();
			this.mediator = mediator;
			
		}
		public static function dismissAll():void{
			for(var key:String in DialogPool){
				var alertdialog:AlertDialog = DialogPool[key];
				if(alertdialog!=null){
					alertdialog.dismiss();
					delete DialogPool[key];
				}				
			}			
		}
		/**
		 * 如有一个ID，就可以得到这个ID的窗口。全局的。 
		 * @param ID
		 * @return 
		 * 
		 */
		public static function getAlertDialog(ID:IDialogID):AlertDialog{
			return DialogPool[ID.id];
		}
		/**
		 * 生成一个ID，所有的窗口，使用这个方法 创建ID，被调用一个，会被加+1 
		 * @return 
		 * 
		 */
		public static function get dialogID():IDialogID{
			return new DialogID(IDPool++);
		}

		/**
		 * 这个窗口是否被关闭了。
		 * @return 
		 * 
		 */
		public function get isDismiss():Boolean
		{
			return _isDismiss;
		}

		public function set isDismiss(value:Boolean):void
		{
			_isDismiss = value;
		}

		/**
		 *  Builder 永远也不会为 null
		 * @return 
		 * 
		 */
		public function get Builder():AlertDialogBuilder{
			if(builder==null){
				builder = new AlertDialogBuilder();
			}			
			return builder;			
		}
		public function set Builder(value:AlertDialogBuilder):void{
			builder = value;
		}
		public function show(ID:IDialogID=null):AlertDialog{		
			if(ID!=null){
				this.ID = ID;
			}else{
				this.ID = AlertDialog.dialogID;
			}
			if(builder==null){
				Console.out("AlertDialog.Builder 不能为空！ ");
				return this;
			}else{
				if(builder.view==null){
					Console.out("AlertDialog.view 不能为空！ ");
					return this;
				}
			}			
			dialogAssetItem= new DialogAssetItem(ConfigData.getDialogView(),this);
			
			//dialogAssetItem= mediator.uimanager.uiLayer.secondFrontLayerContainer.midLayer
			
			dialogAssetItem=mediator.uimanager.uiLayer.secondFrontLayerContainer.midLayer.addChild(dialogAssetItem) as DialogAssetItem;
			
			
			
			dialogAssetItem.alertDialogBuilder = builder;
			dialogAssetItem.initView();			
		
			DialogPool[ID.id] =this;	
			this.dispatchEvent(new DialogEvent(DialogEvent.SHOW,builder));
			return this;
		}	
		/**
		 * 窗口关闭。 
		 * 
		 */
		public function dismiss():void{
			this.dispatchEvent(new DialogEvent(DialogEvent.DISMISSING,builder));
			
			if(dialogAssetItem){
				dialogAssetItem.dispose();			
				delete DialogPool[ID.id];
			}			
			
			dialogAssetItem=null;
			mediator =null;
			_isDismiss =true;
			
			this.dispatchEvent(new DialogEvent(DialogEvent.DISMISS,builder));
			
		}
	}
}
import com.game.framework.ifaces.IDialogID;

/**
 * 窗口ID 对象类。
 * @author sixf
 * 
 */
class DialogID implements IDialogID{
	private var _id:int = -1;

	public function get id():int
	{
		return _id;
	}
	public function DialogID(pid:int){
		_id =pid;
	}

	public function set id(value:int):void
	{
		_id = value;
	}
}