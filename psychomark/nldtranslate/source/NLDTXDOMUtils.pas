unit NLDTXDOMUtils;

{
  :: NLDTXDOMUtils contains some convenience functions for use with OpenXML.
  :: Most noticeably, it provides the ability to translate characters into
  :: valid XML entities and back.

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
}

{$I NLDTDefines.inc}

interface
uses
  XDOM_2_3;

type
  {
    :$ Buffers writing operations to a string

    :: TNLDTStringBuffer can be used to add characters to a string without
    :: sacrificing too much speed. It uses a buffer which is increased only
    :: when needed.
  }
  TNLDTStringBuffer = class(TObject)
  private
    FActualLen:     Integer;
    FCapacity:      Integer;
    FContent:       String;
  protected
    function GetChar(AIndex: Integer): Char; virtual;
    function GetValue(): String; virtual;
    procedure SetChar(AIndex: Integer; const Value: Char); virtual;
  public
    //:$ Initializes the TNLDTStringBuffer instance
    constructor Create();

    //:$ Clears the internal buffer
    //:: Clear cleans up the current string data and restores the buffr
    procedure Clear(); virtual;

    //:$ Writes a single character
    //:: Call WriteChar to write a single character in buffered mode to
    //:: the internal string.
    procedure WriteChar(const AChar: Char); virtual;


    //:$ Writes a string
    //:: Call WriteString to write a string in buffered mode to
    //:: the internal string.
    procedure WriteString(const AString: String); virtual;

    //:$ Provides indexed access to the individual characters
    //:: Use the Chars property to get fast access to the individual characters.
    property Chars[AIndex: Integer]:    Char    read GetChar  write SetChar;

    //:$ Returns the length of the string
    //:: Length returns the actual length of the string, not of the buffer.
    property Length:                    Integer read FActualLen;

    //:$ Returns the internal string
    //:: Returns the internal string without any remaining buffer.
    //:! If you want to access the characters, use the Chars property instead,
    //:! since retrieving Value requires some memory allocations to get the
    //:! correct data from the internal buffer.
    property Value:                     String  read GetValue;
  end;


  {
    :$ Converts entities to characters

    :: XDOMEntityToChar converts entities (such as &amp;) to their
    :: corresponding characters (such as &).
  }
  function XDOMEntityToChar(const ASource: String): String;

  {
    :$ Converts characters to entities

    :: XDOMCharToEntity converts all illegal characters (such as &) to their
    :: corresponding entities (such as &amp;), which prevents errors while
    :: saving XML encoded files.
  }
  function XDOMCharToEntity(const ASource: String): String;

  {
    :$ Returns the value of the specified attribute

    :: XDOMGetAttribute returns the value of the specified attribute for the
    :: specified node. It calls XDOMEntityToChar on the value to return the
    :: character representation of the encoded string. If the attribute is not
    :: found, an empty string is returned.
  }
  function XDOMGetAttribute(const ANode: TDomNode;
                            const AName: String): String;

  {
    :$ Returns the value of the specified attribute

    :: XDOMGetAttribute returns the value of the specified attribute for the
    :: specified node. It calls XDOMEntityToChar on the value to return the
    :: character representation of the encoded string. If the attribute index
    :: is not found, an exception is raised.
  }
  function XDOMGetAttributeByIndex(const ANode: TDomNode;
                                   const AIndex: Integer): String;

  {
    :$ Sets the value for the specified attribute

    :: XDOMSetAttribute sets the specified attribute to the specified value.
    :: XDOMCharToEntity is automatically called before setting the actual value.
  }
  procedure XDOMSetAttribute(const ANode: TDomNode; const AName,
                             AValue: String);

implementation
uses
  Windows,
  SysUtils,
  {$IFDEF NLDT_FASTSTRINGS}
  FastStrings,
  {$ENDIF}
  NLDTXDOMEntities;



