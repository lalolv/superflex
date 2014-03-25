/**
 * Created with IntelliJ IDEA.
 * User: lalo
 * Date: 14-2-28
 * Time: 下午2:54
 * To change this template use File | Settings | File Templates.
 */
package im.lalo.superflex.util {
import flash.net.LocalConnection;

public class MemoryUtil {
    public function MemoryUtil() {
    }

    /**
     * 强制回收内存
     */
    public static function GC():void {
        try {
            new LocalConnection().connect('foo');
            new LocalConnection().connect('foo');
        } catch (e:*) {
        }
    }
}

}
