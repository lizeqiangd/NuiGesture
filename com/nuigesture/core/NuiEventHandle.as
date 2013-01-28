package com.nuigesture.core
{
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.EventDispatcher;
	import com.nuigesture.action.GestureAction;
	import com.nuigesture.event.GestureEvent;
	import com.nuigesture.NuiGesture;

	public class NuiEventHandle
	{

		private static var EventIntervalTimer:Timer;
		private static var CoolDown:Boolean = false;
		private static var eventDispatch:EventDispatcher;
		public static function init( )
		{
			CoolDown = true;
			eventDispatch = NuiGesture.eventDispatch;
			EventIntervalTimer = new Timer(NuiSettings.ActionInterval,1);
			EventIntervalTimer.addEventListener(TimerEvent.TIMER_COMPLETE,TimerHandle);
		}
		public static function dispatchGuestEvent(e:GestureAction )
		{
			//eventDispatch.dispatchEvent(new GestureEvent (GestureEvent.GESTURE,e));
			if (CoolDown)
			{
				CoolDown = false;
				eventDispatch.dispatchEvent(new GestureEvent (GestureEvent.GESTURE,e));
				EventIntervalTimer.start();
				//trace("NuiEventHandle:EventDispatched,coolingdown");
			}
		}
		public static function dispatchControlEvent( )
		{
			if (CoolDown)
			{
				//eventDispatch.dispatchEvent();
				CoolDown = false;
				EventIntervalTimer.start();
			}
		}
		public static function dispose()
		{
			EventIntervalTimer.stop();
			EventIntervalTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,TimerHandle);
			EventIntervalTimer = null;
			CoolDown = false;
		}
		private static function TimerHandle(e:TimerEvent )
		{
			//trace("NuiEventHandle:Cooldowned");

			EventIntervalTimer.reset();
			CoolDown = true;
		}

	}

}