package core {
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import com.arthwood.components.ComboBox;
	import com.arthwood.components.Input;
	import com.arthwood.data.ListItemData;
	import com.arthwood.utils.UtilsArray;
	import com.arthwood.utils.UtilsString;
	import view.Response;
	import view.Spinner;
	
	/**
	 * ...
	 * @author Artur Bilski
	 */
	public class View extends MovieClip {
		public var inputUrl:Input;
		public var inputData:Input;
		public var response:Response;
		public var spinner:Spinner;
		public var cmbMethod:ComboBox;
		public var btnSend:SimpleButton;
		
		private var urlLoader:URLLoader;
		private var urlRequest:URLRequest;
		
		private const SUPPORTED_METHODS = ['GET', 'POST'];
		private const DEFAULT_URL = 'http://localhost:3000/';
		//private const DEFAULT_DATA = 'role=Admin&login=admin&password=asdf1234';
		private const DEFAULT_DATA = '';
		
		public function View() {
			cmbMethod.items = [
				new ListItemData('GET'),
				new ListItemData('POST'),
				new ListItemData('PUT'),
				new ListItemData('DELETE')
			];
			cmbMethod.selectedIndex = 0;
			btnSend.addEventListener(MouseEvent.CLICK, onSend);
			inputUrl.text = DEFAULT_URL;
			inputData.text = DEFAULT_DATA;
			urlRequest = new URLRequest();
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onResponse);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
		}
		
		private function onSend(e_:MouseEvent):void {
			var url:String = inputUrl.text;
			var data:String = inputData.text;
			var method:String = String(cmbMethod.selectedItem.value);
			var supportedMethod:Boolean = UtilsArray.includes(SUPPORTED_METHODS, method);
			
			if (!UtilsString.isEmpty(data)) {
				if (!supportedMethod) {
					data += ('&_method=' + method);
				}
				
				urlRequest.data = data;
			}
			
			urlRequest.url = url;
			urlRequest.method = supportedMethod ? method : 'POST';
			
			urlLoader.load(urlRequest);
			
			btnSend.enabled = false;
			spinner.spin();
		}
		
		private function onError(e_:IOErrorEvent):void {
			setResponse(e_.text);
		}
		
		private function onResponse(e_:Event):void {
			setResponse(URLLoader(e_.target).data);
		}
		
		private function setResponse(text_:String):void {
			btnSend.enabled = true;
			spinner.unspin();
			
			response.tfText.text = text_;
			response.textScroll.updateVisibility();
		}
	}
}
