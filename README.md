NuiGesture
==========

A gesture project extends as3nui. This is a class for flash-air with kinect, that you can easy to get the gesture on your kinect.

一个手势操控类。封装了大部分手势操作类，在你的air作品中，只需要简单的添加几句代码就可以使用手势操作。
需要Microsoft Kinect硬件，和as3nui的库，以及Kinect SDK 1.5以上的版本驱动即可。



那个什么版权之类的。嘛~看不懂那个as3nui的要求。总之都能满足就是了。

2013.03.15 添加滑动细操作。以及更好的识别手势操作


基本用法：
import com.nuigesture.NuiGesture;
import com.nuigesture.event.GestureEvent;

NuiGesture.NuiAutoStart();
NuiGesture.addEventListener(GestureEvent.GESTURE,onGestureHandle);
private function onGestureHandle(e:GestureEvent )
{
	var s:String = "";
	s +=  "[" + e.data.from + "]";
	s +=  "s:" + e.data.speed;
	s +=  " d:" + e.data.direction;
	s +=  " t:" + e.data.type;		
	trace(s)	
}

就这么简单，所有功能封装完成，需要as3nui的kinect库，和 mssdk.ane文件导入到flash中。
demo1:http://v.youku.com/v_show/id_XNDk2NDU4MzA4.html
demo2:http://v.youku.com/v_show/id_XNTA4MTI5MjQ4.html
画面1停顿是因为后台在转换视频，以及屏幕分辨率过大，正常情况下速度正常，但是视频懒得再录了。

@airkinect-2-core
