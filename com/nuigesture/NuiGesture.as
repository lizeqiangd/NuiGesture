package com.nuigesture
{
	import flash.events.EventDispatcher;
	import com.nuigesture.manager.ZoneManager;
	import flash.display.BitmapData;
	import flash.events.Event;
	import com.as3nui.nativeExtensions.air.kinect.Kinect;
	import com.as3nui.nativeExtensions.air.kinect.KinectSettings;
	import com.as3nui.nativeExtensions.air.kinect.constants.CameraResolution;
	import com.as3nui.nativeExtensions.air.kinect.events.*;
	import com.nuigesture.manager.ActionArrayManager;
	import com.nuigesture.core.ActionCapture;
	import com.nuigesture.core.ActionAnalysis;
	import com.nuigesture.core.NuiEventHandle;

	public class NuiGesture
	{
		private static var _device:Kinect;
		private static var _eventDispatch:EventDispatcher = new EventDispatcher  ;
		private static var _kinectSettings:KinectSettings;

		/*private static var testTimer:uint = 0;
		private static var testTimerId:uint = 0;
		public static function countingStart()
		{
		var s:Date =new Date();
		testTimer = s.time;
		trace("NuiGestureTestTimer["+testTimerId+"]:Start");
		}
		public  static function countingStop()
		{
		var s:Date =new Date();
		trace("NuiGestureTestTimer["+testTimerId+"]:"+uint(s.time-testTimer));
		testTimerId++;
		}*/
		public static function addEventListener(type:String ,listener:Function ,userCapture=false,priority=0,userWeakReference=false)
		{
			_eventDispatch.addEventListener(type,listener,userCapture,priority,userWeakReference);
		}
		public static function removeEventListener(type:String,listener:Function,userCapture=false)
		{
			_eventDispatch.removeEventListener(type,listener,userCapture);
		}
		public static function configWithKinectSettings(e:KinectSettings )
		{
			_kinectSettings = e;
		}
		public static function configWithDefault():KinectSettings
		{
			trace("NuiGesture:configWithDefault");
			_kinectSettings= new KinectSettings();
			_kinectSettings.rgbEnabled = false;
			_kinectSettings.rgbResolution = CameraResolution.RESOLUTION_640_480;
			_kinectSettings.depthEnabled = true;
			_kinectSettings.pointCloudEnabled = false;
			_kinectSettings.depthResolution = CameraResolution.RESOLUTION_320_240;
			_kinectSettings.depthShowUserColors = true;
			_kinectSettings.userEnabled = true;
			_kinectSettings.skeletonEnabled = true;
			return _kinectSettings;
		}
		public static function initialize():void
		{
			trace("NuiGesture:initializing....");
			if (! Kinect.isSupported())
			{
				trace("NuiGesture:Kinect not supported.");
				return;
			}
			_device = getKinects();
			//device.addEventListener(DeviceEvent.STARTED, DeviceEventHandle);
			//device.addEventListener(DeviceEvent.STOPPED, DeviceEventHandle);
			//device.addEventListener(DeviceEvent.CONNECTED, DeviceEventHandle);
			//device.addEventListener(DeviceEvent.DISCONNECTED, DeviceEventHandle);
			//device.addEventListener(CameraImageEvent.RGB_IMAGE_UPDATE, rgbImage);
			//device.addEventListener(CameraImageEvent.DEPTH_IMAGE_UPDATE, depthImage);
			//device.addEventListener(UserEvent.USERS_ADDED, added);
			//device.addEventListener(PointCloudEvent.POINT_CLOUD_UPDATE,pointCloud);
			//device.addEventListener(UserEvent.USERS_REMOVED, removed);
			//device.addEventListener(DeviceInfoEvent.INFO, dieinfo);


			//addEventListener(Event.ENTER_FRAME, update, false, 0, true);
			//this.setChildIndex(tx_trace,this.numChildren-1);
			//test();
			//this.setChildIndex(depth,0);
			//this.setChildIndex(rgb,0);
			_device.start(_kinectSettings);
		}
		/*public static function startActionCapture()
		{
		}
		public static function startActionAnalysis()
		{
		}*/
		public static function NuiAutoStart()
		{
			configWithDefault();
			initialize();
			NuiStart();
		}
		public static function NuiStart()
		{
			trace("NuiGesture:Starting....");
			ZoneManager.init();
			ActionArrayManager.init();
			ActionCapture.init();
			ActionArrayManager.configAnalysis(true);
			NuiEventHandle.init();
		}
		public static function NuiPause()
		{
			ActionCapture.stopCatchAction();
		}
		public static function NuiRestart()
		{

			ActionCapture.startCatchAction();
		}
		public static function dispose()
		{
			trace("NuiGesture:Disposing....");
			ActionArrayManager.dispose();
			ZoneManager.dispose();
			ActionCapture.dispose();
			ActionAnalysis.dispose();
			NuiEventHandle.dispose();
			_device.dispose();
		}

		public static function cameraElevationAngle(angel:int,kinectId:uint=0  )
		{
			angel > 30 ? 30:angel;
			angel < -15 ? -15:angel;
			getKinects(kinectId).cameraElevationAngle = angel;

		}
		public static function getRgbCamera(kinectID:uint):BitmapData
		{
			return new BitmapData (1,1);
		}
		public static function getDepthCamera(kinectID:uint):BitmapData
		{
			return new BitmapData (1,1);
		}
		public static function getKinects(u:uint=0 ):Kinect
		{
			return Kinect.getDevice(u);
		}
		public static function get eventDispatch():EventDispatcher
		{
			return _eventDispatch;
		}

	}
}