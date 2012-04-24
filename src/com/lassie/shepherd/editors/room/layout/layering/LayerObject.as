package com.lassie.shepherd.editors.room.layout.layering
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.lassie.shepherd.data.room.*;
	import com.lassie.shepherd.editors.room.interfaces.ILayer;
	import com.lassie.shepherd.editors.room.RoomController;
	import com.lassie.shepherd.editors.room.events.RoomEditorEvent;
	
	public class LayerObject extends LayerProperties implements ILayer
	{
	// --------------------------------------------------
	//  Constructor
	// --------------------------------------------------
		
		public function LayerObject(dat:LayerData):void
		{
			super(dat);
		}

	// --------------------------------------------------
	//  Initialization
	// --------------------------------------------------
		
		protected override function init():void
		{
			_hit.addEventListener(MouseEvent.MOUSE_DOWN, this.handleHitDown);
			_img.addEventListener(MouseEvent.MOUSE_DOWN, this.handleImgDown);
			_reg.addEventListener(MouseEvent.MOUSE_DOWN, this.handleLayerDown);
			_tar.addEventListener(RoomEditorEvent.UPDATE_LAYER_TARGET, this.handleUpdateTarget);
		}
		
		protected override function uninit():void
		{
			super.uninit();
			_hit.removeEventListener(MouseEvent.MOUSE_DOWN, this.handleHitDown);
			_img.removeEventListener(MouseEvent.MOUSE_DOWN, this.handleImgDown);
			_reg.removeEventListener(MouseEvent.MOUSE_DOWN, this.handleLayerDown);
			_tar.removeEventListener(RoomEditorEvent.UPDATE_LAYER_TARGET, this.handleUpdateTarget);
			_tar.dispose();
			
			_hit = null;
			_img = null;
			_reg = null;
			_tar = null;
		}

	// --------------------------------------------------
	//  Interface methods
	// --------------------------------------------------
		
		public function select():void
		{
			// if a selected layer exists
			if (RoomController.selectedLayer != null)
			{
				// deselect that layer
				RoomController.selectedLayer.deselect();
			}
			
			// store new reference to this layer
			RoomController.selectedLayer = this;

			// set selected appearance
			setAsSelected(true);
		}
		
		public function deselect():void
		{
			setAsSelected(false);
		}

		protected override function update():void
		{
			// notify of update
			RoomController.updateLayerControls();
			
			// update display appearance
			updateDisplay();
		}
		
	// --------------------------------------------------
	//  HIT Event handlers
	// --------------------------------------------------
		
		private function handleHitDown(evt:MouseEvent):void
		{
			if (evt.shiftKey && selected)
			{
				_hit.resizing = true;
				
				// respond to mouse-up with hit-specific action
				stage.addEventListener(MouseEvent.MOUSE_UP, this.handleHitUp);
				
				// set enterframe for active data update
				addEventListener(Event.ENTER_FRAME, this.handleHitResize);
			}
			else if (evt.ctrlKey && !locked && selected)
			{
				_hit.startDrag(false);

				// respond to mouse-up with hit-specific action
				stage.addEventListener(MouseEvent.MOUSE_UP, this.handleHitUp);
				
				// set enterframe for active data capture
				addEventListener(Event.ENTER_FRAME, this.handleHitShift);
			}
			else
			{
				handleLayerDown(null);
			}
		}
		
		private function handleHitUp(evt:MouseEvent):void
		{
			// stop listening for mouse-up
			stage.removeEventListener(MouseEvent.MOUSE_UP, this.handleHitUp);
			
			// if hit area was resizing
			if (_hit.resizing)
			{
				_hit.resizing = false;
				
				// reorient hit area to register in the upper-left
				_hit.reorient();
				
				// capture new data configuration
				setHitSize(_hit.width, _hit.height);
				
				// cancel active data capture
				removeEventListener(Event.ENTER_FRAME, this.handleHitResize);
			}
			else
			{
				_hit.stopDrag();
				
				// cancel active data update
				removeEventListener(Event.ENTER_FRAME, this.handleHitShift);
			}
			
			// capture new hit coordinates
			setHitPos(_hit.x, _hit.y);
			
			// update control panel with new data
			RoomController.updateLayerControls();
		}
		
		private function handleHitResize(evt:Event):void
		{
			_hit.resize();
			
			// capture new data without display update
			setHitSize(_hit.width, _hit.height);
			
			// update control panel with hit data
			RoomController.updateHitControls();
		}
		
		private function handleHitShift(evt:Event):void
		{
			// capture new data without display update
			setHitPos(_hit.x, _hit.y);
			
			// update control panel with hit data
			RoomController.updateHitControls();
		}
		
	// --------------------------------------------------
	//  IMAGE Event handlers
	// --------------------------------------------------
		
		private function handleImgDown(evt:MouseEvent):void
		{
			if (evt.shiftKey && !locked && selected)
			{
				//_hit.enableResize(true);
				
				// respond to mouse-up with hit-specific action
				//stage.addEventListener(MouseEvent.MOUSE_UP, this.handleImgUp);
			}
			else if (evt.ctrlKey && !locked && selected)
			{
				_img.startDrag(false);

				// respond to mouse-up with hit-specific action
				stage.addEventListener(MouseEvent.MOUSE_UP, this.handleImgUp);
				
				// set enterframe for active data update
				addEventListener(Event.ENTER_FRAME, this.handleImageShift);
			}
			else
			{
				handleLayerDown(null);
			}
		}
		
		private function handleImgUp(evt:MouseEvent):void
		{
			// cancel mouse-up and stop dragging
			stage.removeEventListener(MouseEvent.MOUSE_UP, this.handleImgUp);
			_img.stopDrag();
			
			// capture image data without updating display
			setImagePos(_img.x, _img.y);
			setImageScale(_img.scaleX, _img.scaleY);
			
			// clear enterframe for active data update
			removeEventListener(Event.ENTER_FRAME, this.handleImageShift);

			// update control panel with new data
			RoomController.updateLayerControls();
		}
		
		private function handleImageShift(evt:Event):void
		{
			// capture image data without updating display
			setImagePos(_img.x, _img.y);
			
			// update control panel with image data
			RoomController.updateImageControls();
		}
		
	// --------------------------------------------------
	//  LAYER Event handlers
	// --------------------------------------------------
		
		private function handleLayerDown(evt:MouseEvent):void
		{
			// if layer is not already selected
			if (!selected)
			{
				// call for layer to be selected
				select();
			}

			// if layer is not locked
			if (!locked)
			{
				// start layer drag
				startDrag(false);
				addEventListener(Event.ENTER_FRAME, this.handleLayerDrag);
				stage.addEventListener(MouseEvent.MOUSE_UP, this.handleLayerUp);
			}
		}
		
		private function handleLayerUp(evt:MouseEvent):void
		{
			stopDrag();
			removeEventListener(Event.ENTER_FRAME, this.handleLayerDrag);
			stage.removeEventListener(MouseEvent.MOUSE_UP, this.handleLayerUp);

			// snap to nearest whole pixel
			x = Math.round(x);
			y = Math.round(y);
		}
		
		protected function handleLayerDrag(evt:Event):void
		{
			// update control panel with position data
			RoomController.updatePositionControls();
			applyScaleFilter();
			applyColorFilter();
			applyFocusFilter();
		}
		
	// --------------------------------------------------
	//  TARGET Event handlers
	// --------------------------------------------------
		
		private function handleUpdateTarget(evt:Event):void
		{
			floorX = _tar.x;
			floorY = _tar.y;
		}
	}
}