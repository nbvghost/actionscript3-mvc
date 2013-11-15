package com.game.framework.command {
import com.game.framework.FW;
import com.game.framework.Launcher;
import com.game.framework.ifaces.IRegister;
import com.game.framework.models.proxy.Proxy;
import com.game.framework.views.BaseMediator;

/**
 *
 *@author sixf
 */
public class RegisterCommand extends Command implements IRegister {
    public function RegisterCommand() {
        super();
    }

    public function registerCommand(commandID:String, command:Class):void {
        Launcher.FW::launcher.registerCommand(commandID, command);
    }

    public function registerMediator(mediator:BaseMediator):void {
        Launcher.FW::launcher.registerMediator(mediator);

    }

    public function registerProxy(proxy:Proxy):void {

        Launcher.FW::launcher.registerProxy(proxy);
    }

}
}