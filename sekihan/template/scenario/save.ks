; save.ks…セーブ画面
; 使い方：
;   [call storage="rclick_save.ks" target=*save_menu]
; 注意事項：

;   ‐当サブルーチンではメモリ上の栞２を使用している
;   ‐予め、Config.tjsの以下の項目を修正すること
;       numCharacterLayers  … 4以上（推奨）
;       storeMenu.visible … falseに変更
; 使用している変数：一部はsavemode_bg_normal.ma内でも使用している
;   sf.save_now_page               … 現在、表示中のページ（0～9）
;   tf.save_message              … セーブ画面を作るメッセージレイヤ名
;   tf.save_i                      … ループカウンタ
;   tf.save_x, tf.save_y           … サムネイル画像を描画する座標（配列）
;   tf.save_column                 … サムネイル画像を描画する列
;   tf.save_line                   … サムネイル画像を描画する行
;   tf.save_page_x, tf.save_page_y … ページ番号画像を描画する座標（配列）
;   tf.save_ent_button             … マウスが乗ったときに描画するページ番号画像ファイル名（配列）
;   tf.save_now_button             … 現在、表示中であることを示すページ番号画像ファイル名（配列）
;   tf.save_index                  … クリックされたサムネイル画像の番号
;
*save_menu
; メモリ上の栞２に現在の状態を保存
[tempsave place=2]
[locksnapshot]
[sysbutton_erase]
[history output=false enabled=false]
; セーブ画面でマウス右クリックされたら、「戻る」と同じ動作をさせる
;[rclick call=false jump=false]

; ロード画面を表示するメッセージレイヤ名
[eval exp="tf.save_message = 'message1'"]
; サムネイル画像を描画する座標を算出し、配列に格納しておく
[eval exp="tf.save_x = []" cond="tf.save_x === void"]
[eval exp="tf.save_y = []" cond="tf.save_y === void"]
[eval exp="tf.save_i=0"]
*save_menu_loop0
	; サムネイル画像を描画する列を計算
	[eval exp="tf.save_column = tf.save_i % 5"]
	; サムネイル画像を描画する行を計算
	[eval exp="tf.save_line   = tf.save_i \ 5"]
	; サムネイル画像を描画する座標を計算し、配列に格納
	[eval exp="tf.save_x[tf.save_i] = 10 + 157*tf.save_column"]
	[eval exp="tf.save_y[tf.save_i] = 132 + 145*tf.save_line"]
	[jump target=*save_menu_loop0 cond="++tf.save_i<10"]

; ページ用ボタンを表示する座標の配列
[eval exp="tf.save_page_x = [205, 289, 372, 453, 532, 207, 289, 372, 453, 533]" cond="tf.save_page_x === void"]
[eval exp="tf.save_page_y = [  5,   5,   5,   5,   5,   69,   69,   69,   69,   69]" cond="tf.save_page_y === void"]
; マウスが乗ったときに描画するページ番号画像ファイル名の配列
[eval exp="tf.save_ent_button = ['mode01.png', 'mode02.png', 'mode03.png', 'mode04.png', 'mode05.png', 'mode06.png', 'mode07.png', 'mode08.png', 'mode09.png', 'mode10.png']" cond="tf.save_ent_button === void"]
; 現在、表示中であることを示すページ番号画像ファイル名の配列
[eval exp="tf.save_now_button = ['modenow01.png', 'modenow02.png', 'modenow03.png', 'modenow04.png', 'modenow05.png', 'modenow06.png', 'modenow07.png', 'modenow08.png', 'modenow09.png', 'modenow10.png']" cond="tf.save_now_button === void"]
; 現在、表示中のページ（初めてセーブ画面が呼び出されたら０を代入する）
[eval exp="sf.save_now_page = 0" cond="sf.save_now_page === void"]

; 全メッセージレイヤ表画面、全前景レイヤ表画面を非表示にする
[call storage="subroutine.ks" target=*sub_layernoshow]
; 前景レイヤが足りなければ追加（予めConfig.tjsのnumCharacterLayersを4以上にしておく方が良い）
[laycount layers=4 cond="kag.numCharacterLayers<4"]
; カレントのメッセージレイヤを変更
[current layer="&tf.save_message" page=fore]
; メッセージレイヤの属性を設定；セーブデータの日付と見出しを描画する
[position layer="&tf.save_message" page=fore left=15 top=490 width=500 height=100 frame="" color=0x000000 opacity=0 marginl=5 margint=-3 marginr=0 marginb=0 vertical=false draggable=false visible=true]
; メッセージレイヤのクリア
[er]
; フォントを変更
[font size=26 face="ＭＳ ゴシック" color=0xFFFFFF italic=false rubysize=10 rubyoffset=0 shadow=false edge=false edgecolor=0x000000 shadowcolor=0x000000 bold=false]

; クリッカブルマップがクリックされたら、サムネイル画像の変更が反映されるよう*save_redrawに戻って再描画する
*save_redraw
; 背景レイヤ表画面にセーブデータ一覧用画像を読み込み、表示（クリッカブルマップが機能する）
[image storage="save_bg_normal.png" layer=base page=fore]
; 現在のページボタンを前景レイヤ０に読み込み
[image storage="&tf.save_now_button[sf.save_now_page]" layer=0 page=fore visible=true left="&tf.save_page_x[sf.save_now_page]" top="&tf.save_page_y[sf.save_now_page]"]
; プリ選択用のサムネイル画像を前景レイヤ１に読み込み
[image storage="thumbnail_preview_mouseover.png" layer=1 page=fore visible=false]
; プリ選択用の「閉じる」ボタンを前景レイヤ２に読み込み
[image storage="savemode_back_bt.png" layer=2 page=fore visible=false]
; セーブデータの数ぶん繰り返す
[eval exp="tf.save_i=0"]
*save_menu_loop1
	; セーブデータが存在するなら…
	[if exp="kag.getBookMarkDate(sf.save_now_page*10+tf.save_i) != ''"]
		; サムネイル画像を背景レイヤ表画面に追加読み込み
		[pimage storage="&kag.getBookMarkFileNameAtNum(sf.save_now_page*10+tf.save_i)" layer=base page=fore dx="&tf.save_x[tf.save_i]" dy="&tf.save_y[tf.save_i]" sw="&kag.thumbnailWidth" sh="&kag.thumbnailWidth*kag.scHeight\kag.scWidth"]
	[endif]
	[jump target=*save_menu_loop1 cond="++tf.save_i<10"]
[s]
;
; サムネイル画像がクリックされた
;
*save_click
; 栞に挟む
[save place="&sf.save_now_page*10+tf.save_index" ask=true]
[jump target=*save_redraw]
;
; ページ番号がクリックされた
;
*save_click_page
; 現在のページボタンを前景レイヤ０に読み込み
[image storage="&tf.save_now_button[sf.save_now_page]" layer=0 page=fore visible=true left="&tf.save_page_x[sf.save_now_page]" top="&tf.save_page_y[sf.save_now_page]"]
[jump target=*save_redraw]
;
; 「戻る」が選択された
*save_return
; メッセージ履歴の出力・表示を有効にします
[history output=true enabled=true]
; メモリ上の栞２を読み込み、状態復帰
[tempload place=2]
[history output=true enabled=true]
; スナップショットをアンロックします
[unlocksnapshot]
; 戻る
[return]
