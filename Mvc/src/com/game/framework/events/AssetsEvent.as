package com.game.framework.events {
import flash.events.Event;

/**
 * 资源自定义事件
 *@author sixf
 */
public class AssetsEvent extends Event {
    /**
     * 资源加载完成
     */
    public static const COMPLETE_LOAD:String = "complete_load";

    /**
     * 雅黑字体加载完成
     */
    public static const YAHEI_FONT_LOAD:String = "yahei_font_load";
    /**
     * 事件传递的数据对象
     */
    public var data:Object = null;

    /**
     *
     * @param type 事件类型，使用 AssetsEvent 静态属性
     * @param data 为事件传值
     *
     */
    public function AssetsEvent(type:String, data:Object = null) {
        super(type, false, false);
        if (data != null) {
            this.data = data;
        }
    }
}
}