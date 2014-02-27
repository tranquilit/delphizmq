{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit pltis_delphizmq;

interface

uses
  zhelpers, zmq, zmqapi, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('pltis_delphizmq', @Register);
end.
