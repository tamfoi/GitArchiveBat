
set COMMIT_ID1=
set COMMIT_ID2=
set DIFF_LIST=
set BASE_NAME=
set FORMATTED_DATE=
set FORMATTED_TIME=

:: COMMIT_ID1がCOMMIT_ID2より新しいコミットという前提
if "%2" EQU "" (
  set COMMIT_ID1=HEAD
  set COMMIT_ID2=%1
) else (
  set COMMIT_ID1=%1
  set COMMIT_ID2=%2
)

:: 差分ファイルを抽出、削除ファイルは抽出から除外
:: `tokens=* delims=`はなくても大丈夫だが一応明示的に指定する
:: `git diff`がファイル名を改行で区切って出力するため`for in do`で1行ずつ読まれることになるので文字連結する。変数展開の問題で連結処理はサブルーチン化して実現
for /F "usebackq tokens=* delims=" %%A in (`git diff --diff-filter=ACMRTUXB --name-only %COMMIT_ID2% %COMMIT_ID1%`) do call :diffListJoin %%A

:: 出力するzipファイル名に必要な情報をセットアップ
for /F "usebackq tokens=* delims=" %%A in (`git rev-parse --show-toplevel`) do call :setBasename %%A
set FORMATTED_DATE=%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%
set FORMATTED_TIME=%TIME: =0%
set FORMATTED_TIME=%FORMATTED_TIME:~0,2%%FORMATTED_TIME:~3,2%%FORMATTED_TIME:~6,2%
 
git archive --format=zip %COMMIT_ID1% %DIFF_LIST% --output=%BASE_NAME%-%FORMATTED_DATE%%FORMATTED_TIME%.zip

exit

:diffListJoin
set DIFF_LIST=%DIFF_LIST% %1
exit /b

:setBasename
set BASE_NAME=%~nx1
exit /b