{********************* TNLDTStringBuffer
  Initialization
****************************************}
constructor TNLDTStringBuffer.Create;
begin
  inherited;
  Clear();
end;

procedure TNLDTStringBuffer.Clear;
begin
  FCapacity   := 64;
  SetLength(FContent, FCapacity);
  FActualLen  := 0;
end;


{********************* TNLDTStringBuffer
  Write functions
****************************************}
procedure TNLDTStringBuffer.WriteChar;
begin
  if FActualLen = FCapacity then begin
    // Expand buffer
    Inc(FCapacity, FCapacity div 4);
    SetLength(FContent, FCapacity);
  end;

  Inc(FActualLen);
  FContent[FActualLen]  := AChar;
end;

procedure TNLDTStringBuffer.WriteString;
var
  iLength:      Integer;
  iNeeded:      Integer;

begin
  iLength := System.Length(AString);
  iNeeded := FActualLen + iLength;

  if iNeeded > FCapacity then begin
    while iNeeded > FCapacity do
      // Expand buffer
      Inc(FCapacity, FCapacity div 4);

    SetLength(FContent, FCapacity);
  end;

  CopyMemory(@FContent[FActualLen + 1], @AString[1], iLength);
  Inc(FActualLen, iLength);
end;


{********************* TNLDTStringBuffer
  Properties
****************************************}
function TNLDTStringBuffer.GetChar;
begin
  Result  := FContent[AIndex];
end;

procedure TNLDTStringBuffer.SetChar;
begin
  FContent[AIndex]  := Value;
end;

function TNLDTStringBuffer.GetValue: String;
begin
  SetLength(Result, FActualLen);
  CopyMemory(@Result[1], @FContent[1], FActualLen);
end;



function FastReplacePart(const ASource: String; const AStart, ALength: Integer;
                         const AReplace: String): String;
var
  iSrcLength: Integer;
  iLength:    Integer;
  iDiff:      Integer;
  iDest:      Integer;

begin
  iSrcLength  := Length(ASource);
  iLength     := Length(AReplace);
  iDiff       := iLength - ALength;
  iDest       := 1;

  SetLength(Result, iSrcLength + iDiff);

  // Write first part
  CopyMemory(@Result[iDest], @ASource[1], AStart - 1);
  Inc(iDest, AStart - 1);

  // Write replacement
  CopyMemory(@Result[iDest], @AReplace[1], iLength);
  Inc(iDest, iLength);

  // Write last part
  CopyMemory(@Result[iDest], @ASource[AStart + ALength],
             iSrcLength - AStart - (ALength - 1));
end;


{****************************************
  Convert entities to characters
****************************************}
function XDOMEntityToChar;
var
  {$IFNDEF NLDT_FASTSTRINGS}
  sTemp:          String;
  iOffset:        Integer;
  {$ELSE}
  iLength:        Integer;
  {$ENDIF}
  iStart:         Integer;
  iEnd:           Integer;
  iEntLength:     Integer;
  sEntity:        String;
  iEntity:        Integer;
  cReplacement:   Char;

