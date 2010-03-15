package core {
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import pl.arthwood.components.ComboBox;
	import pl.arthwood.components.Input;
	import pl.arthwood.data.ListItemData;
	import pl.arthwood.utils.UtilsArray;
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
			var data:String = inputData.text;
			var method:String = String(cmbMethod.selectedItem.value);
			
			if (!UtilsArray.isInArray(SUPPORTED_METHODS, method)) {
				data += ('&_method=' + method);
			}
			
			urlRequest.url = inputUrl.text;
			urlRequest.data = data;
			urlRequest.method = method;
			
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
			response.contentSimpleVScroll.updateVisibility();
		}
	}
}
