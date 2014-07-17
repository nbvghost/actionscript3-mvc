package com.game.framework.net {


/**
 * AssetTtem 的内容类型
 * @author sixf
 * @see com.game.framework.net.AssetItem#type
 */
public class LoadContentType {
    /**
     * 类型是swf,jps,png,等
     */
    public static const MEDIA_CONTENT:String = "MEDIA_CONTENT";
	/**
	 * 字节加载 
	 */
	public static const MEDIA_CONTENT_BY_BYTEARRAY:String = "MEDIA_CONTENT_BY_BYTEARRAY";
    /**
     * 类型是字符串
     */
    public static const STREAM_CONTENT:String = "STREAM_CONTENT";

    public function LoadContentType() {
    }
}
}