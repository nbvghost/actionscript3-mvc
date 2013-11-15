package com.game.framework.net {
import com.game.framework.ifaces.IAssetItem;
import com.game.framework.ifaces.IMultiAssetData;

import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;

/**
 *
 *@author sixf
 */
public class MultiAssetData implements IMultiAssetData {
    public function MultiAssetData() {
    }

    public function asssetAllComplete(data:IAssetItem):void {
        // TODO Auto Generated method stub

    }

    public function asssetMultiComplete(datas:Vector.<IAssetItem>):void {

    }

    public function asssetComplete(data:IAssetItem):void {
    }

    public function netError(event:IOErrorEvent, data:IAssetItem):void {
    }

    public function progress(event:ProgressEvent, data:IAssetItem):void {

    }
}
}