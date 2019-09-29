# Study App
学習記録SNS
https://study-app.net/

# 概要
受験勉強や資格試験など、あらゆる学習時間を記録して見える化するサービスです。
勉強時間の積み重ねを見える化することで、学習へのモチベーションを高めます。
また他のユーザーの学習時間も確認できるので、グループ内で競い合うことも出来ます。

かんたんログインからワンクリックで使用感の確認が出来ます。

# 実装した機能
* ユーザー機能
  * 新規登録
  * 詳細表示
  * 検索
  * アカウントの変更、削除
  * ログイン、ログアウト

* 投稿機能
  * 学習記録の投稿、削除
  * 画像のアップロード機能

* 学習時間の表示
  * 日、週、月ごとの学習時間を数字で表示
  * 日、週、月ごとの学習時間をグラフで表示

# 使用技術
* 開発環境
  * Docker
* 本番環境
  * AWS
    * EC2
    * RDS
    * S3
    * ROUTE53
* 使用言語/フレームワーク
  * Ruby 2.5.5
  * Ruby on Rails 5.2.3
