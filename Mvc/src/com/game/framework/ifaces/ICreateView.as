package com.game.framework.ifaces {
import flash.events.IEventDispatcher;

/**
 * 视图接口，扩展 IEventDispatcher 接口，说明该接口实现类，必须是一个视图对象，或者 实现了 IEventDispatcher 接口
 * @see flash.events.IEventDispatcher
 *@author sixf
 */
public interface ICreateView extends IEventDispatcher {
    /**
     * UIManager 这个会被自动注入
     * @return
     * @see com.game.framework.interfaces.IUIManager
     */
    function get uimanager():IUIManager;

    // function set uimanager(value:IUIManager):void;


    /**
     * 资源管理器
     * @return
     *
     */
    function get resourceManager():IResourceManager;

    //function set resourceManager(value:IResourceManager):void;
    /**
     * 是否要进行加载。
     * 这 个主要用于 空的 SpriteView 对象。在创建一个 View 时，可能不需要 去加载动作。那就设置成false
     * @return
     *
     */
    function get needToLoad():Boolean;

    //function set hasLoad(value:Boolean):void;
    /**
     * 释放资源
     *
     */
    function dispose():void;
}
}