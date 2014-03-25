package im.lalo.superflex.controller {

import flash.filesystem.File;

import im.lalo.superflex.model.UpFilesVo;
import im.lalo.superflex.util.QueueUtil;

/**
 * 上传队列
 */
public class MQCommand {
    private static var _instance:MQCommand = new MQCommand();
    private var restCmd:RestCommand = RestCommand.getInstance();

    private var upfiles_queue:QueueUtil = new QueueUtil();
    private var upfileVo:UpFilesVo;
    public var uploading:Boolean = false;

    /**
     * 获取单例
     * @return
     */
    public static function getInstance():MQCommand {
        return _instance;
    }

    /**
     * 添加上传的文件
     * @param file
     * @param newName
     * @param token
     */
    public function addUpfile(file:File, newName:String, token:String):void {
        upfiles_queue.add(new UpFilesVo(file, newName, token));
    }

    /**
     * 执行上传文件
     */
    public function execUpfile():void {
        if (!uploading && upfiles_queue.size() > 0) {
            uploading = true;
            upfileVo = upfiles_queue.poll();
            restCmd.uploadData(upfileVo.file, upfileVo.name, upfileVo.token);
        }
    }

    /**
     * 上传文件的队列数量
     * @return
     */
    public function countUpfile():uint {
        return upfiles_queue.size();
    }
}

}