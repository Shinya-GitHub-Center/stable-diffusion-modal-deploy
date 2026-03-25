# stable-diffusion-modal-deploy
Stable Diffusion WebuiをModalサーバーレス環境にデプロイします。  
ローカルPC上にuv環境を作成してその中にmodalモジュールをインストールし、そのmodalモジュールを使用してmodalの基本環境設定（あなたのローカルPCのグローバル環境に設定ファイルが保存される）およびリモートへのデプロイを行います。

## 事前に必要になるもの
- [modal](https://modal.com/)のアカウント
- modalのトークンIDとトークンシークレットと環境（すべてこのwebuiデプロイ用に新規に発行・作成することを推奨）
- uv
- `uv python install 3.11`によってグローバル環境にインストールされたpython version 3.11（webuiとmodalの相性でなぜか3.11が必要になる）
- make （ほとんどのLinuxディストリビューションもしくはWSL2には標準で入っている）

## 手順
1. このリポジトリをダウンロード
2. `uv sync`
3. modalのダッシュボードから新規トークンを作成
4. `modal environment create sd-webui`コマンドにて新規環境を作成
5. `~/.modal.toml`に以下のように新規プロファイルを追加
```
[sd-webui]
token_id = "xxxxxxxxxxxxxxxxxxxxxxxxxx"
token_secret = "xxxxxxxxxxxxxxxxxxxxxxxx"
environment = "sd-webui"
active = true
```
6. `modal profile current`で利用するプロファイルがアクティブになっていることを確認
7. `make deploy`でデプロイ後、`modal.run`で終わるURLが発行されるので、それがアプリのURLとなる。

## 画像ダウンロード方法
- `make pull`でスクリプトを実行し、outputsディレクトリ以下にリモートで作成された画像が保存される。
- このスクリプトを実行するごとに、その時点でリモート環境にあるすべての画像がダウンロードされるとともに、それらの画像がリモート環境からすべて削除される。

## ローカルにあるモデル等をリモートへアップロードする方法
- `make help`でコマンド一覧を表示します。そちらを参考にしてください。 