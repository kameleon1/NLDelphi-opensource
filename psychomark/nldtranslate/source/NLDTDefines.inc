// For any of these defines: remove the . (dot) in front of the
// $DEFINE directive to active this option. Every setting will begin with
// a description of it's purpose. Leave these settings alone unless you know
// what you're doing, it may result in compiler errors.


// If NLDT_FASTSTRINGS is defined, all string manipulation troughout
// NLDTranslate will use the (much faster) FastStrings library. If not defined,
// native Delphi code will be used.
{$DEFINE NLDT_FASTSTRINGS}


// These are used to easily determine the compiler version, only modify
// if you are an NLDTranslate developer and need to add compiler support!
{$IFDEF VER140}
  {$DEFINE NLDT_D6}
{$ENDIF}
{$IFDEF VER130}
  {$DEFINE NLDT_D5}
{$ENDIF}
{$IFDEF VER120}
  {$DEFINE NLDT_D4}
{$ENDIF}
{$IFDEF VER100}
  {$DEFINE NLDT_D3}
{$ENDIF}
{$IFDEF VER90}
  {$DEFINE NLDT_D2}
{$ENDIF}
{$IFDEF VER80}
  {$DEFINE NLDT_D1}
{$ENDIF}