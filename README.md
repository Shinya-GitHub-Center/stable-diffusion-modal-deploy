# stable-diffusion-modal-deploy

## English

Deploy Stable Diffusion Webui to the Modal serverless environment.  
Create a uv environment on your local PC, install the modal module in it, and use that modal module to configure the basic Modal environment (configuration files will be saved in your local PC's global environment) and deploy to remote.

### Prerequisites
- [modal](https://modal.com/) account
- Modal token ID, token secret, and environment (it is recommended to create all of these newly for this webui deployment)
- uv
- Python version 3.11 installed in the global environment with `uv python install 3.11` (for some reason, version 3.11 is required due to compatibility between webui and modal)
- make (included by default in most Linux distributions or WSL2)

### Setup Instructions
1. Download this repository
2. Run `uv sync`
3. Create a new token from the Modal dashboard
4. Create a new environment with the command `modal environment create sd-webui`
5. Add a new profile to `~/.modal.toml` as follows:
```
[sd-webui]
token_id = "xxxxxxxxxxxxxxxxxxxxxxxxxx"
token_secret = "xxxxxxxxxxxxxxxxxxxxxxxx"
environment = "sd-webui"
active = true
```
6. Verify that the profile you want to use is active with `modal profile current`
7. After deploying with `make deploy`, a URL ending in `modal.run` will be issued, which becomes the application URL.

### How to Download Images
- Execute the script with `make pull`, and images created remotely will be saved under the outputs directory (organized by date)
- Each time you run this script, all images in the remote environment at that time will be downloaded, and those images will be completely deleted from the remote environment.

### How to Upload Local Models to Remote
- First, place each file in one of the following directories depending on the nature of each model file: `embeddings/`, `models/Lora/`, `models/Stable-diffusion/`, `models/VAE/` (main model files go in the Stable-diffusion directory)
- Display the command list with `make help` and refer to it to decide which command to use.

### ETC
- You can also add extensions easily, [Example](https://github.com/Zyin055/Config-Presets?tab=readme-ov-file#easy-way)
- Even if you completely stop a deployed app from the dashboard, you can redeploy it with `make deploy` to restore the same conditions and environment (each models, extensions, and previously generated images before running the deletion script, are all stored in Modal's persistent volume)

## 日本語

Stable Diffusion WebuiをModalサーバーレス環境にデプロイします。  
ローカルPC上にuv環境を作成してその中にmodalモジュールをインストールし、そのmodalモジュールを使用してmodalの基本環境設定（あなたのローカルPCのグローバル環境に設定ファイルが保存される）およびリモートへのデプロイを行います。

### 事前に必要になるもの
- [modal](https://modal.com/)のアカウント
- modalのトークンIDとトークンシークレットと環境（すべてこのwebuiデプロイ用に新規に発行・作成することを推奨）
- uv
- `uv python install 3.11`によってグローバル環境にインストールされたpython version 3.11（webuiとmodalの相性でなぜか3.11が必要になる）
- make （ほとんどのLinuxディストリビューションもしくはWSL2には標準で入っている）

### 手順
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

### 画像ダウンロード方法
- `make pull`でスクリプトを実行し、outputsディレクトリ以下にリモートで作成された画像が保存される（日付ごとに分けられます）
- このスクリプトを実行するごとに、その時点でリモート環境にあるすべての画像がダウンロードされるとともに、それらの画像がリモート環境からすべて削除される。

### ローカルにあるモデル等をリモートへアップロードする方法
- まず、それぞれのモデルファイルの性質ごとに、`embeddings/`, `models/Lora/`, `models/Stable-diffusion/`, `models/VAE/`のいずれかに各ファイルを置いてください（メインのモデルファイルはStable-diffusionディレクトリになります）
- `make help`でコマンド一覧を表示し、どのコマンドを使用するかはそちらを参考にしてください。 

### その他
- 拡張機能もインストールできます（[例](https://github.com/Zyin055/Config-Presets?tab=readme-ov-file#easy-way)）
- 一度デプロイしたアプリをダッシュボードから完全停止しても、再び`make deploy`することで、前回と同じ条件・環境でアプリが立ち上がり利用できます（各モデル、拡張機能、削除スクリプト実行前の前回の生成画像等はmodalサーバーの永続ボリュームに保管されています）