unit Lpt;

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

interface

uses wintypes;

Const
{ Errorbits }
LptError_DeviceNotSelected      = CE_DNS;
LptError_IoError                = CE_IOE;
LptError_OutOfPaper             = CE_OOP;
LptError_Timeout                = CE_PTO;
LptError_TransmitbufferOverflow = CE_TXFULL;

Type TLptStatus = byte;
     printer_type = (epson, pcl, other);

function write_lpt(txt : string): boolean;
function writeln_lpt(txt: string): boolean;
function lpt_error: integer;
function lpt_status: TLptStatus;
procedure get_current_lpt_error_and_status;

procedure pr_nlq;
procedure pr_draft;
procedure pr_pica;
procedure pr_elite;
procedure pr_condense(onn:boolean);
procedure pr_emphasize(onn:boolean);
procedure pr_italic(onn:boolean);
procedure pr_enlarged(onn:boolean);
procedure pr_double(onn:boolean);
procedure pr_left;
procedure pr_centre;
procedure pr_right;
procedure pr_full;
procedure pr_ff;
procedure pr_init;
procedure pr_perforation(number:byte);
procedure pr_lines(number:byte);
procedure pr_proportional(onn:boolean);
procedure pr_unidirec(onn:boolean);
procedure pr_landscape(onn:boolean);
procedure pr_set_type(t:printer_type);
function  pr_type:printer_type;
procedure pr_pitch(p:byte);
function  pr_online : boolean;

{---------------------------------------------------------------------}

implementation

uses winprocs, sysutils, strings;

Type TLptDataRec = record
                     Cid      : integer;
                     Error    : integer;
                     Stat     : byte;
                   end;

Const esc = #27;

Var LptData       : TLptDataRec;
    old_exit_proc : pointer;
    PrinterType   : printer_type;
    EliteMode	  : boolean;
    CondensedMode : boolean;


{---------------------------------------------------------------------}

function write_lpt(txt : string): boolean;
var buff: array[0..256] of char;
    res : integer;
begin
  res := -1;
  if (LptData.Cid >= 0) then
  begin
    StrPcopy(buff, txt);
    res := WriteComm(LptData.Cid, buff, length(txt));
    get_current_lpt_error_and_status;
  end;
  write_lpt := (res >= 0) and (lpt_error = 0);
end;

function writeln_lpt(txt: string): boolean;
begin
  txt := txt + #13 + #10;
  writeln_lpt := write_lpt(txt);
end;

function lpt_error: integer;
var res: integer;
begin
  res := CE_DNS;
  if (LptData.Cid >= 0)
  then res := LptData.Error
  else res := CE_DNS;
  lpt_error := res;
end;

function lpt_status: TLptStatus;
var res : byte;
begin
  res := 0;
  if (LptData.Cid >= 0) then res := LptData.Stat;
  lpt_status := res;
end;

procedure get_current_lpt_error_and_status;
var Stat : TCOMSTAT;
begin
  if (LptData.Cid >= 0) then
  begin
    LptData.Error := GetCommError(LptData.Cid, Stat);
    LptData.Stat  := Stat.Flags;
  end;
end;

{-----------------------------------------------------------------------}

