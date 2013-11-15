package com.game.framework.net {
import com.game.framework.ifaces.IURL;

/**
 *
 *@author sixf
 */
public class SkinLoader extends AssetItem {
    public function SkinLoader(url:IURL, currentDomain:Boolean = true) {
        super(url, currentDomain);
    }
}
}