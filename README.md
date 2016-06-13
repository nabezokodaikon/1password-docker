# 1Password-docker
1Passwordをdocker内のwineで実行する。

## 準備

### sshd
sshdサービスが必要なので、以下の設定後、sshdサービスを起動する。
```
$ sudo vim /etc/ssh/sshd_config

AllowAgentForwarding yes
AllowTcpForwarding yes
GatewayPorts no
X11Forwarding yes
X11DisplayOffset 10
X11UseLocalhost yes

$ sudo systemctl start sshd
```

### xhost
TODO: 以下のコマンドを実行しておく必要あり。
[参考](http://stackoverflow.com/questions/28392949/running-chromium-inside-docker-gtk-cannot-open-display-0)
```
$ sudo xhost local:root
```

## Docker イメージ作成

### wine を導入したイメージを作成
`build.sh`を実行する。

### Dropbox インストール
TODO: 1Passwordで必要になるため。

### 1Password インストール
```
# インストーラをダウンロード。
$ wget https://d13itkw33a7sus.cloudfront.net/dist/1P/win4/1Password-4.6.0.604.exe

# インストーラを実行。
$ wine 1Password-4.6.0.604.exe

# インストール後の起動。
$ wine ~/.wine/drive_c/Program\ Files/1Password\ 4/1Password.exe
```
