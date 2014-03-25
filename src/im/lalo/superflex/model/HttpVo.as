package im.lalo.superflex.model {

public class HttpVo {
    public var name:String;
    public var value:*;

    public function HttpVo(_name:String, _val:*):void {
        this.name = _name;
        this.value = _val;
    }
}

}