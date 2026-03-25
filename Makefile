.PHONY: deploy serve pull putmodel putdirmodel putlora putdirlora putvae putdirvae putembedding help

help:
	@echo "利用可能なコマンド:"
	@echo "  make deploy              - Modalにデプロイ"
	@echo "  make serve               - Modalのサーブモードで起動"
	@echo "  make pull                - 画像をローカルにダウンロード"
	@echo "  make putmodel <file>     - モデルをModal volumeにアップロード"
	@echo "  make putdirmodel         - モデルディレクトリ全体をアップロード"
	@echo "  make putlora <file>      - LoRAをModal volumeにアップロード"
	@echo "  make putdirlora          - LoRAディレクトリ全体をアップロード"
	@echo "  make putvae <file>       - VAEをModal volumeにアップロード"
	@echo "  make putdirvae           - VAEディレクトリ全体をアップロード"
	@echo "  make putembedding <file> - EmbeddingをModal volumeにアップロード"

deploy:
	uv run modal deploy main.py

serve:
	uv run modal serve main.py

pull:
	bash pullpic.sh

putmodel:
	@if [ "$(filter-out putmodel,$(MAKECMDGOALS))" = "" ]; then \
		echo "エラー: ファイル名を指定してください。使い方: make putmodel <filename>"; \
		exit 1; \
	fi
	@$(eval FILE := $(filter-out putmodel,$(MAKECMDGOALS)))
	uv run modal volume put sd_shared_models ./models/Stable-diffusion/$(FILE) /Stable-diffusion/

putdirmodel:
	uv run modal volume put sd_shared_models ./models/Stable-diffusion/ /Stable-diffusion/

putlora:
	@if [ "$(filter-out putlora,$(MAKECMDGOALS))" = "" ]; then \
		echo "エラー: ファイル名を指定してください。使い方: make putlora <filename>"; \
		exit 1; \
	fi
	@$(eval FILE := $(filter-out putlora,$(MAKECMDGOALS)))
	uv run modal volume put sd_shared_models ./models/Lora/$(FILE) /Lora/

putdirlora:
	uv run modal volume put sd_shared_models ./models/Lora/ /Lora/

putvae:
	@if [ "$(filter-out putvae,$(MAKECMDGOALS))" = "" ]; then \
		echo "エラー: ファイル名を指定してください。使い方: make putvae <filename>"; \
		exit 1; \
	fi
	@$(eval FILE := $(filter-out putvae,$(MAKECMDGOALS)))
	uv run modal volume put sd_shared_models ./models/VAE/$(FILE) /VAE/

putdirvae:
	uv run modal volume put sd_shared_models ./models/VAE/ /VAE/

putembedding:
	@if [ "$(filter-out putembedding,$(MAKECMDGOALS))" = "" ]; then \
		echo "エラー: ファイル名を指定してください。使い方: make putembedding <filename>"; \
		exit 1; \
	fi
	@$(eval FILE := $(filter-out putembedding,$(MAKECMDGOALS)))
	uv run modal volume put sd_shared_embeddings ./embeddings/$(FILE) /

%:
	@: