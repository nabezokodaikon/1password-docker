# 1Password-docker
1Passwordをdocker内のwineで実行する。

## 参考
* https://github.com/geekylucas/dockerfiles/tree/master/1password-wine

## 準備

### xhost
TODO: 以下のコマンドを実行しておく必要あり。
[参考](http://stackoverflow.com/questions/28392949/running-chromium-inside-docker-gtk-cannot-open-display-0)
```
$ xhost local:<ログインユーザー名など>
```

## 使用方法

### Dockerイメージ作成
1. `build.sh`を実行する。
1. `init.sh`を実行する。
1. `1Password.opvault`ディレクトリを指定する。
1. ライセンスキーを入力する。
1. 1Passwordを終了する。

### 1Password起動
`start.sh`を実行する。

## TODO

* 初回以降の起動時にウィンドウサイズを大きくしようとすると、強制終了してしまう。
