package com.game.framework
{
	import com.game.framework.command.Command;
	import com.game.framework.error.OperateError;
	import com.game.framework.interfaces.INotify;
	import com.game.framework.interfaces.INotifyData;
	import com.game.framework.interfaces.IObtain;
	import com.game.framework.interfaces.IProxy;
	import com.game.framework.interfaces.IRegister;
	import com.game.framework.interfaces.IResourceManager;
	import com.game.framework.interfaces.IUIManager;
	import com.game.framework.model.NotifyData;
	import com.game.framework.model.proxy.Proxy;
	import com.game.framework.view.BaseMediator;
	import com.game.framework.view.Mediator;
	
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	/**
	 * 单例
	 * 用于管理 Command,Mediator,Proxy 三层的单例。
	 * 
	 * @author sixf
	 * 
	 */
	public class Launcher implements INotify,IRegister,IObtain
	{
		
		private var dictionaryMediator:Dictionary;
		private var dictionaryCommand:Dictionary;
		private var dictionaryProxy:Dictionary;
		
		private static var _launcher:Launcher;
		private var _uimanager:IUIManager;
		private var _resourceManager:IResourceManager;
		
		public function Launcher(singleton:Singleton)
		{
			if(singleton==null){
				throw new Error("Launcher 实例化出错！请使用静态访问！");
			}
			dictionaryMediator = new Dictionary(true);	
			dictionaryCommand = new Dictionary(true);
			dictionaryProxy = new Dictionary(true);			
		}

		/**
		 * 国际化资源对象 
		 */
		public function get resourceManager():IResourceManager
		{
			return _resourceManager;
		}

		/**
		 * @private
		 */
		public function set resourceManager(value:IResourceManager):void
		{
			_resourceManager = value;
		}

		/**
		 * 创建:Launcher 实例 
		 * @return 
		 * 
		 */
		public static function get launcher():Launcher{
			if(_launcher==null){
				throw new Error("请在Launcher.start之后使用！");
			}
			return _launcher;
		}
		/**
		 * 注册一个逻辑层 
		 * @param command
		 * 
		 */
		public function registerCommand(commandID:String,command:Class):void{
			if(launcher.dictionaryCommand[commandID]==undefined){
				launcher.dictionaryCommand[commandID] =command;
			}else{
				throw new Error("注册command 时，出现 commandID 键值重复！commandID:"+commandID+",command 对象："+command);
			}
		}
		/**
		 * 注册一个表现层 
		 * @param mediator
		 * 
		 */
		public function registerMediator(mediator:BaseMediator):void{
			if(launcher.dictionaryMediator[mediator.name]==undefined){
				launcher.dictionaryMediator[mediator.name] =mediator;
				mediator.intiUIManager(_uimanager);
				mediator.initMediator();
			}else{
				throw new OperateError("Mediator 出现重名了！名字："+mediator.name,mediator);
			}			
		}	
		/**
		 * 删除一个Mediator 
		 * @param mediator
		 * 
		 */
		public function unregisterMediator(mediator:BaseMediator):void{
			
			delete launcher.dictionaryMediator[mediator.name];
			mediator=null;
		}

		/**
		 * 启动 Launcher 构造 Launcher 单例，Launcher 得以使用
		 * @param StartCommand Command
		 * @param uimanager UI 管理器
		 * @param resourceManager 国际化支持对象
		 */	
		public static function start(StartCommand:Class,uimanager:IUIManager,resourceManager:IResourceManager=null):void{
			
			if(_launcher==null){
				_launcher = new Launcher(new Singleton());
				_launcher._uimanager = uimanager;			
				var mainCommand:Command =new StartCommand();
				mainCommand.execute(new NotifyData());
				mainCommand=null;
				StartCommand=null;
				_launcher._resourceManager = resourceManager;
			}else{
				trace("Launcher.start 出现的多次调用!");
			}	
			
		}	
		
		/**
		 * 接口冗余方法
		 *
		 * @param name
		 * @param message
		 * 
		 */
		public function handerNotify(name:String,message:INotifyData):void
		{
			
			
		}
		
		/**
		 * 接口冗余方法 
		 * @return 
		 * 
		 */
		public function registerNotify():Array
		{			
			return [];
		}
		/**
		 * 发送消息，遍历， Mediator，Proxy，Command 三层
		 * @param name
		 * @param notifyData
		 * @return 是否执行成功
		 * 
		 */
		public function sendNotify(name:String, notifyData:INotifyData):Boolean
		{			
			var isfind:Boolean = true;
			var key:String;
			var notify:NotifyData;
			var time:Number =getTimer();
			if((executeMediator(name,notifyData)==false) == (executeProxy(name,notifyData)==false) == (executeCommand(name,notifyData)==false) ==true){
				trace("消息发送都没有找到目标！"+name);
				isfind =false;
			}	
			trace("发送消息处理用时："+(getTimer()-time)+"毫秒");
			return isfind;
		}		
		/**
		 * 向目标发送消息 
		 * @param name
		 * @param type
		 * @param notifyData
		 * 
		 */
		public function sendNotifyTarget(name:String,type:String,notifyData:INotifyData):void
		{
			
		}
		
		/**
		 * 注册一个proxy 对象 
		 * @param proxy
		 * 
		 */
		public function registerProxy(proxy:IProxy):void
		{			
			if(launcher.dictionaryProxy[proxy.name]==undefined){
				launcher.dictionaryProxy[proxy.name] =proxy;
				proxy.initProxy();
			}else{
				throw new OperateError("Proxy name 已经存在！请换一个名字！"+proxy);
			}			
		}	
		/**
		 * 向 Mediator 层发送消息
		 * @param name
		 * @param notifyData
		 * @return 
		 * 
		 */
		public function executeMediator(name:String,notifyData:INotifyData):Boolean{
			var isfind:Boolean = false;
			var mediator:Mediator;
			for(var key:String in launcher.dictionaryMediator){		
				mediator = Mediator(launcher.dictionaryMediator[key]);
				if(mediator.registerNotify().indexOf(name)!=-1){					
					if(notifyData.target!=mediator.name){
						mediator.push(name,notifyData);
						isfind =true;
					}					
				}
			}
			return isfind;
		}
		/**
		 * 执行 Command 层
		 * @param name
		 * @param notifyData
		 * @return 
		 * 
		 */
		public function executeCommand(name:String,notifyData:INotifyData):Boolean
		{			
			var CommandClass:Class = launcher.dictionaryCommand[name] as Class;
			if(CommandClass==null){
				trace(name+" 在 dictionaryCommand 找不到 ,目标："+notifyData.message+","+notifyData.type);
				return false;
			}
			var command:Command = new CommandClass();
			command.execute(notifyData);
			command=null;
			CommandClass=null;
			return true;
		}		
		/**
		 * 向 Proxy 层发送消息
		 * @param name
		 * @param notifyData
		 * @return 
		 * 
		 */
		public function executeProxy(name:String,notifyData:INotifyData):Boolean
		{
			var isfind:Boolean = false;			
			var proxy:Proxy;
			var notifys:Array;			
			for(var key:String in launcher.dictionaryProxy){	
				proxy = launcher.dictionaryProxy[key];
				notifys =proxy.registerNotify();
				
				if(notifys.length>0){
					if(notifys.indexOf(name)!=-1){	
						if(proxy.name!=notifyData.target){
							proxy.handerNotify(name,notifyData);
							isfind =true;
						}							
					}
				}				
			}
			return isfind;
		}
		
		/**
		 * 获取 Mediator 对象
		 * @param mediatroName
		 * @return 
		 * 
		 */
		public function obtainMediator(mediatroName:String):Mediator
		{
			
			return launcher.dictionaryMediator[mediatroName];
		}
		
		/**
		 * 获取 Proxy 对象 
		 * @param proxyName
		 * @return 
		 * 
		 */
		public function obtainProxy(proxyName:String):IProxy
		{
			
			return launcher.dictionaryProxy[proxyName];
		}		
	}
	
}
/**
 * 用于创建单例的私有对象
 * @author sixf
 * 
 */
class Singleton{
	
}