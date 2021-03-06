if "%APPVEYOR_REPO_TAG%"=="true" (
 set ML_VERSION=%APPVEYOR_REPO_TAG_NAME%
) else (
 set ML_VERSION=%APPVEYOR_REPO_BRANCH%_%APPVEYOR_REPO_COMMIT%
)
set PATH=C:\Perl;%PATH%
perl -p -i.bak -e s/MLVERSION/`\$\"%ML_VERSION%\"/g ml.q


if not defined QLIC_KC (
 goto :nokdb
)


set PATH=C:\Miniconda3-x64;C:\Miniconda3-x64\Scripts;%PATH%
conda config --set always_yes yes --set changeps1 no
call "build\getkdb.bat" || goto :error

exit /b 0

:error
echo failed with error 
exit /b 

:nokdb
echo no kdb
exit /b 0

