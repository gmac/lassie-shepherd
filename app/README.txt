Lassie Shepherd
---------------
@author Greg MacWilliam
@version Shepherd v2.0
@release 08/14/11



UPGRADE INSTRUCTIONS
____________________
Existing Lassie Shepherd users face some critical upgrade considerations. Do the following:

1) Review the updated documentation for the <skip> control. This control has completely changed since previous Lassie builds. It's far simpler and more practical now, however it will require existing implementations of the <skip> control to be revised. If you have a working project that uses the v1.1 <skip> command, be mindful that all instance of that command will need to update to mirror the new methodology.

2) Note that the turn-to-face-object methodology has changed within Lassie Shepherd. Previously, the avatar would move to a layer's map point, and then turn to face the layer's registration point. This frequently forced you to place a layer's registration in awkward places to make a layout work. Well, there's good news and bad news. The good news is that turn-to-face and object is now managed through a direct control within the editor. The bad news is that any previously configured map/registration point turning relationships are now ignored. You WILL need to go through your whole game and update the turn-to-face layer control for every object in every room, then republish all game data with the revised configuration. While this is a painstaking update, the long-term control benefit is huge. The new system is much more flexible and responsive.

3) Copy all files from the "www/flash/" folder into your Shepherd instance. This will update all of your application components.

4) Update your "ui.fla" to include a "uiSkip" interface element (see "www/resources/ui.fla"), then republish and push your updated "ui.swf" to your project library. Lassie version 2.0 includes a built-in sequence skip button as part of the application's default interface. This new UI element MUST be present within your project's UI SWF library or your project will not load. You may copy the "uiSkip" button element out of the new provided UI template document, paste it into your project's "ui.fla" file, and republish your UI library with that.

5) Copy the updated "menu.swf" from "www/template/lib/menu.swf" into all of your Lassie project instances.

6) Compare the configuration of the "www/template/xml/system.xml" file against that of all of your projects. Add nodes for any missing properties that your projects do not have (copy values from the template "system.xml"). You'll need to add the following nodes to each of your projects' "system.xml" files:
 <mediaBaseURL/>
 <xmlBaseUR/L>
 <allowXMLCache/>
 <staticWindow/>
 <menuGraphicsQuality/>
 <legal/>

7) Finally, start up the Shepherd editor for each of your projects, and update the interaction dialect strings (managed on the game setup screen... which is the first view at startup) with the following tokens: "#verb#", "#noun#", "#item#". Previously these tokens only had a single hash mark at the front. This update fixes a long-standing bug with the Lassie Player not honoring dialect configurations set within the Shepherd editor.

8) Republish all of your SWF libraries that import and utilize the LassieEvent class. Also, review the "Calling ANIMATION_COMPLETE" section of the Lassie XML Scripting document for Flash 10 methodology considerations.


GETTING STARTED
_______________
@see docs/Lassie_Shepherd_Manual.pdf

System requirements and installation instructions are included within the manual. Also, review the section about known bugs and work arounds before starting development on a new project.

Please promote peer-to-peer support at http://lassie.10.forumer.com. More specifically, please do NOT email the developer with a laundry list of support questions. It only frustrates both of us. Multiple emails do not increase chances of a reply. So again, please promote peer-to-peer support at http://lassie.10.forumer.com.



VERSION HISTORY
---------------
- v2.0
  - UI Console Selector Support
  - Curtain color control.

- 08/19/10, v1.2: Removal of the watermark, "Continue Game" feature, custom item context summaries, cross-domain networking.
- 02/13/10, v1.1: Adding engine settings, new game menu, and lots of new scripting features.
- 10/16/09, v1.0: first public beta.
- 06/24/09, v0.2: demo release (closed beta).
- 04/17/09, v0.1: first release (closed beta).



LICENSE
-------
Released under the Creative Commons Attribution-Noncommercial-Share Alike 3.0 Unported agreement <http://creativecommons.org/licenses/by-nc-sa/3.0/>. The shorthand version states:

You are free to use, share, and adapt the Lassie Shepherd system to your needs, under the following conditions (as stated fully within the license text, and elaborated upon here):

 1) Credit for engine programming must be given to Greg MacWilliam, author and architect of the Lassie Shepherd system. In addition, all third-party resources that are utilized by the Lassie Shepherd system must be credited as well. See "Production Credits" within the Lassie Shepherd manual for a complete and up-to-date list of all third-party contributions.

 2) You may NOT use this work for commercial purposes. Any games which incorporate the Lassie Shepherd system (in any capacity) may not generate profit directly or indirectly through sales or advertising. This extends to the context in which a Lassie game is displayed: a Lassie game may only be placed on a web page if it is free of advertising.

 3) If you build upon the Shepherd system in any way --including (but not limited to) use of Flash, XML, PHP, or documentation resources-- then you may only distribute the resulting work only under the same or similar license to this one (attribution, noncommercial, share-alike).

 4) The Lassie Player incorporates third-party code libraries with independent licensing agreements. At the time of this writing, all third-party resources used within the Lassie Player are assumed to be freely available under open sources licenses WITH THE EXCEPTION of GreenSock's "TweenLite". However, the game developer (you) is responsible for reviewing ALL third-party code licensing agreements to make sure that the game developer's project honors all third-party license considerations. The Lassie Shepherd project and its creator, Greg MacWilliam, take no responsibility for Lassie developers who fail to comply with third party licensing agreements while developing with the Lassie system. For a complete list of third party contributions, see the "Production Credits" section of the Lassie Shepherd Manual.

So: Lassie Shepherd and its resources are for personal, non-commercial use in this public release. In the future, commercial licensing arrangements may become available.



PLEASE & THANK YOU
------------------
I've disabled the watermark within Shepherd. It was originally designed to encourage third-party developers to report their projects back in to the Lassie project. However, I think it turned more developers away from Shepherd than it did encourage them to write in. So, I've gone back to the honor system. If you build something cool with Lassie, please email me about it. The rest of us would really like to know what's being built with the engine!