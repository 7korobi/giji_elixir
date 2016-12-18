# work MEMO

```

potofの村抜け、発言cardは返す。
村名を廃村にすると、廃村処理。

NPC参加０～３くらい。配布card制限

card状態
  連続制限
  能力使用回数残

card record value
  belongs to part
  belongs to potof
  to     (nil / potof)
  old_to (nil / potof)
  key     nil / ok / lose
  effect  nil / vote / bite / triumph / commit / ...etc 多数
  side    nil / sheep / vil / wolf / alien / love / hate
  target  nil / all / live / dead / you / npc / self
  passive  譲渡 / 簒奪 / 交換 / 取引

card

村の設定
  勝利判定自動計算 / 勝利宣言投票
  回数の配布ターンを調整
  完全公開 / 進行中、過去ログ非公開
  30秒すると、発言修正、削除を閉じる
  30分無発言でページ更新
  夜はtalkはclose. 投票時間．裏の相談時間．

chapter
section

  field :zapcount,  type: Integer
  field :clearance

  field :select
  field :live
  field :deathday,  type: Integer

  field :overhear,    type: Array

  field :bonds,       type: Array
  field :pseudobonds, type: Array

  field :love
  field :sheep
  field :pseudolove

  field :point, type: Hash
  field :say,   type: Hash
  field :timer, type: Hash

  index({story_id: 1})
  index({sow_auth_id: 1, story_id: 1}, {unique: 1})

  default_scope -> { order_by(:pno.asc) }

```


# install

```
mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
mix local.phoenix
mix deps.get
npm install
```

and mariadb install.

## 作成時覚書
```
mix phoenix.new giji_elixir
mix phoenix.server
```

# deploy

To start your Phoenix app:

```
mix phoenix.server
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## OpenID

* https://developers.facebook.com/apps
* https://console.developers.google.com/apis/credentials
* https://github.com/settings/developers

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
