package com.game.framework.ifaces {
	import com.game.framework.enum.RegistrationPoint;
	
	import flash.display.DisplayObject;
	
	/**
	 * 对接实现 了对国际化的支持
	 *@author sixf
	 */
	public interface IResourceManager {
		/**
		 * 初始化数据：<br/>
		 * 1、 可以是 *.properties  文件<br/>
		 * 2、可以是字符:<br/>
		 * key=value<br/>
		 * key=value<br/>
		 * key=value<br/>
		 * key=value<br/>
		 * @param embedObject 数据对象
		 *
		 */
		function loadResourceModule(embedObject:Object):void;
		
		/**
		 * 通过  key 获取 值 Log.out(rm.getStringParm("5014",["s","中国"]));
		 * @param key
		 * @return
		 *
		 */
		function getString(key:String):String;
		
		/**
		 * 设获取接口 
		 * @param iobtain
		 * 
		 */
		function setIObtain(iobtain:IObtain):void;
		
		/**
		 *
		 * @param key
		 * @param parms
		 * @return
		 *
		 */
		function getStringParm(key:String, parms:Array):String;
		
		/**
		 * 初始化国旗图标，
		 * @param assetData
		 *
		 */
		function initFlag(assetData:IAssetItem):void;
		
		function initUIAssets(assetData:IAssetItem):void;
		
		/**
		 * 得到国旗资源
		 * @param flagID 见 g_country.xml 定义
		 * @param sizeEnum SizeEnum 的常量，提供了不同的尺寸x8=8*8,x16=16*16,x32=32*32
		 * @see com.game.enum.SizeEnum
		 * @return 显示对象
		 *
		 */
		function getFlag(flagID:int, sizeEnum:int = 16, align:String = RegistrationPoint.CENTER,outBroder:Boolean=false):DisplayObject;
		
		/**
		 * 初始化队标
		 * @param assetData
		 *
		 */
		function initTeamSymbol(assetData:IAssetItem):void;
		
		/**
		 *  得到队标
		 * @param symbolID
		 * @param sizeEnum
		 * @param align
		 * @return
		 *
		 */
		function getTeamSymbol(symbolID:int, sizeEnum:int = 16, align:String = RegistrationPoint.CENTER,outBroder:Boolean=false):DisplayObject;
		
		/**
		 *  初始化队服
		 * @param assetData
		 *
		 */
		function initUniform(assetData:IAssetItem):void;
		
		/**
		 *  初始化表情
		 * @param assetData
		 * 
		 */
		function initSmilies(assetData:IAssetItem):void;
		
		/**
		 *  来自  icons.fla
		 * @param assetData
		 * 
		 */
		function initIcon(assetData:IAssetItem):void;
		/**
		 * 通过名字获取 icons.fla 资源 
		 * @param name
		 * 
		 */
		function getIcon(name:String,sizeEnum:int = 20,align:String=RegistrationPoint.CENTER,outBroder:Boolean=false):DisplayObject;
		
		function getSmiliseNames():Vector.<String>;
		
		/**
		 *  通过类名获取 uiassets.fla 资源 
		 * @param className
		 * @return 
		 * 
		 */
		function getUIAsset(className:String):DisplayObject;
		
		/**
		 *  得到表情，如： smilies_chj
		 * @param name 是 smilies_chj 是下划线之后的字符 chj ,返回的 DisplayObject 的name 是chj
		 * @return 
		 * 
		 */
		function getSmilise(name:String,sizeEnum:int = 20,align:String=RegistrationPoint.CENTER,outBroder:Boolean=false):DisplayObject;
		/**
		 * 返回所有的表情 
		 * @return 
		 * 
		 */
		function getSmilises(sizeEnum:int = 20,align:String=RegistrationPoint.CENTER,outBroder:Boolean=false):Vector.<DisplayObject>;
		
		/**
		 * 得到队服 vl
		 * @param uniformlID
		 * @param sizeEnum
		 * @param align
		 * @return
		 *
		 */
		function getUniformVL(uniformlID:int, sizeEnum:int = 16, align:String = RegistrationPoint.CENTER,outBroder:Boolean=false):DisplayObject;
		
		/**
		 * 得到队服 hl
		 * @param uniformlID
		 * @param sizeEnum
		 * @param align
		 * @return
		 *
		 */
		function getUniformHL(uniformlID:int, sizeEnum:int = 16, align:String = RegistrationPoint.CENTER,outBroder:Boolean=false):DisplayObject;
	}
}