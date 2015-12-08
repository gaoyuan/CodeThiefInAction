#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
https://tyrus.backlog.jp/view/NOAH-1423
①レイドイベントのアフターで既に報酬を受け取ってしまった人の1位報酬を回収してください。

EASYの1位報酬
item_id='101',item_num=5
item_id='51',item_num=5
item_id='41',item_num=3

NORMALの1位報酬
item_id='101',item_num=5
item_id='51',item_num=5
item_id='41',item_num=3

HARDの1位報酬
card_id ='40020',card_data={"level" : 4}
item_id='101',item_num=10
item_id='102',item_num=10
item_id='51',item_num=10
item_id='41',item_num=5

②既に報酬を受け取ってしまった人のフラグを受取済みから未受取に変更してください

"""

import models
from event_models.raid_event.raid_20151127 import EventUser


# 報酬を受け取ったユーザを探す
user_presents = {}
limit = 100
while True:
    event_users, next_skip = EventUser.find_by_cond({'log_data.presents': {'$exists': True}}, limit=limit)

    for event_user in event_users:
        user_presents[event_user.user.key()] = event_user.get_log('presents')

        # 報酬を受け取ってないことにする
        event_user.save_log('presents', [])
        event_user.put()

    if len(event_users) != limit:
        break


boss_rewards = {
    '2015112701':[
        {'item_id': '101', 'item_num': 5},
        {'item_id': '51', 'item_num': 5},
        {'item_id': '41', 'item_num': 3},
    ],
    '2015112702':[
        {'item_id': '101', 'item_num': 5},
        {'item_id': '51', 'item_num': 5},
        {'item_id': '41', 'item_num': 3},
    ],
    '2015112703':[
        {'card_id': '40020', 'card_data': {'level': 4}},
        {'item_id': '101', 'item_num': 10},
        {'item_id': '102', 'item_num': 10},
        {'item_id': '51', 'item_num': 10},
        {'item_id': '41', 'item_num': 5},
    ]
}
# 受け取った報酬を削除
for user_id, reward_keys in user_presents.items():
    for reward_key in reward_keys:
        user = models.User.get(user_id)
        rewards = boss_rewards[reward_key]

        for reward in rewards:
            if 'item_id' in reward:
                uitem = user.get_uitem(reward['item_id'])
                uitem.remove(reward['item_num'])
                user.update_uitem(uitem)
            else:
                # カード
                ucard = user.get_ucard(reward['card_id'])
                ucard.level -= reward['card_data']['level']
                user.update_ucard(ucard)

            user.put()