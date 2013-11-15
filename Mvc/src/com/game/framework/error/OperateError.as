package com.game.framework.error {
/**
 * 自定义 try 报错
 *@author sixf
 */
public class OperateError extends Error {
    private var target:Object;

    public function OperateError(message:* = "", target:Object = null, id:* = 0) {
        if (target != null) {
            message = message + " 目标：" + target;
        }
        this.target = target;
        super(message, id);

    }

    public function toString():String {
        return message;
    }
}
}