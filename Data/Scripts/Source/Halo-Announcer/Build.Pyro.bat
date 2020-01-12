@ECHO OFF
SET PYRO="..\..\..\..\Tools\pyro\pyro.exe"
SET PROJECT="..\Halo-Announcer\Halo-Announcer.ppj"

CALL %PYRO% -i %PROJECT%
