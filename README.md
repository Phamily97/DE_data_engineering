Data engineering project creating pipelines using tools such as SQL and Python
Current features:
1. Simple ETL to move mock data to a PostgreSQL database
2. Creating a trigger that turns data changes into records, similar to SQL Server's Change-Data-Capture/CDC, and saving them to a special table
3. A pipeline that moves the changed records from PostgreSQL to MySQL.
4. A function to clean up data from MySQL (output is JSON)
5. Reading data using the FastAPI framework
When to use:
SQL Server's CDC has the problem of generating overflowing data. In that case, moving to another database reduces storage costs. Furthermore, there are also performance benefits.

Future development plans:
Data statistics in Grafana



SQLやPythonなどのツールによるパイプラインを作成するデータエンジニアプロジェクト
現在動いている特徴：
  1. PostgreSQLデータベースにモックデータを移動する簡単なETL
  2. SQLServerのChange-Data－Capture/CDCのようなデータの変更をレコードになるトリガーを作成で特別なテーブルに保存
  3. 変更をしたレコードはPostgreSQLからMySQLに移動するパイプライン。
  4. MySQLからデータを綺麗に出すファンクション（アウトプットはJSON）    
  5. FastAPIというフレームワークでデータを読む

使える場合：
SQLServerのCDCは溢れるデータを生む問題があります。その場合は他のデータベースに移動すれば保存する値段が減るようになります。更にパフォーマンス的にメリットも見えます。

未来開発するつもりところ：
Grafanaにデータの統計
