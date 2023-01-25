# テーブル設計

## usersテーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birthdate          | date   | null: false               |

### Association

- has_many :items
- has_many :purchases

## itemsテーブル

| Column           | Type        | Options                        |
| ---------------- | ----------- | ------------------------------ |
| product          | string      | null: false                    |
| description      | text        | null: false                    |
| category_id      | integer     | null: false                    |
| condition_id     | integer     | null: false                    |
| shipping_cost_id | integer     | null: false                    |
| prefecture_id    | integer     | null: false                    |
| delivery_time_id | integer     | null: false                    |
| price            | integer     | null: false                    |
| user             | references  | null: false, foreign_key: true |

### Association

belongs_to :user
has_one :purchase


## purchasesテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| item   | references | null: false, foreign_key: true |
| user   | references | null: false, foreign_key: true |

### Association

belongs_to :user
belongs_to :item
has_one :address

## addressesテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postalcode    | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| block         | string     | null: false                    |
| building      | string     | null: false                    |
| phone_number  | string     | null: false                    |
| purchase      | references | null: false, foreign_key: true |

### Association

belongs_to :purchase