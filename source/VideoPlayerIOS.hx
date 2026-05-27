package;

#if ios
import openfl.media.Video;
import openfl.net.NetConnection;
import openfl.net.NetStream;
import openfl.events.NetStatusEvent;

class VideoPlayerIOS {
    public var video:Video;
    public var stream:NetStream;

    public function new(path:String, onFinish:Void->Void) {
        var nc = new NetConnection();
        nc.connect(null);

        stream = new NetStream(nc);
        stream.client = { onMetaData: function(_) {} };

        stream.addEventListener(NetStatusEvent.NET_STATUS, function(e) {
            if (e.info.code == "NetStream.Play.Stop") {
                onFinish();
            }
        });

        video = new Video();
        video.attachNetStream(stream);

        stream.play(path);
    }
}
#end
