package com.game.framework {
	import com.asvital.dev.Log;
	import com.game.framework.command.Command;
	import com.game.framework.error.OperateError;
	import com.game.framework.ifaces.INotify;
	import com.game.framework.ifaces.INotifyData;
	import com.game.framework.ifaces.IObtain;
	import com.game.framework.ifaces.IProxy;
	import com.game.framework.ifaces.IRegister;
	import com.game.framework.ifaces.IResourceManager;
	import com.game.framework.ifaces.IUIManager;
	import com.game.framework.models.NotifyData;
	import com.game.framework.models.proxy.Proxy;
	import com.game.framework.views.BaseMediator;
	import com.game.framework.views.Mediator;
	
	import flash.system.Capabilities;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	/**
	 * 单例
	 * 用于管理 Command,Mediator,Proxy 三层的单例。
	 *
	 * @author sixf
	 *
	 */
	public class Launcher implements INotify,IRegister,IObtain {
		
		private var dictionaryMediator:Dictionary=new Dictionary();
		private var dictionaryCommand:Object={};
		private var dictionaryProxy:Dictionary=new Dictionary();
		
		private static var _launcher:Launcher;
		private var _uimanager:IUIManager;
		private var _resourceManager:IResourceManager;
		
		public function Launcher(singleton:Singleton) {
			if (singleton == null) {
				throw new Error("Launcher 实例化出错！请使用静态访问！");
			}
			/*dictionaryMediator = new Dictionary(true);
			dictionaryCommand = new Dictionary(true);
			dictionaryProxy = new Dictionary(true);*/
		}
		
		/**
		 * 创建:Launcher 实例
		 * @return
		 *
		 */
		public static function get launcher():Launcher {
			if (_launcher == null) {
				throw new Error("请在Launcher.start之后使用！");
			}
			return _launcher;
		}
		
		/**
		 * 注册一个逻辑层
		 * @param command
		 *
		 */
		public function registerCommand(commandID:String, command:Class):void {
			if (dictionaryCommand[commandID] == undefined) {
				dictionaryCommand[commandID] = command;
			} else {
				throw new Error("注册command 时，出现 commandID 键值重复！commandID:" + commandID + ",command 对象：" + command);
			}
		}
		
		/**
		 * 注册一个表现层
		 * @param mediator
		 *
		 */
		public function registerMediator(MediatorClass:Class):void {
			if (dictionaryMediator[MediatorClass] == undefined) {
				
				var mediator:BaseMediator = new MediatorClass();
				
				
				if(mediator.name!=Mediator.NONE && mediator.name!="" && mediator.name!=null){
					dictionaryMediator[MediatorClass] = mediator;
				}				
				
				mediator.FW::initMediator(_uimanager, _resourceManager);
				
			} else {
				throw new OperateError("Mediator 出现重名了！名字：" + mediator.name, mediator);
			}
		}
		
		/**
		 * 删除一个Mediator
		 * @param mediator
		 *
		 */
		public function unregisterMediator(MediatorClass:Class):void {
			
			delete dictionaryMediator[MediatorClass];
			MediatorClass = null;
		}
		
		/**
		 * 启动 Launcher 构造 Launcher 单例，Launcher 得以使用
		 * @param StartCommand Command
		 * @param uimanager UI 管理器
		 * @param resourceManager 国际化支持对象
		 */
		public static function start(StartCommand:Class, uimanager:IUIManager, resourceManager:IResourceManager = null):void {
			
			if (_launcher == null) {
				_launcher = new Launcher(new Singleton());
				
				_launcher._resourceManager = resourceManager;
				_launcher._uimanager = uimanager;
				resourceManager.setIObtain(_launcher);
				var mainCommand:Command = new StartCommand();
				mainCommand.execute(new NotifyData());
				mainCommand = null;
				StartCommand = null;
				
			} else {
				Log.out("Launcher.start 出现的多次调用!");
			}
			
		}
		
		/**
		 * 接口冗余方法
		 *
		 * @param name
		 * @param message
		 *
		 */
		public function handerNotify(name:String, message:INotifyData):void {
			
			
		}
		
		/**
		 * 接口冗余方法
		 * @return
		 *
		 */
		public function registerNotify():Array {
			return [];
		}
		
		/**
		 * 发送消息，遍历， Mediator，Proxy，Command 三层
		 * @param name
		 * @param notifyData
		 * @return 是否执行成功
		 *
		 */
		public function sendNotify(name:String, notifyData:INotifyData):Boolean {
			var time:Number = getTimer();
			
			var isfind:Boolean = true;
			var key:String;
			var notify:NotifyData;
			
			
			
			if ((executeMediator(name, notifyData) == false) && (executeProxy(name, notifyData) == false) && (executeCommand(name, notifyData) == false)) {
				Log.info("消息发送都没有找到目标！" + name);
				isfind = false;
			}
			
			
			
			time = (getTimer() - time);
			Log.info("发送消息处理用时：" + time + "毫秒",name);
			if (Capabilities.isDebugger) {
				if (time > 700) {
					Log.info(new OperateError("消息处理时间大于 700，请优化程序。消息类型：" + name + "消息包类型：" + notifyData.type, this));
				}
			}
			return isfind;
		}
		
		/**
		 * 向目标发送消息
		 * @param name
		 * @param type
		 * @param notifyData
		 *
		 */
		public function sendNotifyTarget(name:String, type:String, notifyData:INotifyData):void {
			
		}
		
		/**
		 * 注册一个proxy 对象
		 * @param proxy
		 *
		 */
		public function registerProxy(ProxyClass:Class):void {
			if (dictionaryProxy[ProxyClass] == undefined) {
				var proxy:Proxy = new ProxyClass();				
				dictionaryProxy[ProxyClass] = proxy;
				proxy.FW::resourceManager = _resourceManager;
				proxy.initProxy();
			} else {
				throw new OperateError(ProxyClass+" 已经存在！请换一个名字！" + proxy);
			}
		}
		
		/**
		 * 向 Mediator 层发送消息
		 * @param name
		 * @param notifyData
		 * @return
		 *
		 */
		public function executeMediator(name:String, notifyData:INotifyData):Boolean {
			var isfind:Boolean = false;
			var mediator:Mediator;
			for (var key:Class in dictionaryMediator) {
				mediator = Mediator(dictionaryMediator[key]);
				if (mediator.registerNotify().indexOf(name) != -1) {
					if((notifyData as NotifyData).FW::target != mediator.name) {
						mediator.push(name, notifyData);
						isfind = true;
					}else{
						Log.error("自己不能给自己发信息，要发请使用 handerNotify 方法。",mediator);
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
		public function executeCommand(name:String, notifyData:INotifyData):Boolean {
			var CommandClass:Class = dictionaryCommand[name] as Class;
			if (CommandClass == null) {
				Log.out(name + " 在 dictionaryCommand 找不到 ,目标：" + notifyData.message + "," + notifyData.type);
				return false;
			}
			var command:Command = new CommandClass();
			//command.FW::disExecute(notifyData);
			//改成事件调试
			command.execute(notifyData);
			command = null;
			CommandClass = null;
			return true;
		}
		
		/**
		 * 向 Proxy 层发送消息
		 * @param name
		 * @param notifyData
		 * @return
		 *
		 */
		public function executeProxy(name:String, notifyData:INotifyData):Boolean {
			var isfind:Boolean = false;
			var proxy:Proxy;
			var notifys:Array;
			for (var key:Class in dictionaryProxy) {
				proxy = dictionaryProxy[key];
				notifys = proxy.registerNotify();
				if (notifys.length > 0) {
					if (notifys.indexOf(name) != -1) {
						if (proxy.name != (notifyData as NotifyData).FW::target) {
							//改用事件驱动
							//proxy.FW::disHanderNotify(name, notifyData);
							proxy.handerNotify(name,notifyData);
							isfind = true;
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
		public function obtainMediator(MediatroClass:Class):Mediator {
			
			return dictionaryMediator[MediatroClass];
		}
		
		/**
		 * 获取 Proxy 对象
		 * @param proxyName
		 * @return
		 *
		 */
		public function obtainProxy(ProxyClass:Class):IProxy {
			
			return dictionaryProxy[ProxyClass];
		}
		
	}
	
}
/**
 * 用于创建单例的私有对象
 * @author sixf
 *
 */
class Singleton {
	
}