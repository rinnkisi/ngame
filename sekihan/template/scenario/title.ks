; title.ks…タイトルメニュー画面
;
; 使い方
;   [jump storage="title.ks"]
;
; 注意事項：
;   ‐first.ksからジャンプしてくること
;   ‐ラベルtitle_menuは、吉里吉里/KAG起動時、最初に通過する「セーブ可能なラベル」であること（gotostartタグで「最初に戻る」のに使う）
;   ‐ロード画面、コンフィグ画面は「右クリックサブルーチンを作ろう」のload.ks,config.ksを用いる※ただし右クリック処理は今回は変えている
;
; 使用している変数：
;   tf.title_message … グラフィカルボタンを表示するメッセージレイヤ名（右クリックサブルーチン用メッセージレイヤと同じでも良い）
;
*title_menu|タイトルメニュー
; 「最初に戻る」を有効にする↓
[startanchor]
;ここでシステムボタンを非表示にする
[sysbutton_setopt visible =false]
; シーン回想中に「システム‐最初に戻る」メニューが選択された場合の辻褄合わせを行う
;[call storage="scene.ks" target=*scene_reset] 一旦コメントアウト　12月17日
; 全メッセージレイヤ表画面、全前景レイヤ表画面を非表示にする
[call storage="subroutine.ks" target=*sub_layernoshow]
; タイトル画面でグラフィカルボタンを表示するメッセージレイヤ名
[eval exp="tf.title_message = 'message1'"]
; メッセージ履歴への出力を停止し、表示不可にする
[history output=false enabled=false]
; 栞にはさめなくする（↑のセーブ可能なラベルtitle_menuは「最初に戻る」ためにのみ使用する）
[disablestore store=true restore=false]
; 右クリックを無効にする
[rclick enabled=false]
; タイトルメニュー画面を背景レイヤ表画面に読み込む
[image storage="title_bg.jpg" layer=base page=fore]
; タイトルメニュー画面用メッセージレイヤの各種設定
[position layer="&tf.title_message" page=fore left=0 top=0 width="&kag.scWidth" height="&kag.scHeight" frame="" color=0x000000 opacity=0 marginl=0 margint=0 marginr=0 marginb=0 draggable=false visible=true]
[layopt layer="&tf.title_message" page=fore visible=true]
[current layer="&tf.title_message" page=fore]
; ノーウェイト
[delay speed=nowait]

; ↓各メニューから戻ってくるラベル
*title_menu_loop
; メッセージレイヤをクリア
[er]
; グラフィカルボタン「START」～「EXIT」を配置
[locate x=100 y=235]
[button graphic="title_bt_start.png" target=*title_menu_start hint="ゲーム開始"]
[locate x=180 y=310]
[button graphic="title_bt_load.png" target=*title_menu_load hint="途中から再開"]
[locate x=260 y=385]
[button graphic="title_bt_config.png" target=*title_menu_config hint="設定"]
[locate x=340 y=460]
[button graphic="title_bt_exit.png" target=*title_exit hint="終了"]
[s]
;
; 「途中から再開」が選択された

*title_menu_load
 たロード画面を呼び出す
[call storage="load.ks" target=*load_menu]
 マウス右クリックされたときの動作を元に戻す（load.ks内でマウス右クリックの設定が変わっているため）
;[rclick enable]
[rclick call=false jump=false]
[jump target=*title_menu_loop]
 「設定」が選択された
*title_menu_config
; たコンフィグ画面を呼び出す
[call storage="config.ks" target=*config_menu]
; マウス右クリックされたときの動作を元に戻す（config.ks内でマウス右クリックの設定が変わっているため）

[rclick call=false jump=false]
[jump target=*title_menu_loop]
;
[s]
;ゲームを終了するが選択された
;
*title_exit
[eval exp="kag.closeByScript(%['ask'=>'true'])"]
[jump target=*title_menu_loop]
[s]



; 「ゲーム開始」が選択された；設定を復帰する
;
*title_menu_start
; ウェイト解除
[delay speed=user]
; タイトルメニュー画面用メッセージレイヤを非表示
[layopt layer="&tf.title_message" page=fore visible=false]
; 栞にはさめるようにする
[disablestore store=false restore=false]
; メッセージ履歴への出力を再開、表示可にする
[history output=true enabled=true]
; 右クリックサブルーチンの設定を変更
[rclick call=false jump=false]


; 実際のシナリオ１へ…
;
[jump storage="chapter_1.ks"]
