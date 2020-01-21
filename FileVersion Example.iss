#define TESTNAME "FileVersions Example"
[Setup]
AppName={#TESTNAME}
AppVersion=0.1
DefaultDirName={tmp}\{#TESTNAME}
OutputDir=.
OutputBaseFileName={#TESTNAME}
PrivilegesRequired=lowest
CreateAppDir=no
Uninstallable=no

#include "FileVersion.iss"

[Code]

function InitializeSetup(): Boolean;
var
	FileName: String;
	CurrentVersion, MinVersion: TFileVersion; // ��������� ����������
begin
	// ����� ��������� ������:
	FileVersionSetI(MinVersion, 5, 80, 0, 0);
	// ��� ���:
	//FileVersionSetS(MinVersion, '5.80.0.10');
	
	// ��� �����:
	FileName := ExpandConstant('{src}') + '\test.exe';
	
	if Not FileExists(FileName) then begin
		MsgBox('��������� ����������:'#13#13 + '���� `' + ExtractFileName(FileName) + '` �� ������', mbCriticalError, MB_OK);
		Result := False;
		Exit;
	end;
	
	// ���� ����������, ��������� ������:
	FileVersionSetF(CurrentVersion, FileName);
	
	// ���������� � ������ ��� ������:
	if FileVersionCompare(CurrentVersion, MinVersion) > -1 then
		Result := True
	else begin
		MsgBox('��������� ����������:' \
		+ #13#13'������ ����� `' + ExtractFileName(FileName) + '`: ' + FileVersionToStr(CurrentVersion) \
		+ #13#13'��������� ������ ��� �������: ' + FileVersionToStr(MinVersion) \
		, mbCriticalError, MB_OK);
		Result := False;
	end;
end;
