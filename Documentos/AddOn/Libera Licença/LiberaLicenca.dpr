program LiberaLicenca;

uses
  Forms,
  UPrincipal in 'UPrincipal.pas' {frmLibera};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Libera��o de Licen�a';
  Application.CreateForm(TfrmLibera, frmLibera);
  Application.Run;
end.
