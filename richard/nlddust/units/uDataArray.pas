unit uDataArray;

interface
uses Windows, uMain, uMibIfRow;

{DataArray om 'tijdelijke' data in op te slaan en te bewerken alvorens het op het scherm staat.}
type
  TRDataArray = record
    fInterfaceID: Longword;
    fSessionCurrentReceived: Longword;
    fSessionCurrentSent: Longword;
    fSessionAverageReceived: Longword;
    fSessionAverageSent: Longword;
    fSessionMaxReceived: Longword;
    fSessionMaxSent: Longword;
    fSessionTotalReceived: Longword;
    fSessionTotalSent: Longword;
    fWindowsTotalReceived: Longword;
    fWindowsTotalSent: Longword;
    fPreviousReceived: Longword;
    fPreviousSent: Longword;
    fSessionActiveCountReceived: Longword;
    fSessionActiveCountSent: Longword;
  end;
  TDataArray = array of TRDataArray;

var
  vDataArray: TDataArray;

implementation

end.

