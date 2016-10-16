# 1Password-docker
1Passwordをdocker内のwineで実行する。

## 参考
* https://github.com/geekylucas/dockerfiles/tree/master/1password-wine
* http://wiki.ros.org/docker/Tutorials/GUI

## 使用方法
### Dockerイメージ作成
`build.sh`を実行する。

### 初回起動
1Passowrdの初期設定を行う。
1. `init.sh`を実行する。
1. `1Password.opvault`ディレクトリを指定する。
1. ライセンスキーを入力する。
1. 1Passwordを終了する。

### 通常起動
`start.sh`を実行する。

## TODO
* READMEや各種コメントを英文にする。
* Chromeの拡張で使用できるようにする。
    * `xdg-open`がキーワードっぽい。
* ウィンドウサイズを大きくしようとすると、強制終了してしまう。
