package com.nuigesture.core
{
	import com.nuigesture.manager.ZoneManager;
	import com.nuigesture.action.GestureAction;
	import com.nuigesture.NuiGesture;

	public class ActionAnalysis
	{
		private static var detalTime:uint = NuiSettings.ActionAnalysisDetalTime;
		private static var judgeSpeed:Number = NuiSettings.GestureSpeedByRgb;
		private static var tapSpeed:Number =NuiSettings.ControlTapSpeed
		public static function analysis(e:ActionArray  )
		{
			//detalTime = NuiSettings.ActionCatchTime * NuiSettings.ActionAnalysisDetalTime
			//Special
			if (true)
			{
			}

			//trace("["+e._ActionArrayNodeName+"]["+ZoneManager.searchInZone(e.z)+"]:"+e.z);
			switch (ZoneManager.searchInZone(e.z))
			{
				case ZoneManager.ignoreZone :
					trace("ActionAnalysis:ignoreZone[不作处理]");
					break;
				case ZoneManager.gestureZone :
					//var dx:Number =(e.getActionPoint (3).worldX - e.getActionPoint (1).worldX) / detalTime//
					//var dy:Number =(e.getActionPoint (3).worldY - e.getActionPoint (1).worldY) / detalTime//
					var dx:Number =(e.getActionPoint (3).rgbX - e.getActionPoint (1).rgbX) / detalTime;//
					var dy:Number =-(e.getActionPoint (3).rgbY - e.getActionPoint (1).rgbY) / detalTime;//
					var ga:GestureAction;
					//trace("dx:"+dx.toFixed (3)+" dy:"+dy.toFixed (3))
					/*
					dx=+NuiSettings.ReviseSpeed;
					dy=+NuiSettings.ReviseSpeed;
					if (dx<0)
					{
					dx-=NuiSettings.ReviseSpeed;
					}
					if (dy<0)
					{
					dy -=  NuiSettings.ReviseSpeed;
					}
					*/
					if (dx>judgeSpeed)
					{

						if (dx>(judgeSpeed*2))
						{
							ga = new GestureAction(e._ActionArrayNodeName,dx,"right",1);
							NuiEventHandle.dispatchGuestEvent(ga);
							//trace("**GestureEvent[→→]"+dx);
							return;
						}
						ga = new GestureAction(e._ActionArrayNodeName,dx,"right",0);
						NuiEventHandle.dispatchGuestEvent(ga);
						//trace("**GestureEvent[→]"+dx);
						return;
					}
					if (dx<(-judgeSpeed))
					{
						if (dx<(-judgeSpeed*2))
						{
							ga = new GestureAction(e._ActionArrayNodeName, -  dx,"left",1);
							NuiEventHandle.dispatchGuestEvent(ga);
							//trace("**GestureEvent[←←]"+dx);
							return;
						}
						ga = new GestureAction(e._ActionArrayNodeName, -  dx,"left",0);
						NuiEventHandle.dispatchGuestEvent(ga);
						//trace("**GestureEvent[←]"+dx);
						return;

					}
					if (dy>judgeSpeed)
					{
						if (dy>(judgeSpeed*2))
						{
							ga = new GestureAction(e._ActionArrayNodeName,dy,"up",1);
							NuiEventHandle.dispatchGuestEvent(ga);
							//trace("**GestureEvent[↑↑]"+dy);
							return;
						}
						ga = new GestureAction(e._ActionArrayNodeName,dy,"up",0);
						NuiEventHandle.dispatchGuestEvent(ga);
						//trace("**GestureEvent[↑]"+dy);
						return;
					}
					if (dy<(-judgeSpeed))
					{
						if (dy<(-judgeSpeed*2))
						{
							ga = new GestureAction(e._ActionArrayNodeName, -  dy,"down",1);
							NuiEventHandle.dispatchGuestEvent(ga);
							//trace("**GestureEvent[↓↓]:"+dy);
							return;
						}
						ga = new GestureAction(e._ActionArrayNodeName, -  dy,"down",0);
						NuiEventHandle.dispatchGuestEvent(ga);
						//trace("**GestureEvent[↓]:"+dy);
						return;

					}
					break;
				case ZoneManager.controlZone :
					/*var daz:Number =(e.getActionPoint (2).worldZ- e.getActionPoint (1).worldZ)-(e.getActionPoint (3).worldZ- e.getActionPoint (2).worldZ);
					var reviseDaz:Number =daz/detalTime
					trace(reviseDaz);
					if(reviseDaz >tapSpeed){
						trace("点击了");
					}*/
					break;
				case ZoneManager.selectionZone :
					break;
				default :
					break;
			}
		}
		public static function dispose( )
		{

		}
	}
}