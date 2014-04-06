/**
* Lassie Engine
* @author Greg MacWilliam.
* @translation ??
*/
package com.lassie.menu.format
{
	/**
	* Lassie Player Game Menu.
	*/
	final public class LabelTextSpanish extends LabelText
	{
		public function LabelTextSpanish():void
		{
			super();
			
			languageTitle = "Español";
			
			// Panel headers
			loadHeader = "Cargar";
			saveHeader = "Guardar";
			optionsHeader = "Opciones";
			helpHeader = "Ayuda";
			legalHeader = "Acuerdo de licencia";
						
			// Button labels
			continueButton = "Continuar";
			resumeButton = "Reanudar";
			newButton = "Nuevo";
			loadButton = "Cargar";
			saveButton = "Guardar";
			optionsButton = "Opciones";
			helpButton = "Ayuda";
			quitButton = "Salir";
			doneButton = "Volver";
			confirmButton = "Aceptar";
			cancelButton = "Cancelar";
			legalButton = "Continuar";
			
			// Control labels
			musicVolumeControl = "Volumen de la música";
			fxVolumeControl = "Volumen de los efectos";
			voiceVolumeControl = "Volumen de las voces";
			subtitleSpeedControl = "Velocidad de los subtítulos";
			subtitleToggleControl = "Activar subtítulos";
			subtitleLanguageControl = "Idioma de los subtítulos";
			voiceToggleControl = "Activar voces";
			fullscreenControl = "Pantalla completa";
			graphicsQualityControl = "Calidad gráfica";
			legalConfirmControl = "He leído y acepto todos los términos.";
			
			// Confirmation messages
			newGameConfirm = "¿Estás seguro de que quieres empezar una partida nueva?";
			loadGameConfirm = "¿Estás seguro de que quieres cargar una partida?";
			saveGameConfirm = "¿Sobrescribir los datos existentes?";
			quitConfirm = "¿Estás seguro de que quieres salir?";
			
			// Status messages
			newGameStatus = "Empezando...";
			loadGameStatus = "Cargando...";
			saveGameStatus = "Guardando...";
			quitStatus = "";
			
			// Words 
			fullScreenOff = "DESACTIVADA";
			fullScreenCenter = "CENTRADA";
			fullScreenFull = "COMPLETA";
			graphicsQualityHigh = "ALTA";
			graphicsQualityFast = "RÁPIDA";
		}
	}
}

