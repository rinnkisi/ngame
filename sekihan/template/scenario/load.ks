; load.ks…ロード画面
; 使い方：
;   [call storage="rclick_load.ks" target=*load_menu]
; 注意事項：
;   ‐当サブルーチンではメモリ上の栞１を使用している
;   ‐当サブルーチン内で、右クリック時の設定を変更している。呼び出し側で元の設定に戻すこと（※重要）
;   ‐予め、Config.tjsの以下の項目を修正すること
;       numCharacterLayers  … 4以上（推奨）
;       restoreMenu.visible … falseに変更
; 使用している変数：一部はload_bg_normal.ma内でも使用している
;   sf.load_now_page               … 現在、表示中のページ（0～9）
;   tf.load_message                … ロード画面を作るメッセージレイヤ名
;   tf.load_i                      … ループカウンタ
;   tf.load_x, tf.load_y           … サムネイル画像を描画する座標（配列）
;   tf.load_column                 … サムネイル画像を描画する列
;   tf.load_line                   … サムネイル画像を描画する行
;   tf.load_page_x, tf.load_page_y … ページ番号画像を描画する座標（配列）
;   tf.load_ent_button             … マウスが乗ったときに描画するページ番号画像ファイル名（配列）
;   tf.load_now_button             … 現在、表示中であることを示すページ番号画像ファイル名（配列）
;   tf.load_index                  … クリックされたサムネイル画像の番号
;
*load_menu
; メモリ上の栞１に現在の状態を保存
[tempsave place=1]
[sysbutton_erase]
[history output=false enabled=false]
; ロード画面でマウス右クリックされたら、「戻る」と同じ動作をさせる
[rclick call=false jump=false]
; ロード画面を表示するメッセージレイヤ名
[eval exp="tf.load_message = 'message1'"]
; サムネイル画像を描画する座標を算出し、配列に格納しておく
[eval exp="tf.load_x = []" cond="tf.load_x === void"]
[eval exp="tf.load_y = []" cond="tf.load_y === void"]
[eval exp="tf.load_i=0"]
*load_menu_loop0
	; サムネイル画像を描画する列を計算
	[eval exp="tf.load_column = tf.load_i % 5"]
	; サムネイル画像を描画する行を計算
	[eval exp="tf.load_line   = tf.load_i \ 5"]
	; サムネイル画像を描画する座標を計算し、配列に格納
	[eval exp="tf.load_x[tf.load_i] = 11 + 157*tf.load_column"]
	[eval exp="tf.load_y[tf.load_i] = 131 + 145*tf.load_line"]
	[jump target=*load_menu_loop0 cond="++tf.load_i<10"]

; ページ用ボタンを表示する座標の配列
[eval exp="tf.load_page_x = [205, 289, 372, 453, 532, 207, 289, 372, 453, 533]" cond="tf.load_page_x === void"]
[eval exp="tf.load_page_y = [  5,   5,   5,   5,   5,   69,   69,   69,   69,   69]" cond="tf.load_page_y === void"]
; マウスが乗ったときに描画するページ番号画像ファイル名の配列
[eval exp="tf.load_ent_button = ['mode01.png', 'mode02.png', 'mode03.png', 'mode04.png', 'mode05.png', 'mode06.png', 'mode07.png', 'mode08.png', 'mode09.png', 'mode10.png']" cond="tf.load_ent_button === void"]
; 現在、表示中であることを示すページ番号画像ファイル名の配列
[eval exp="tf.load_now_button = ['modenow01.png', 'modenow02.png', 'modenow03.png', 'modenow04.png', 'modenow05.png', 'modenow06.png', 'modenow07.png', 'modenow08.png', 'modenow09.png', 'modenow10.png']" cond="tf.load_now_button === void"]
; 現在、表示中のページ（初めてロード画面が呼び出されたら０を代入する）
[eval exp="sf.load_now_page = 0" cond="sf.load_now_page === void"]

; 全メッセージレイヤ表画面、全前景レイヤ表画面を非表示にする
[call storage="subroutine.ks" target=*sub_layernoshow]
; 前景レイヤが足りなければ追加（予めConfig.tjsのnumCharacterLayersを4以上にしておく方が良い）
[laycount layers=4 cond="kag.numCharacterLayers<4"]
; カレントのメッセージレイヤを変更
[current layer="&tf.load_message" page=fore]
; メッセージレイヤの属性を設定；セーブデータの日付と見出しを描画する
[position layer="&tf.load_message" page=fore left=15 top=490 width=500 height=100 frame="" color=0x000000 opacity=0 marginl=5 margint=-3 marginr=0 marginb=0 vertical=false draggable=false visible=true]
; メッセージレイヤのクリア
[er]
; フォントを変更
[font size=26 face="ＭＳ ゴシック" color=0xFFFFFF italic=false rubysize=10 rubyoffset=0 shadow=false edge=false edgecolor=0x000000 shadowcolor=0x000000 bold=false]

; クリッカブルマップがクリックされたら、サムネイル画像の変更が反映されるよう*load_redrawに戻って再描画する
*load_redraw
; 背景レイヤ表画面にセーブデータ一覧用画像を読み込み、表示（クリッカブルマップが機能する）
[image storage="load_bg_normal.png" layer=base page=fore]
; 現在のページボタンを前景レイヤ０に読み込み
[image storage="&tf.load_now_button[sf.load_now_page]" layer=0 page=fore visible=true left="&tf.load_page_x[sf.load_now_page]" top="&tf.load_page_y[sf.load_now_page]"]
; プリ選択用のサムネイル画像を前景レイヤ１に読み込み
[image storage="thumbnail_preview_mouseover.png" layer=1 page=fore visible=false]
; プリ選択用の「閉じる」ボタンを前景レイヤ２に読み込み
[image storage="loadmode_back_bt.png" layer=2 page=fore visible=false]
; セーブデータの数ぶん繰り返す
[eval exp="tf.load_i=0"]
*load_menu_loop1
	; セーブデータが存在するなら…
	[if exp="kag.getBookMarkDate(sf.load_now_page*10+tf.load_i) != ''"]
		; サムネイル画像を背景レイヤ表画面に追加読み込み
		[pimage storage="&kag.getBookMarkFileNameAtNum(sf.load_now_page*10+tf.load_i)" layer=base page=fore dx="&tf.load_x[tf.load_i]" dy="&tf.load_y[tf.load_i]" sw="&kag.thumbnailWidth" sh="&kag.thumbnailWidth*kag.scHeight\kag.scWidth"]
	[endif]
	[jump target=*load_menu_loop1 cond="++tf.load_i<10"]
[s]
;
; サムネイル画像がクリックされた
;
*load_click
; 栞をたどる
[load place="&sf.load_now_page*10+tf.load_index" ask=true]
[s]
; ページ番号がクリックされた
*load_click_page
; 現在のページボタンを前景レイヤ０に読み込み
[image storage="&tf.load_now_button[sf.load_now_page]" layer=0 page=fore visible=true left="&tf.load_page_x[sf.load_now_page]" top="&tf.load_page_y[sf.load_now_page]"]
[jump target=*load_redraw]
;
; 「戻る」が選択された
*load_return
; メッセージ履歴の出力・表示を有効にします
[history output=true enabled=true]
; メモリ上の栞１を読み込み、状態復帰
[tempload place=1]

; 戻る（※呼び出し側でマウス右クリックの設定を元に戻すこと）
[return]
