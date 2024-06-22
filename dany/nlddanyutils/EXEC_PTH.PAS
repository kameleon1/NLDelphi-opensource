unit exec_pth;

{ Does the same as the 'exec' command, but now along the search path.
  The current directory is always included in that path.
  The default extension is '.exe' }

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

procedure exec_path(Path, CmdLine : string);

implementation

uses dir;

procedure exec_path(Path, CmdLine : string);
var x    : byte;
    p,p1 : string;
    d    : string;
    name : string;
    ext  : string;
    done : boolean;
    t    : string;
begin
  ExtractFileExt(Path, ext);
  {fsplit(Path, d, name, ext);}
  if (ext = '') then ext := '.exe';
  if (d > '') then begin
    swapvectors;
    exec(d + name + ext, CmdLine);
    swapvectors;
  end
  else begin
    p := getenv('path');
    p := '.;' + p; { first always include current directory }
    done := false;
    while (p > '')  and (not done) do begin
      x := pos(';',p);
      if (x > 0) then begin
	p1 := copy(p,1,x-1);
	delete(p,1,x);
      end
      else begin
	if (p > '') then begin
	  p1 := p;
	  p := '';
	end;
      end;
      t := p1 + '\' + name + ext;
      if exists(t, Normal + ReadOnly, relaxed) then begin
	swapvectors;
	exec(t, CmdLine);
	swapvectors;
	done := true;
      end;
    end;
    if not done then doserror := 2; { file not found }
  end;
end;

end.