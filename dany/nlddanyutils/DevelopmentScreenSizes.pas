unit DevelopmentScreenSizes;

interface

{$DEFINE TEST}

{$IFNDEF TEST}
const MyScreenWidth  = 1280;
      MyScreenHeight = 1024;
{$ELSE}
const MyScreenWidth  = 1024;
      MyScreenHeight = 768;
{$ENDIF}

implementation

end.
