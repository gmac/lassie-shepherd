﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.model{	import flash.events.EventDispatcher;		public class DataModelSet extends EventDispatcher	{		// protected		protected var _models:Object;		protected var _modelsList:Array;		protected var _modelClass:Class;				public function DataModelSet($class:Class):void		{			super();			_models = new Object();			_modelsList = new Array();			_modelClass = $class;		}		/**		* Destroys the model set.		* IMPORTANT: subclass must call super.destroy();		*/		public function destroy():void		{			for (var $j:String in _models)			{				DataModel(_models[$j]).destroy();				delete _models[$j];			}						_models = null;			_modelsList = null;			_modelClass = null;		}				/**		* Gets a model by Id, or creates and returns it if it does not exist.		*/		public function getModel($id:String, $create:Boolean=true):DataModel		{			if (contains($id))			{				return _models[$id] as DataModel;			}			else if ($create)			{				_models[$id] = _createNewModel($id);				_modelsList.push( _models[$id] );				return _models[$id];			}			return null;		}				/**		* Gets a model by numeric index within the set list.		*/		public function getModelAt($index:int):DataModel		{			if ($index >= 0 && $index < _modelsList.length)			{				return _modelsList[ $index ] as DataModel;			}			return null;		}				/**		* Gets the numeric index of a model.		*/		public function getModelIndex($model:DataModel):int		{			return _modelsList.indexOf($model.id);		}				/**		* Removes a model by Id from the set.		*/		public function removeModel($id:String):DataModel		{			if (contains($id))			{				var $model:DataModel = _models[$id] as DataModel;				delete _models[$id];								for (var $j:int=0; $j < _modelsList.length; $j++) {					if (DataModel(_modelsList[$j]).id == $id) {						_modelsList.splice($j, 1);						break;					}				}				return $model;			}			return null;		}				/**		* Creates a new data model for the set.		* Override method for custom model creation.		*/		protected function _createNewModel($id:String):DataModel		{			return new _modelClass($id);		}				/**		* Tests if set contains a model by the given Id.		*/		public function contains($id:String):Boolean		{			return _models.hasOwnProperty($id);		}				/**		* Gets a list of all model Id's contained within the set.		*/		public function get contents():Array		{			return _modelsList;		}				/**		* Gets the number of models contained within the set.		*/		public function get numModels():int		{			return _modelsList.length;		}				/**		* Parses a list of Id'd XML structures.		*/		internal function parse($list:XMLList):void		{			for each (var $element:XML in $list) {				getModel($element.@id).parse($element);			}		}				/**		* Performs a sort of the models index table with a named field.		*/		internal function sortModelsBy($field:String):void {			_modelsList.sortOn( $field );		}	}}