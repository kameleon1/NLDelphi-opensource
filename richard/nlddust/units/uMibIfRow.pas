unit uMibIfRow;

interface

uses windows;

const
  cANY_SIZE = 1;
  cMAX_INTERFACE_NAME_LEN = $100;
  cMAXLEN_IFDESCR = $100;
  cMAXLEN_PHYSADDR = 8;

{Source : http://msdn.microsoft.com/library/default.asp?url=/library/en-us/rras/rras/mib_ifrow.asp}
type
  {Pointer naar de TMibIfRow.}
  PTMibIfRow = ^TMibIfRow;

  TMibIfRow = packed record

    {Pointer to a Unicode string that contains the name of the interface.}
    wszName: array[1..cMAX_INTERFACE_NAME_LEN] of WCHAR;

    {Specifies the index that identifies the interface.}
    dwIndex: Longword;

    {Specifies the type of interface. See *}
    dwType: Longword;

    {Specifies the Maximum Transmission Unit (MTU).}
    dwMTU: Longword;

    {Specifies the speed of the interface in bits per second.}
    dwSpeed: Longword;

    {Specifies the length of the physical address specified by the bPhysAddr member.}
    dwPhysAddrLen: Longword;

    {Specifies the physical address of the adapter for this interface.}
    bPhysAddr: array[1..cMAXLEN_PHYSADDR] of Char;

    {Specifies the interface is administratively enabled or disabled.}
    dwAdminStatus: Longword;

    {Specifies the operational status of the interface. This member can be one of the following values. See **}
    dwOperStatus: Longword;

    {Specifies the last time the operational status changed.}
    dwLastChange: Longword;

    {Specifies the number of octets of data received through this interface.}
    dwInOctets: Longword;

    {Specifies the number of unicast packets received through this interface.}
    dwInUcastPkts: Longword;

    {Specifies the number of non-unicast packets received through this interface. Broadcast and multicast packets are included.}
    dwInNUCastPkts: Longword;

    {Specifies the number of incoming packets that were discarded even though they did not have errors.}
    dwInDiscards: Longword;

    {Specifies the number of incoming packets that were discarded because of errors.}
    dwInErrors: Longword;

    {Specifies the number of incoming packets that were discarded because the protocol was unknown.}
    dwInUnknownProtos: Longword;

    {Specifies the number of octets of data sent through this interface.}
    dwOutOctets: Longword;

    {Specifies the number of unicast packets sent through this interface.}
    dwOutUCastPkts: Longword;

    {Specifies the number of non-unicast packets sent through this interface. Broadcast and multicast packets are included.}
    dwOutNUCastPkts: Longword;

    {Specifies the number of outgoing packets that were discarded even though they did not have errors.}
    dwOutDiscards: Longword;

    {Specifies the number of outgoing packets that were discarded because of errors.}
    dwOutErrors: Longword;

    {Specifies the output queue length.}
    dwOutQLen: Longword;

    {Specifies the length of the bDescr member.}
    dwDescrLen: Longword;

    {Contains a description of the interface.}
    bDescr: array[1..cMAXLEN_IFDESCR] of Char;
  end;

  TMIBIfArray = array of TMIBIFRow;

  {Pointer naar de TMibIfTable, welk de TMibIfRow structure bevat.}
  PTMibIfTable = ^TMIBIfTable;

  {TMibIfTable, welk de TMibIfRow structure bevat.}
  TMibIfTable = packed record
    dwNumEntries: Longint;
    Table: array[0..cANY_SIZE - 1] of TMibIfRow;
  end;

{Source: http://msdn.microsoft.com/library/default.asp?url=/library/en-us/wcetcpip/htm/_wcesdk_win32_GetIfTable.asp}
{See ***}
function GetIfTable(pIfTable: PTMibIfTable; pdwSize: PULONG; bOrder: boolean): Longword; stdCall; external 'IPHLPAPI.DLL';

implementation

{Addition Info.}

{*}
{This member can be one of the following values.}
{MIB_IF_TYPE_OTHER}
{MIB_IF_TYPE_ETHERNET}
{MIB_IF_TYPE_TOKENRING}
{MIB_IF_TYPE_FDDI}
{MIB_IF_TYPE_PPP}
{MIB_IF_TYPE_LOOPBACK}
{MIB_IF_TYPE_SLIP}

{**}
{MIB_IF_OPER_STATUS_NON_OPERATIONAL =
 LAN adapter has been disabled, for example because of an address conflict.}
{MIB_IF_OPER_STATUS_UNREACHABLE =
 WAN adapter that is not connected.}
{MIB_IF_OPER_STATUS_DISCONNECTED =
 For LAN adapters: network cable disconnected. For WAN adapters: no carrier.}
{MIB_IF_OPER_STATUS_CONNECTING =
 WAN adapter that is in the process of connecting.}
{MIB_IF_OPER_STATUS_CONNECTED =
 WAN adapter that is connected to a remote peer.}
{MIB_IF_OPER_STATUS_OPERATIONAL =
 Default status for LAN adapters.}

{***}
{Parameters:}

{pIfTable =
Pointer to a buffer that, on successful return, contains the interface table as a MIB_IFTABLE structure.}
{pdwSize =
Specifies the size of the buffer pointed to by the pIfTable parameter. If the buffer is not large enough to hold the returned interface table, the function sets this parameter equal to the required buffer size.}
{bOrder =
Specifies whether the returned interface table should be sorted in ascending order by interface index. If this parameter is TRUE, the table is sorted.}

{Return Values:}

{If the function succeeds, the return value is NO_ERROR. If the function fails, an error code is returned.}

{End of Documentation.}
end.

