## 要件

- ログインログアウト機能がある
- ユーザーはニックネームとアバター画像を登録できる
- ユーザーは質問を投稿できる
- ユーザーは自分の質問を編集・削除できる
- ユーザーは質問に対して回答ができる
- ユーザーは質問を解決済み状態に変更できる
- ユーザーは質問を検索できる
- 質問があった際に全員に対して質問があった旨をメールで通知する（ただし自分は除く）
- 質問に対して回答があった場合は質問者および当該質問に回答したユーザーに対してメールで通知する。（ただし自分は除く）
- 質問はページングできる
- 管理画面がある
- 管理画面へは権限を付与されたユーザーしか入れない
- 管理画面では全てのリソースを削除できる

### テーブル設計

```mermaid
erDiagram
users ||--o{ questions: "1:n"
questions ||--o{ answers: "1:n"
questions ||--|{ mail_jobs: "1:1"

users {
  number id PK
  string name "ニックネーム"
  timestamp created_at "作成時刻"
  timestamp updated_at "更新時刻"
  timestamp deleted_at "削除時刻"
  blob avatar "アバター画像"
  boolean admin_status "管理者かどうか"
}

questions{
  number id PK
  string title "タイトル"
  string content "内容"
  boolean stats "ステータス"
  number created_user_id
  timestamp created_at "作成時刻"
  timestamp updated_at "更新時刻"
  timestamp deleted_at "削除時刻"
}

answers{
  number id PK
  string content
  number related_question_id
  timestamp created_at "作成時刻"
  timestamp updated_at "更新時刻"
  timestamp deleted_at "削除時刻"
}

mail_jobs{
  number id PK
  number related_question_id
  timestamp sended_at "送信時刻"
  boolean status "送信ステータス"
}



```
