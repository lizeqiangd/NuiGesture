package com.nuigesture.manager
{
	//import com.as3nui.nativeExtensions.air.kinect.Kinect;
	import com.nuigesture.core.ActionArray;
	import com.nuigesture.action.ActionPoint;
	import com.nuigesture.core.ActionAnalysis;
	import com.nuigesture.event.NuiEvent;

	public class ActionArrayManager
	{
		//public static var kinect:Kinect;
		private static var _User1RightHandActionArray:ActionArray;
		private static var _User1LeftHandActionArray:ActionArray;
		private static var _User2RightHandActionArray:ActionArray;
		private static var _User2LeftHandActionArray:ActionArray;
		//private static var user1id:uint 
		//private static var user2id:uint 
		private static var analysisU1R:Boolean = false;
		private static var analysisU1L:Boolean = false;
		private static var analysisU2R:Boolean = false;
		private static var analysisU2L:Boolean = false;
		public function ActionArrayManager()
		{
		}
		public static function init()
		{
			_User1RightHandActionArray = new ActionArray("u1r",3);
			_User1LeftHandActionArray = new ActionArray("u1l",3);
			_User2RightHandActionArray = new ActionArray("u2r",3);
			_User2LeftHandActionArray = new ActionArray("u2l",3);
		}
		public static function configAnalysis(u1r:Boolean=false ,u1l:Boolean=false ,u2r:Boolean=false ,u2l:Boolean=false )
		{
			analysisU1R = u1r?
			_User1RightHandActionArray.isAnalysis =true:
			_User1RightHandActionArray.isAnalysis=false;
			
			/*analysisU1L = u1l?
			_User1LeftHandActionArray.addEventListener(NuiEvent.ACTION_CAPTURED,analysisActions):
			_User1LeftHandActionArray.removeEventListener(NuiEvent.ACTION_CAPTURED,analysisActions);
			
			analysisU2R = u2r?
			_User2RightHandActionArray.addEventListener(NuiEvent.ACTION_CAPTURED,analysisActions):
			_User2RightHandActionArray.removeEventListener(NuiEvent.ACTION_CAPTURED,analysisActions);
			
			analysisU2L = u2l?
			_User2LeftHandActionArray.addEventListener(NuiEvent.ACTION_CAPTURED,analysisActions):
			_User2LeftHandActionArray.removeEventListener(NuiEvent.ACTION_CAPTURED,analysisActions);
			*/
		}
		public static function dispose()
		{
			//_User1RightHandActionArray.removeEventListener(NuiEvent.ACTION_CAPTURED,analysisActions);
			//_User1LeftHandActionArray.removeEventListener(NuiEvent.ACTION_CAPTURED,analysisActions);
			//_User2RightHandActionArray.removeEventListener(NuiEvent.ACTION_CAPTURED,analysisActions);
			//_User2LeftHandActionArray.removeEventListener(NuiEvent.ACTION_CAPTURED,analysisActions);
			_User1RightHandActionArray.dispose();
			_User1LeftHandActionArray.dispose();
			_User2RightHandActionArray.dispose();
			_User2LeftHandActionArray.dispose();
		}
		private static function analysisActions(e:NuiEvent )
		{
			ActionAnalysis.analysis(e.data);
		}
		public static function get User1RightHandActionArray():ActionArray
		{
			//analysisU1R ? ActionAnalysis.analysis(_User1RightHandActionArray):null;
			return _User1RightHandActionArray;
		}
		public static function get User1LeftHandActionArray():ActionArray
		{
			//analysisU1L ? ActionAnalysis.analysis(_User1LeftHandActionArray):null;
			return _User1LeftHandActionArray;
		}
		public static function get User2RightHandActionArray():ActionArray
		{
			//analysisU2R ? ActionAnalysis.analysis(_User2RightHandActionArray):null;
			return _User2RightHandActionArray;
		}
		public static function get User2LeftHandActionArray():ActionArray
		{
			//analysisU2L ? ActionAnalysis.analysis(_User2LeftHandActionArray):null;
			return _User2LeftHandActionArray;
		}
	}
}