package com.nuigesture.core
{
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.geom.Vector3D;
	import com.as3nui.nativeExtensions.air.kinect.Kinect;
	import com.nuigesture.NuiGesture;
	import com.as3nui.nativeExtensions.air.kinect.events.UserEvent;
	import com.nuigesture.action.ActionPoint;
	import com.nuigesture.manager.ActionArrayManager;

	public class ActionCapture
	{
		//public static var aa:ActionCapture;
		private static var actionCatchTimer:Timer;
		private static var userLength:uint;
		private static var kinect:Kinect;

		private static var actionCatchCentrePoint:ActionPoint;
		private static var actionCatchPoint:ActionPoint;
		public static function init(kinectId:uint =0)
		{
			trace("ActionCapture:initializing,ActionCatchTime:"+(NuiSettings.ActionCatchTime));
			kinect = NuiGesture.getKinects(kinectId);
			actionCatchTimer = new Timer(NuiSettings.ActionCatchTime);
			userLength = 0;
			kinect.addEventListener(UserEvent.USERS_ADDED, userNumberChange);
			kinect.addEventListener(UserEvent.USERS_REMOVED, userNumberChange);
			startCatchAction();
		}

		public static function startCatchAction()
		{
			switch (userLength)
			{
				case 0 :
					//trace("ActionCapture:没有找到user");
					stopCatchAction();
					return;
					break;
				case 1 :
					stopCatchAction();
					actionCatchTimer.addEventListener(TimerEvent.TIMER,actionTimerHandle);
					actionCatchTimer.start();
					trace("ActionCapture:startCatchAction");
					break;
				case 2 :
					stopCatchAction();
					actionCatchTimer.addEventListener(TimerEvent.TIMER,actionTimerHandle);
					actionCatchTimer.start();
					trace("ActionCapture:startCatchAction");
					break;
				default :
					stopCatchAction();
					actionCatchTimer.addEventListener(TimerEvent.TIMER,actionTimerHandle);
					actionCatchTimer.start();
					trace("ActionCapture:超过2个user");
			}
		}
		public static function stopCatchAction()
		{

			try
			{
				actionCatchTimer.stop();
				actionCatchTimer.reset();
				actionCatchTimer.removeEventListener(TimerEvent.TIMER,actionTimerHandle);
				trace("ActionCapture:stopCatchAction");
			}
			catch (e: * )
			{
			}
		}
		
		private  static function actionTimerHandle(e:TimerEvent )
		{
			//trace("ActionCapture:tick..");
			if (userLength==1)
			{

				HandDistand.user = kinect.users[0];
				//trace("**********");
				actionCatchCentrePoint=new ActionPoint (0,
				    (kinect.users[0].leftShoulder.position.rgb.x + kinect.users[0].rightShoulder.position.rgb.x)/2,
				(kinect.users[0].leftShoulder.position.rgb.y + kinect.users[0].rightShoulder.position.rgb.y)/2,
				(kinect.users[0].leftShoulder.position.world.x + kinect.users[0].rightShoulder.position.world.x)/2,
				(kinect.users[0].leftShoulder.position.world.y + kinect.users[0].rightShoulder.position.world.y)/2,
				(kinect.users[0].leftShoulder.position.world.z + kinect.users[0].rightShoulder.position.world.z)/2);
				//trace("中心："+actionCatchCentrePoint.toString ());
				actionCatchPoint = new ActionPoint(HandDistand.leftHandDistand,
				  kinect.users[0].leftHand.position.rgb.x,
				  kinect.users[0].leftHand.position.rgb.y,
				  kinect.users[0].leftHand.position.world.x,
				  kinect.users[0].leftHand.position.world.y,
				  kinect.users[0].leftHand.position.world.z);
				ActionArrayManager.User1LeftHandActionArray.capture(actionCatchPoint,actionCatchCentrePoint);
				//trace("左手："+actionCatchPoint.toString ());
				actionCatchPoint = new ActionPoint(HandDistand.rightHandDistand,
				  kinect.users[0].rightHand.position.rgb.x,
				  kinect.users[0].rightHand.position.rgb.y,
				  kinect.users[0].rightHand.position.world.x,
				  kinect.users[0].rightHand.position.world.y,
				  kinect.users[0].rightHand.position.world.z);
				//trace("右手az："+actionCatchPoint.az);
				//trace("右手wz："+actionCatchPoint.worldZ);
				ActionArrayManager.User1RightHandActionArray.capture(actionCatchPoint,actionCatchCentrePoint);

			}
			if (userLength==2)
			{
				trace("ActionCapture:用户太多,请减少至一人。");
				return;



			}

		}
		public static function dispose()
		{
			stopCatchAction();
			actionCatchTimer.removeEventListener(TimerEvent.TIMER,actionTimerHandle);
			kinect.removeEventListener( UserEvent.USERS_ADDED, userNumberChange);
			kinect.removeEventListener( UserEvent.USERS_REMOVED, userNumberChange);
			actionCatchCentrePoint = null;
			actionCatchPoint = null;
			actionCatchTimer = null;
		}
		private static function userNumberChange(e:UserEvent )
		{
			//stopCatchAction();
			userLength = NuiGesture.getKinects().users.length;
			trace("ActionCapture:用户数发生变化，当前为:"+userLength ,userLength>1?"现在只是可以识别第一个人":"");
			startCatchAction();
		}
	}
}