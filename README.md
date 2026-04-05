# EC2 自動起動・停止システム

## 概要
AWS EC2インスタンスの起動・停止を自動化するためのシェルスクリプトです。<br>
cronと組み合わせることで、定期的なインスタンス管理を実現しています。

## 作成背景
学習環境のEC2を手動で起動・停止していたため、以下の課題がありました。

- 起動・停止の手間
- 停止忘れによるコスト増加
- 複数インスタンス管理の煩雑さ

これらを解決するため、自動化スクリプトを作成しました。

## 構成
- start_ec2.sh：EC2起動スクリプト
- stop_ec2.sh：EC2停止スクリプト
- instance_list.txt：対象インスタンス一覧

## 主な機能
- EC2の起動・停止自動化
- 複数インスタンス対応（ループ処理）
- ログ出力（時刻・処理内容・結果・対象ID）
- エラー時のリトライ処理
- cronによる定期実行

## 工夫した点
- AWS CLIの戻り値を用いた成功/失敗判定
- ログ関数を作成し、INFO/ERRORで分類
- continueを使用し、一部失敗でも全体が止まらない設計
- cronとスクリプトの役割分離（保守性向上）

## 使用技術
- Linux（Amazon Linux 2）
- AWS（EC2 / IAM）
- Shell Script（bash）
- AWS CLI

## 実行方法
1　AWS CLI設定

- aws configure

2　実行権限付与

- chmod +x start_ec2.sh stop_ec2.sh

3　手動実行

- ./start_ec2.sh
- ./stop_ec2.sh

4 cron設定

- crontab -e

    0 9 * * 1-5 /home/shinobu_sato/start_ec2.sh<br>
    0 18 * * 1-5 /home/shinbu_sato/stop_ec2.sh<br>

## 今後の改善案
- Slack通知機能追加
- タグ指定による動的取得
- systemd timerへの移行
- Webヘルスチェックの追加

## 成果
- EC2運用の完全自動化
- コスト削減の実現
- 運用を意識したスクリプト設計を習得
