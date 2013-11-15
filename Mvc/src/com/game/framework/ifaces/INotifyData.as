package com.game.framework.ifaces {
/**
 * 消息数据接口
 *@author sixf
 */
public interface INotifyData {
    /**
     * 消息数据
     * @return
     *
     */
    function get message():Object;

    function set message(value:Object):void;

    /**
     * 消息类型
     * @return
     *
     */
    function get type():String;

    function set type(value:String):void;

    function toString():String;
}
}