procedure pr_nlq;
begin
  case PrinterType of
    epson: write_lpt(esc + 'x' + #1);
    pcl:   write_lpt(esc + '(s2Q');
  end; { case }
end;

procedure pr_draft;
begin
  case PrinterType of
    epson: write_lpt(esc + 'x' + #0);
    pcl:   write_lpt(esc + '(s1Q');
  end; { case }
end;

procedure pr_pica;
begin
  case PrinterType of
    epson: write_lpt(esc + 'P');
    pcl:   begin
	     write_lpt(esc + '(s1T');
	     if CondensedMode then write_lpt(esc + '(s17H')
			      else write_lpt(esc + '(s10H')
	   end
  end; { case }
  EliteMode := false;
end;

procedure pr_elite;
begin
  case PrinterType of
    epson: write_lpt(esc + 'M');
    pcl:   begin
	     write_lpt(esc + '(s2T');
	     if CondensedMode then write_lpt(esc + '(s20H')
			      else write_lpt(esc + '(s12H')
           end;
  end; { case }
  EliteMode := true;
end;

procedure pr_condense(onn:boolean);
begin
  case PrinterType of
    epson: if onn then write_lpt(#15)
		  else write_lpt(#18);
    pcl:   if onn then begin
			 if EliteMode then write_lpt(esc + '(s20H')
				      else write_lpt(esc + '(s17H');
		       end
		  else begin
			 if EliteMode then write_lpt(esc + '(s12H')
				      else write_lpt(esc + '(s10H');
		       end;
  end; { case }
  CondensedMode := true;
end;

procedure pr_emphasize(onn:boolean);
begin
  case PrinterType of
    epson: if onn then write_lpt(esc + 'E')
		  else write_lpt(esc + 'F');
    pcl:   if onn then write_lpt(esc + '(s3B')
		  else write_lpt(esc + '(s0B');
  end; { case }
end;

procedure pr_italic(onn:boolean);
begin
  case PrinterType of
    epson: if onn then write_lpt(esc + '4')
		  else write_lpt(esc + '5');
    pcl:   if onn then write_lpt(esc + '(s1S')
		  else write_lpt(esc + '(s0S');
  end; { case }
end;

procedure pr_enlarged(onn:boolean);
begin
  case PrinterType of
    epson: if onn then write_lpt(esc + 'W' + #1)
		  else write_lpt(esc + 'W' + #0);
    pcl:
  end; { case }
end;

procedure pr_double(onn:boolean);
begin
  case PrinterType of
    epson: if onn then write_lpt(esc + 'G')
		  else write_lpt(esc + 'H');
    pcl:   if onn then write_lpt(esc + '(s7B')
		  else write_lpt(esc + '(s0B');
  end; { case }
end;

procedure pr_left;
begin
  case PrinterType of
    epson:   write_lpt(esc + 'a' + #0);
    pcl:
  end; { case }
end;

procedure pr_centre;
begin
  case PrinterType of
    epson:   write_lpt(esc + 'a' + #1);
    pcl:
  end; { case }
end;

procedure pr_right;
begin
  case PrinterType of
    epson:   write_lpt(esc + 'a' + #2);
    pcl:
  end; { case }
end;

procedure pr_full;
begin
  case PrinterType of
    epson:   write_lpt(esc + 'a' + #3);
    pcl:
  end; { case }
end;

procedure pr_ff;
begin
  case PrinterType of
    epson: write_lpt(#12);
    pcl:   write_lpt(#12);
  end; { case }
end;

procedure pr_init;
begin
  case PrinterType of
    epson: write_lpt(esc + '@');
    pcl:   write_lpt(esc + 'E');
  end; { case }
end;

procedure pr_perforation(number:byte);
begin
  case PrinterType of
    epson: write_lpt(esc + 'N' + chr(number));
    pcl:
  end; { case }
end;

procedure pr_lines(number:byte);
begin
  case PrinterType of
    epson: write_lpt(esc + 'C' + chr(number));
    pcl:   write_lpt(esc + '&l' + chr(number) + 'P');
  end; { case }
end;

procedure pr_proportional(onn:boolean);
begin
  case PrinterType of
    epson: if onn then write_lpt(esc + 'p' + #1)
		  else write_lpt(esc + 'p' + #0);
    pcl:   if onn then write_lpt(esc + '(s1P')
		  else write_lpt(esc + '(s0P');
  end; { case }
end;

procedure pr_unidirec(onn:boolean);
begin
  case PrinterType of
    epson: if onn then write_lpt(esc + 'U' + #1)
		  else write_lpt(esc + 'U' + #0);
    pcl:   if onn then write_lpt(esc + '&k0W')
		  else write_lpt(esc + '&k2W');
  end; { case }
end;

procedure pr_landscape(onn:boolean);
begin
  case PrinterType of
    epson: ;
    pcl:   if onn then write_lpt(esc + '&l1O')
		  else write_lpt(esc + '&l0O');
  end; { case }
end;

procedure pr_pitch(p:byte);
var s: string[10];
begin
  if (PrinterType = pcl) then begin
    str(p,s); s := trim(s);
    write_lpt(esc + '(s' + s + 'H');
  end;
end;

procedure pr_set_type(t:printer_type);
begin
  PrinterType := t;
end;

function  pr_type:printer_type;
begin
  pr_type := PrinterType;
end;

function  pr_online : boolean;
begin
  write_lpt(#0);
  pr_online := (lpt_error = 0);
end;

{-----------------------------------------------------------------------}

procedure initialize;
var res : integer;
begin
  LptData.Cid := -1; {illegal value}
  res := OpenComm('LPT1', 0, 0);
  if (res >= 0) then
  begin
    LptData.Cid := res; {successfull}
    get_current_lpt_error_and_status;
  end;
  EliteMode     := false;
  CondensedMode := false;
  pr_set_type(epson); { default printertype }
end;

procedure closedown;
begin
  if (LptData.Cid >= 0) then CloseComm(LptData.Cid);
end;

{$f+}
procedure myexitproc;
begin
  closedown;
  ExitProc := old_exit_proc;
end;
{$f-}

begin
  old_exit_proc  := ExitProc;
  ExitProc       := @myexitproc;
  initialize;
end.
