# gotoeat
食べログに掲載されている、GoToEatポイントが使える店舗を取得します。
ノーコードアプリGlideのバックデータが欲しかったため、作りました。

手順
1.sql/gotoeat.sqlをDBにインポート
  pagesテーブル：店舗リスト
  detailsテーブル：各店舗詳細情報
2.list_crawler.rbを実行し、店舗リストと各urlを取得
3.page_crawler.rbを実行し、上記で取得したurlからhtmlを取得
4.parser.rbを実行し、上記で取得したhtmlから店舗詳細情報を取得

絞り込み対象（page_crawler.rbで設定）
  都道府県：東京都
  星：3.6以上
  レビュー数：100以上