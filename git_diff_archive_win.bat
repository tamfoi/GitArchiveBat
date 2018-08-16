
rem Assume that COMMIT_ID1 is newer than COMMIT_ID2
if "%2" EQU "" (
  set COMMIT_ID1=HEAD
  set COMMIT_ID2=%1
) else (
  set COMMIT_ID1=%1
  set COMMIT_ID2=%2
)

for /F "usebackq" %%a in (`git diff --diff-filter=ACMRTUXB --name-only %COMMIT_ID2% %COMMIT_ID1%`) do set DIFF_LIST=%%a

git archive --format=zip %COMMIT_ID1% %DIFF_LIST% --output=diff.zip