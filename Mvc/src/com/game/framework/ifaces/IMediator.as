package com.game.framework.ifaces {
import com.game.framework.views.CreateView;

/**
 *
 *@author sixf
 */
public interface IMediator {

    /**
     * Mediator 层的名称，在所有的Mediator 层中，必须是唯一的。
     * @return
     *
     */
    function get name():String;

    /**
     *  Mediator 被注册到 Launcher 里响应，并传入 UI 管理器 IUIManager
     * @see  com.game.framework.interfaces.IUIManager
     * @param uimanager
     *
     */
    //function initMediator(uimanager:IUIManager):void;
    /**
     * 释放资源
     *
     */
    function dispose():void;

    function get view():CreateView;

    //function set view(value:CreateView):void;
}
}