begin
  Result  := ASource;
  {$IFNDEF NLDT_FASTSTRINGS}
  sTemp   := ASource;
  iOffset := 0;
  {$ELSE}
  iLength := Length(Result);
  iStart  := 1;
  {$ENDIF}

  repeat
    // Find '&'
    {$IFDEF NLDT_FASTSTRINGS}
    iStart  := FastPos(Result, '&', iLength, 1, iStart);
    {$ELSE}
    iStart  := AnsiPos('&', sTemp);
    {$ENDIF}

    if iStart > 0 then begin
      {$IFNDEF NLDT_FASTSTRINGS}
      Delete(sTemp, 1, iStart);
      Inc(iStart, iOffset);
      Inc(iOffset, iStart - iOffset);
      {$ENDIF}

      // Find ';'
      {$IFDEF NLDT_FASTSTRINGS}
      iEnd  := FastPos(Result, ';', iLength, 1, iStart + 1);
      {$ELSE}
      iEnd  := AnsiPos(';', sTemp);
      {$ENDIF}

      if iEnd > 0 then begin
        {$IFNDEF NLDT_FASTSTRINGS}
        Delete(sTemp, 1, iEnd);
        Inc(iEnd, iOffset);
        Inc(iOffset, iEnd - iOffset);
        {$ENDIF}

        iEntLength  := iEnd - iStart - 1;

        // Quick check: make sure it does not exceed the maximum length
        if iEntLength <= XDOMEntityMaxLen then begin
          sEntity       := LowerCase(Copy(Result, iStart + 1, iEntLength));
          cReplacement  := ' ';

          if sEntity[1] = '#' then begin
            // Try to replace numeric entity
            Delete(sEntity, 1, 1);
            cReplacement  := Chr(StrToIntDef(sEntity, Ord(' ')));
          end else
            // Check for entity in reference table
            for iEntity := 0 to XDOMEntityCount - 1 do
              if sEntity = XDOMEntityNames[iEntity] then begin
                cReplacement  := XDOMEntityValues[iEntity];
                break;
              end;

          Result  := FastReplacePart(Result, iStart, iEntLength + 2, cReplacement);

          {$IFDEF NLDT_FASTSTRINGS}
          Inc(iStart, 2);
          iLength := Length(Result);
          {$ELSE}
          Dec(iOffset, iEntLength + 1);
          {$ENDIF}
        end{$IFDEF NLDT_FASTSTRINGS} else
          iStart  := iEnd + 1{$ENDIF};
      end{$IFDEF NLDT_FASTSTRINGS} else
        Inc(iStart){$ENDIF};
    end else
      break;
  until False;
end;

{****************************************
  Convert characters to entities
****************************************}
function XDOMCharToEntity;
const
  CInvalidChars = [#0..#31, #38, #60, #62, #127..#255];

var
  iChar:        Integer;
  cChar:        Char;
  iEntity:      Integer;
  pBuffer:      TNLDTStringBuffer;
  bFound:       Boolean;

begin
  pBuffer := TNLDTStringBuffer.Create();
  try
    for iChar := 1 to Length(ASource) do begin
      cChar := ASource[iChar];

      if cChar in CInvalidChars then begin
        // Check if the character is found in the lookup table
        bFound  := False;

        for iEntity := 0 to XDOMEntityCount - 1 do
          if cChar = XDOMEntityValues[iEntity] then begin
            pBuffer.WriteString('&' + XDOMEntityNames[iEntity] + ';');
            bFound  := True;
            break;
          end;

        if not bFound then
          pBuffer.WriteChar(cChar);
      end else
        pBuffer.WriteChar(cChar);
    end;
  finally
    Result  := pBuffer.Value;
    FreeAndNil(pBuffer);
  end;
end;


{****************************************
  Get attribute
****************************************}
function XDOMGetAttribute;
var
  xmlAttr:      TDomNode;

begin
  Result  := '';
  xmlAttr := ANode.attributes.getNamedItem(AName);

  if Assigned(xmlAttr) then
    Result  := XDOMEntityToChar(xmlAttr.nodeValue);
end;

function XDOMGetAttributeByIndex;
var
  xmlAttr:      TDomNode;

begin
  Result  := '';
  xmlAttr := ANode.attributes.item(AIndex);

  if Assigned(xmlAttr) then
    Result  := XDOMEntityToChar(xmlAttr.nodeValue);
end;


{****************************************
  Set attribute
****************************************}
procedure XDOMSetAttribute;
var
  xmlAttr:      TDomNode;

begin
  xmlAttr           := ANode.ownerDocument.createAttribute(AName);
  xmlAttr.nodeValue := XDOMCharToEntity(AValue);
  ANode.attributes.setNamedItem(xmlAttr);
end;

end.
