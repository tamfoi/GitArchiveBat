# SourcetreeCustomActions

Sourcetree のカスタム操作で使用するシェルスクリプト置き場

# Windows 版で シェルスクリプトを使用する場合

### 実行するスクリプト

bash.exe までのフルパスを指定する(下記は内蔵 Git に同梱されている Git Bash を使う例)

```
C:\Users\ユーザ名\AppData\Local\Atlassian\SourceTree\git_local\bin\bash.exe
```

### パラメータ

sh ファイルまでのフルパスに続けてパラメータを付与する(下記は例)

```
C:\hoge\test.sh $SHA
```

※実行環境によってはパスは UNIX 形式でないといけない可能性有り(内蔵 Git を使用している場合は Windows 形式で大丈夫)
