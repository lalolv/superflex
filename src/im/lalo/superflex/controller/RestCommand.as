package im.lalo.superflex.controller {

import com.adobe.net.URI;
import com.adobe.serialization.json.JSON;
import com.adobe.serialization.json.JSONParseError;
import com.lalolab.brainmvc.controller.BrainCommand;

import flash.events.ErrorEvent;
import flash.filesystem.File;
import flash.utils.ByteArray;

import org.httpclient.HttpClient;
import org.httpclient.events.HttpDataEvent;
import org.httpclient.events.HttpDataListener;
import org.httpclient.events.HttpResponseEvent;
import org.httpclient.events.HttpStatusEvent;
import org.httpclient.http.multipart.Multipart;
import org.httpclient.http.multipart.Part;

public class RestCommand extends BrainCommand {
    // 上传和下载URL
    public var req_url:String;
    public var up_url:String;

    protected var timeout:Number = 2 * 60 * 1000;

    private static var _instance:RestCommand = new RestCommand();

    public static function getInstance():RestCommand {
        return _instance;
    }

    /**
     * POST 数据
     */
    public function postData(uri:String, vars:Array, notice:String = ""):void {
        var httpClient:HttpClient = new HttpClient();
        httpClient.timeout = timeout;
        httpClient.postFormData(new URI(encodeURI(req_url + uri)), vars);
        // 获取数据
        httpClient.listener.onData = function (event:HttpDataEvent):void {
            var stringData:String = event.readUTFBytes();
            var result:Object = formatJson(stringData);
            // send notice
            if (notice != "") {
                sendNotify(notice, result);
            }
        };
        // 完成请求
        httpClient.listener.onComplete = function (event:HttpResponseEvent):void {
            httpClient.cancel();
            httpClient.close();
            httpClient = null;
        };
        // 错误处理
        httpClient.listener.onError = function (event:ErrorEvent):void {
            var errorMessage:String = event.text;
            httpClient.cancel();
            httpClient.close();
            httpClient = null;
        };
    }

    /**
     * GET 数据
     */
    public function getData(uri:String, notice:String = ""):void {
        var httpClient:HttpClient = new HttpClient();
        httpClient.timeout = timeout;
        var listener:HttpDataListener = new HttpDataListener();
        httpClient.get(new URI(encodeURI(req_url + uri)), listener);

        // 获取数据
        listener.onDataComplete = function (event:HttpResponseEvent, data:ByteArray):void {
            data.position = 0;
            var stringData:String = data.readMultiByte(data.length, "utf-8");
            var result:Object = formatJson(stringData);
            // send notice
            if (notice != "") {
                sendNotify(notice, result.data);
            }
        };
        // 完成请求
        listener.onComplete = function (event:HttpResponseEvent):void {
            httpClient.cancel();
            httpClient.close();
            httpClient = null;
        };
        // 错误处理
        listener.onError = function (event:ErrorEvent):void {
            var errorMessage:String = event.text;
            trace(errorMessage);
            httpClient.cancel();
            httpClient.close();
            httpClient = null;
        };
    }

    /**
     * PUT 数据
     */
    public function putData(uri:String, vars:Array, notice:String = ""):void {
        var httpClient:HttpClient = new HttpClient();
        httpClient.timeout = timeout;
        httpClient.putFormData(new URI(encodeURI(req_url + uri)), vars);

        // 获取数据
        httpClient.listener.onData = function (event:HttpDataEvent):void {
            var stringData:String = event.readUTFBytes();
            var result:Object = formatJson(stringData);
            // send notice
            if (notice != "") {
                sendNotify(notice, result);
            }
        };
        // 完成请求
        httpClient.listener.onComplete = function (event:HttpResponseEvent):void {
            httpClient.cancel();
            httpClient.close();
            httpClient = null;
        };
        // 错误处理
        httpClient.listener.onError = function (event:ErrorEvent):void {
            var errorMessage:String = event.text;
            httpClient.cancel();
            httpClient.close();
            httpClient = null;
        };
    }

    /**
     * DEL 数据
     */
    public function deleteData(uri:String, func:Function, notice:String = ""):void {
        var httpClient:HttpClient = new HttpClient();
        httpClient.timeout = timeout;
        httpClient.del(new URI(req_url + uri));

        // 获取数据
        httpClient.listener.onData = func;
        // 完成请求
        httpClient.listener.onComplete = function (event:HttpResponseEvent):void {
            httpClient.cancel();
            httpClient.close();
            httpClient = null;

            // send notice
            if (notice != "") {
                sendNotify(notice);
            }
        };
        // 错误处理
        httpClient.listener.onError = function (event:ErrorEvent):void {
            var errorMessage:String = event.text;
            httpClient.cancel();
            httpClient.close();
            httpClient = null;
        };
    }

    /**
     * 上传数据
     */
    public function uploadData(file:File, newName:String, token:String):void {
        var httpClient:HttpClient = new HttpClient();
        httpClient.timeout = 10 * 60 * 1000;
        var contentType:String;
        switch (file.extension) {
            case "png":
            case "jpg":
            case "jpeg":
            case "gif":
                contentType = "image/" + file.extension;
                break;
            case "mp3":
                contentType = "audio/" + file.extension;
                break;
            case "mp4":
                contentType = "video/" + file.extension;
                break;
            default:
                contentType = "text/plain";
                break;
        }

        var multipart:Multipart = new Multipart([
            new Part("token", token),
            new Part("file", file.data, contentType, [
                { name: "filename", value: file.name }
            ]),
            new Part("key", newName)
        ]);
        // upload
        httpClient.postMultipart(new URI(up_url), multipart);

        // 返回数据
        httpClient.listener.onData = function (event:HttpDataEvent):void {
            var stringData:String = event.readUTFBytes();
            var result:Object = formatJson(stringData);
        };
        // 状态
        httpClient.listener.onStatus = function (event:HttpStatusEvent):void {
            // some msg
        };
        // 完成请求
        httpClient.listener.onComplete = function (event:HttpResponseEvent):void {
            httpClient.cancel();
            httpClient.close();
            httpClient = null;
            // 设置标记
            var mqCmd:MQCommand = MQCommand.getInstance();
            mqCmd.uploading = false;
        };
        // 错误处理
        httpClient.listener.onError = function (event:ErrorEvent):void {
            var errorMessage:String = event.text;
            httpClient.cancel();
            httpClient.close();
            httpClient = null;
            // 设置标记
            var mqCmd:MQCommand = MQCommand.getInstance();
            mqCmd.uploading = false;
        };
    }

    protected function formatJson(stringData:String):* {
        var result:* = null;
        try {
            result = com.adobe.serialization.json.JSON.decode(stringData);
        }
        catch (ex:JSONParseError) {
//            sendNotify(MainNotice.HTTP_Error_Notice, "json error: " + ex.message);
        }

        return result;
    }
}

}