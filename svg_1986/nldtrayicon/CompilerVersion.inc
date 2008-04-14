// This makes it easier to check which compiler version is
// being used...
{$IFDEF VER180}
  {$DEFINE D2006}
  {$DEFINE D2005}
  {$DEFINE D8}
  {$DEFINE D7}
  {$DEFINE D6}
  {$DEFINE D5}
  {$DEFINE D4}
  {$DEFINE D3}
  {$DEFINE D2}
  {$DEFINE D1}
{$ENDIF}
{$IFDEF VER170}
  {$DEFINE D2005}
  {$DEFINE D8}
  {$DEFINE D7}
  {$DEFINE D6}
  {$DEFINE D5}
  {$DEFINE D4}
  {$DEFINE D3}
  {$DEFINE D2}
  {$DEFINE D1}
{$ENDIF}
{$IFDEF VER160}
  {$DEFINE D8}
  {$DEFINE D7}
  {$DEFINE D6}
  {$DEFINE D5}
  {$DEFINE D4}
  {$DEFINE D3}
  {$DEFINE D2}
  {$DEFINE D1}
{$ENDIF}
{$IFDEF VER150}
  {$DEFINE D7}
  {$DEFINE D6}
  {$DEFINE D5}
  {$DEFINE D4}
  {$DEFINE D3}
  {$DEFINE D2}
  {$DEFINE D1}
{$ENDIF}
{$IFDEF VER140}
  {$DEFINE D6}
  {$DEFINE D5}
  {$DEFINE D4}
  {$DEFINE D3}
  {$DEFINE D2}
  {$DEFINE D1}
{$ENDIF}
{$IFDEF VER130}
  {$DEFINE D5}
  {$DEFINE D4}
  {$DEFINE D3}
  {$DEFINE D2}
  {$DEFINE D1}
{$ENDIF}
{$IFDEF VER120}
  {$DEFINE D4}
  {$DEFINE D3}
  {$DEFINE D2}
  {$DEFINE D1}
{$ENDIF}
{$IFDEF VER100}
  {$DEFINE D3}
  {$DEFINE D2}
  {$DEFINE D1}
{$ENDIF}
{$IFDEF VER90}
  {$DEFINE D2}
  {$DEFINE D1}
{$ENDIF}
{$IFDEF VER80}
  {$DEFINE D1}
{$ENDIF}
