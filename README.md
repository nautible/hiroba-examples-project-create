# GitLabおよびArgoCDによるプロジェクト環境構築確認用IaCコード

オブジェクトの広場 [GitLab、ArgoCDを用いたCI/CD環境の運用管理](https://ogis-ri.co.jp/otc/hiroba/technical/kubernetes_use/part8.html) 確認用IaCコードになります。

なお、本サンプルはAWS上での動作を前提としています。

## 環境変数

本リポジトリのIaCを実行する際、ローカル環境の環境変数に下記を設定してください。

- TF_VAR_gitlab_token
- TF_VAR_access_key
- TF_VAR_secret_key
- TF_VAR_ecr_uri

また、企業内環境などプロキシは以下で実行する場合は、下記環境変数も設定してください。

- TF_VAR_http_proxy
- TF_VAR_https_proxy
- TF_VAR_no_proxy

## 実行手順

手順についてはオブジェクトの広場記事を参考にしてください。
