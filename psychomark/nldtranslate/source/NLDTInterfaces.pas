unit NLDTInterfaces;

{
  :: NLDTInterfaces contains the interfaces used for internal communication.
  :: Interfaces are the *ONLY* way in which data may be passed between
  :: components to allow any developer to extend the functionality of
  :: NLDTranslate without necessarily descending from one of the custom
  :: component classes.

  :$
  :$
  :$ NLDTranslate is released under the zlib/libpng OSI-approved license.
  :$ For more information: http://www.opensource.org/
  :$ /n/n
  :$ /n/n
  :$ Copyright (c) 2002 M. van Renswoude
  :$ /n/n
  :$ This software is provided 'as-is', without any express or implied warranty.
  :$ In no event will the authors be held liable for any damages arising from
  :$ the use of this software.
  :$ /n/n
  :$ Permission is granted to anyone to use this software for any purpose,
  :$ including commercial applications, and to alter it and redistribute it
  :$ freely, subject to the following restrictions:
  :$ /n/n
  :$ 1. The origin of this software must not be misrepresented; you must not
  :$ claim that you wrote the original software. If you use this software in a
  :$ product, an acknowledgment in the product documentation would be
  :$ appreciated but is not required.
  :$ /n/n
  :$ 2. Altered source versions must be plainly marked as such, and must not be
  :$ misrepresented as being the original software.
  :$ /n/n
  :$ 3. This notice may not be removed or altered from any source distribution.

  :! NLDTranslate developers, all interfaces are reference-counted,
  :! make sure you implement _AddRef and _Release!
}

{$I NLDTDefines.inc}

interface
const
  IID_INLDTInterface:       TGUID = '{87897FA0-613C-4B8F-8332-307E404D7039}';
  IID_INLDTEventSink:       TGUID = '{87897FA1-613C-4B8F-8332-307E404D7039}';
  IID_INLDTManager:         TGUID = '{87897FB0-613C-4B8F-8332-307E404D7039}';
  IID_INLDTranslate:        TGUID = '{87897FB1-613C-4B8F-8332-307E404D7039}';
  IID_INLDTTreeItem:        TGUID = '{87897FB2-613C-4B8F-8332-307E404D7039}';
  IID_INLDTEvent:           TGUID = '{87897FF0-613C-4B8F-8332-307E404D7039}';
  IID_INLDTFileChangeEvent: TGUID = '{87897FF1-613C-4B8F-8332-307E404D7039}';
  IID_INLDTTreeWalkEvent:   TGUID = '{87897FF2-613C-4B8F-8332-307E404D7039}';

type
  // Forward declarations
  INLDTEvent            = interface;
  INLDTFileChangeEvent  = interface;
  INLDTTreeWalkEvent    = interface;

  {
    :$ Abstract interface for other NLDTranslate interfaces

    :: INLDTInterface descends from either IUnknown or IInterface, depending
    :: on the compiler version. No other functionality is implemented
    :: at this point.
  }
  INLDTInterface        = interface({$IFDEF NLDT_D6}IInterface{$ELSE}IUnknown{$ENDIF})
    ['{87897FA0-613C-4B8F-8332-307E404D7039}']
  end;

  {
    :$ Interface for event-enabled objects

    :: INLDTEventSink specifies the methods needed to register and unregister
    :: event interfaces.

    :! Any object which implements this interface MUST keep a list of
    :! all registered events and call the Detach method for each of those
    :! before being destroyed. This prevents dangling pointers if one of the
    :! event objects still hold a reference to the object.
    :! When calling the Detach procedure for each event object, make sure
    :! you traverse the list in reverse to prevent problems when the event
    :! object calls UnregisterEvent.
  }
  INLDTEventSink        = interface(INLDTInterface)
    ['{87897FA1-613C-4B8F-8332-307E404D7039}']
    //:$ Registers an event interface
    //:: Call RegisterEvent to add an event object to the events list of
    //:: the object implementing INLDTEventSink. The object is free to
    //:: determine when and if any events should be activated.
    procedure RegisterEvent(const AEvent: INLDTEvent); stdcall;

    //:$ Unregisters an event interface
    //:: Call UnregisterEvent to unregister a previously registered
    //:: event object. This object will no longer receive any events.
    procedure UnregisterEvent(const AEvent: INLDTEvent); stdcall;
  end;

  {
    :$ Manager interface.

    :: INLDTManager provides the interface for language-file management and
    :: distribution among the translators.
  }
  INLDTManager          = interface(INLDTEventSink)
    ['{87897FB0-613C-4B8F-8332-307E404D7039}']
    procedure AddFile(const AFilename: String); stdcall;
    procedure RemoveFile(const AFilename: String); stdcall;
    procedure ClearFiles(); stdcall;

    procedure LoadFromPath(const APath, AFilter: String;
                           const ASubDirs: Boolean = False); stdcall;
  end;

  {
    :$ Translator interface.

    :: INLDTranslate provides the interface to the translator. It is used
    :: to apply the language onto the associated owner.
  }
  INLDTranslate         = interface(INLDTInterface)
    ['{87897FB1-613C-4B8F-8332-307E404D7039}']
    //:$ Sets the manager interface
    //:: Call SetManager to set the manager associated with the translator.
    procedure SetManager(const Value: INLDTManager); stdcall;

    //:$ Reverts all language changes
    //:: Undo reverts any changes made to the owner.
    procedure Undo(); stdcall;
  end;


  {
    :$ Tree item interface.

    :: INLDTTreeItem represents a single item in the language file tree.
  }
  INLDTTreeItem         = interface(INLDTInterface)
    ['{87897FB2-613C-4B8F-8332-307E404D7039}']
    //:$ Returns the name of the tree item
    function GetName(): String; stdcall;

    //:$ Returns the value of the tree item
    function GetValue(): String; stdcall;

    //:$ Returns the number of attributes for the tree item
    //:: Call GetAttributeCount to get the number of attributes available for
    //:: the tree item. You can use the GetAttribute method to get the
    //:: value for a specific attribute.
    function GetAttributeCount(): Integer; stdcall;

    //:$ Returns the name of the specified attribute
    //:: Use GetAttributeName to get the name of an attribute. The AIndex
    //:: must be between 0 and GetAttributeCount - 1 or an exception is raised.
    function GetAttributeName(const AIndex: Integer): String; stdcall;

    //:$ Returns the value of the specified attribute
    //:: Use GetAttributeValue to get the value of an attribute. The AIndex
    //:: must be between 0 and GetAttributeCount - 1 or an exception is raised.
    function GetAttributeValue(const AIndex: Integer): String; stdcall;

    //:$ Returns the value of the specified attribute
    //:: Use GetAttributeValueByName to get the value of an attribute. The AName
    //:: parameter represent the attribute's name. Returns an empty string if
    //:: the attribute is not found.
    function GetAttributeValueByName(const AName: String): String; stdcall;
  end;


  {
    :$ Basic event interface.

    :: INLDTEvent is the basic interface for event objects.
  }
  INLDTEvent            = interface(INLDTInterface)
    ['{87897FF0-613C-4B8F-8332-307E404D7039}']
    //:$ Called when the connection to the event notifier should be closed
    //:: When you have registered your event object, Detach will be called
    //:: just before the owner object is destroyed. Clear any reference
    //:: you might keep in this procedure.
    //:! Do not call UnregisterEvent in the Detach procedure. Although
    //:! safety measurements should be taken to prevent the two from
    //:! conflicting, it is not needed and might cause problems with 3rd
    //:! party event sinks.
    procedure Detach(const ASender: INLDTInterface); stdcall;
  end;

  {
    :$ Language file change event interface.

    :: INLDTFileChangeEvent must be implemented to be notified of changes
    :: in the currently selected language file.
  }
  INLDTFileChangeEvent  = interface(INLDTEvent)
    ['{87897FF1-613C-4B8F-8332-307E404D7039}']
    //:$ Called when the active file changes
    procedure FileChanged(const ASender: INLDTManager); stdcall;
  end;

  {
    :$ Language file tree walk event interface.

    :: INLDTTreeWalkEvent must be implemented to be notified of changes
    :: in the current tree location. This interface is used when parsing
    :: a language file, it will be called for every node.
  }
  INLDTTreeWalkEvent    = interface(INLDTEvent)
    ['{87897FF2-613C-4B8F-8332-307E404D7039}']
    //:$ Called when a section is found
    //:: Objects implementing INLDTTreeWalkEvent should return True if they
    //:: want further notification about the section.
    function QuerySection(const AItem: INLDTTreeItem): Boolean; stdcall;

    //:$ Called when a tree item is found
    //:: Objects implementing INLDTTreeWalkEvent should return True if they
    //:: want further notification about the subitems.
    function QueryTreeItem(const AItem: INLDTTreeItem): Boolean; stdcall;

    //:$ Called when a section has been fully processed
    //:: Objects implementing INLDTTreeWalkEvent may use this method to update
    //:: their current state.
    procedure EndTreeItem(const AItem: INLDTTreeItem); stdcall;
  end;

implementation
end.
