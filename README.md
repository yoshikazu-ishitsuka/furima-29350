# README

# テーブル設計

## users テーブル

| Column          | Type   | Options     |
| --------------- | ------ | ----------- |
| nickname        | string | null: false |
| email           | string | null: false |
| password        | string | null: false |
| last_name       | string | null: false |
| first_name      | string | null: false |
| last_name_kana  | string | null: false |
| first_name_kana | string | null: false |
| birthday        | date   | null: false |

### Association

- has_many :user_items
- has_many :items, through: user_items
- has_many :comments

## items テーブル

| Column              | Type    | Options     |
| ------------------- | ------  | ----------- |
| image               | string  | null: false |
| goods               | string  | null: false |
| details             | text    | null: false |
| category            | string  | null: false |
| status              | string  | null: false |
| shipping_fee_burden | string  | null: false |
| shipping_area       | string  | null: false |
| days_to_ship        | string  | null: false |
| price               | integer | null: false |

### Association

- has_many :user_items
- has_many :users, through: user_items
- has_many :comments
- has_one :credit_card

## user_items テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## credit_cards テーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| credit_card_number | integer    | null: false |
| expiration_date    | integer    | null: false |
| security_code      | integer    | null: false |

### Association

belongs_to :item
has_one :shipping_address

## shipping_addresses

| Column         | Type    | Options     |
| -------------- | ------- | ----------- |
| postal_code    | integer | null: false |
| prefectures    | string  | null: false |
| address_line_1 | string  | null: false |
| address_line_2 | string  | null: false |
| address_line_3 | string  |             |
| phone_number   | integer | null: false |

### Association

belongs_to :credit_card

## comments テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| text   | string     | null: false                    |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

belongs_to :user
belongs_to :item