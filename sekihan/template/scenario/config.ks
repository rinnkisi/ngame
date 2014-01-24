; _config.ks…コンフィグ画面
; 使い方：
;   [call storage="config.ks" target=*config_menu]
; 注意事項：
;   ‐当サブルーチンではメモリ上の栞３を使用している
;   ‐当サブルーチン内で、右クリック時の設定を変更している。呼び出し側で元の設定に戻すこと（※重要）
;   ‐予め、Config.tjsの以下の項目を修正すること
;       numCharacterLayers    … 12以上（推奨）
;       characterMenu.visible … falseに変更
;       displayMenu.visible   … falseに変更
; 使用している変数：一部はconfig_t.ma内でも使用している
;   tf.conf_scr_x, tf.conf_scr_y         … ウィンドウ／フルスクリーン選択用マーカーの座標（配列）
;   tf.conf_spd_x, tf.conf_spd_y         … 文字表示速度用マーカーの座標（配列）
;   tf.conf_spdopt_x, tf.conf_spdopt_y   … 同、ページ末まで送るマーカーの座標（配列）
;   tf.conf_spd2_x, tf.conf_spd2_y       … 既読文字表示速度用マーカーの座標（配列）
;   tf.conf_spd2opt_x, tf.conf_spd2opt_y … 同、ページ末まで送るマーカーの座標（配列）
;   tf.conf_lnwt_x, tf.conf_lnwt_y       … 改行時のウェイト用マーカーの座標（配列）
;   tf.conf_pgwt_x, tf.conf_pgwt_y       … 改ページ時のウェイト用マーカーの座標（配列）
;   tf.conf_bgm_x, tf.conf_bgm_y         … BGM音量用メーターの座標（配列）
;   tf.conf_se_x, tf.conf_se_y           … SE音量用メーターの座標（配列）
;   tf.conf_lnwt_offset                  … 自動読み進みモード：改行ウェイトの１目盛りあたりのウェイト量
;   tf.conf_pgwt_offset                  … 自動読み進みモード：改ページウェイトの１目盛りあたりのウェイト量
;   tf.conf_i                            … ループカウンタ
;   tf.conf_ch_speed                     … 選択した文字表示速度（0:ノーウェイト、1:早い、2:普通、3:遅い）
;   tf.conf_ch_2nd_speed                 … 選択した既読文字表示速度（0:ノーウェイト、1:早い、2:普通、3:そのまま）
;   tf.conf_line_wait                    … 選択した改行時のウェイト速度（0～10）
;   tf.conf_page_wait                    … 選択した改ページ時のウェイト速度（0～10）
;   tf.conf_bgm_gvolume                  … 選択したBGM音量（0～10）
;   tf.conf_se_gvolume                   … 選択したSE音量（0～10）
;
*config_menu
; ウィンドウ／フルスクリーン選択用マーカーの座標を配列で用意
[eval exp="tf.conf_scr_x = [588, 588]" cond="tf.conf_scr_x === void"]
[eval exp="tf.conf_scr_y = [243, 300]" cond="tf.conf_scr_y === void"]
; BGM音量用メーターの座標を配列で用意
[eval exp="tf.conf_bgm_x = [141, 181, 216, 251, 288, 325, 361, 399, 436, 472, 507]" cond="tf.conf_bgm_x === void"]
[eval exp="tf.conf_bgm_y = [227, 227, 227, 227, 227, 227, 227, 227, 227, 227, 227]" cond="tf.conf_bgm_y === void"]
; SE音量用メーターの座標を配列で用意
[eval exp="tf.conf_se_x = [141, 181, 216, 251, 288, 325, 361, 399, 436, 472, 507]" cond="tf.conf_se_x === void"]
[eval exp="tf.conf_se_y = [291, 291, 291, 291, 291, 291, 291, 291, 291, 291, 291]" cond="tf.conf_se_y === void"]
; コンフィグ画面でマウス右クリックされたら、「戻る」と同じ動作をさせる
[rclick call=false jump=false]
; メモリ上の栞３に現在の状態を保存
[tempsave place=3]
; 全メッセージレイヤ表画面、全前景レイヤ表画面を非表示にする
[call storage="subroutine.ks" target=*sub_layernoshow]
; 前景レイヤが足りなければ追加（予めConfig.tjsのnumCharacterLayersを12以上にしておく方が良い）
[laycount layers=12 cond="kag.numCharacterLayers<12"]
; コンフィグ画面（クリッカブルマップ）を背景レイヤに表示
[image storage="config_back.png" layer=base page=fore]
; ウィンドウ／フルスクリーン状態のチェックマークを前景レイヤ０に表示
[image storage="window.png" layer=0 page=fore visible=true left="&tf.conf_scr_x[0]" top="&tf.conf_scr_y[0]" cond="!kag.fullScreen"]
[image storage="window.png" layer=0 page=fore visible=true left="&tf.conf_scr_x[1]" top="&tf.conf_scr_y[1]" cond="kag.fullScreen"]
; #2: メッセージ表示速度用インジケータ画像
[image layer=2 storage="pin.png" page=fore visible=true top=457]
; #3: オートモード速度用インジケータ画像
[image layer=3 storage="pin.png" page=fore visible=true top=529]
; BGM音量のマーカーを前景レイヤ4に表示
[image storage="ナイフ.png" layer=4 page=fore visible=true left="&tf.conf_bgm_x[kag.bgm.currentBuffer.volume2\10000]" top="&tf.conf_bgm_y[kag.bgm.currentBuffer.volume2\10000]"]
; SE音量のマーカーを前景レイヤ5に表示
[image storage="ナイフ.png" layer=5 page=fore visible=true left="&tf.conf_se_x[kag.se[0].volume2\10000]" top="&tf.conf_se_y[kag.se[0].volume2\10000]"]
; プリ選択用の初期化ボタンを前景レイヤ6に読み込み
[image storage="configp_restart.png" layer=6 page=fore visible=false]
; プリ選択用のタイトルボタンを前景レイヤ7に読み込み
[image storage="configp_title.png" layer=7 page=fore visible=false]
; プリ選択用のゲーム終了ボタンを前景レイヤ8に読み込み
[image storage="configp_exit.png" layer=8 page=fore visible=false]
; プリ選択用の「BACK」ボタンを前景レイヤ11に読み込み
[image storage="loadmode_back_bt.png" layer=11 page=fore visible=false]
; プリ選択用の「BACK」ボタンを前景レイヤ11に読み込み
[image storage="loadmode_back_bt.png" layer=11 page=fore visible=false]
; プリ選択用のチェックマークを前景レイヤ９に読み込み
[image storage="windowp.png" layer=9 page=fore visible=false]
; プリ選択用のオプションマークを前景レイヤ10に読み込み
[image storage="ナイフ.png" layer=10 page=fore opacity=128 visible=false]
; プリ選択用の「BACK」ボタンを前景レイヤ11に読み込み
[image storage="無題1.png" layer=11 page=fore visible=false]
; 各項目の表示を初期化します
[call target=*update_msgspeed]
[call target=*update_autospeed]
[history output=false enabled=false]
[sysbutton_erase]
; ユーザの操作を待ちます
[s]
; 「ウィンドウ」が選択された
*config_window
; マーカーの表示位置を変更
[layopt layer=0 page=fore visible=true left="&tf.conf_scr_x[0]" top="&tf.conf_scr_y[0]"]
; ウィンドウ表示にする
[eval exp="kag.onWindowedMenuItemClick(kag)"]
[s]
; 「フルスクリーン」が選択された
;
*config_fullscreen
; マーカーの表示位置を変更
[layopt layer=0 page=fore visible=true left="&tf.conf_scr_x[1]" top="&tf.conf_scr_y[1]"]
; フルスクリーンにする
[eval exp="kag.onFullScreenMenuItemClick(kag)"]
[s]
; 「メッセージ表示速度」のゲージをクリックした時に実行されるスクリプト
*msgspeed
[eval exp="kag.userChSpeed = 100 - (kag.fore.base.cursorX - 224) * 100 \ 489"]
[call target=*update_msgspeed]
[s]
; メッセージ表示速度のインジケータの表示を更新します
*update_msgspeed
[layopt layer=2 page=fore left="&702 - kag.userChSpeed * 489 \ 100"]
[return]
[s]
; 「オートモード速度」のゲージをクリックした時に実行されるスクリプト
*autospeed
[eval exp="kag.autoModePageWait = 4000 - (kag.fore.base.cursorX - 224) * 3900 \ 490"]
[eval exp="kag.autoModeLineWait = 2000 - (kag.fore.base.cursorX - 224) * 1950 \ 490"]
[call target=*update_autospeed]
[s]
; オートモード速度のインジケータの表示を更新します
*update_autospeed
[layopt layer=3 page=fore left="&213 + (4000 - kag.autoModePageWait) * 490 \ 3900"]
[return]
[s]
; BGM音量メーターがクリックされた
*config_bgm_gvolume
; マーカーの表示位置を変更
[layopt layer=4 page=fore visible=true left="&tf.conf_bgm_x[tf.conf_bgm_gvolume\10]" top="&tf.conf_bgm_y[tf.conf_bgm_gvolume\10]"]
; BGMの大域音量を変更
[bgmopt gvolume="&tf.conf_bgm_gvolume"]
[s]
; 効果音音量メーターがクリックされた
;
*config_se_gvolume
; マーカーの表示位置を変更
[layopt layer=5 page=fore visible=true left="&tf.conf_se_x[tf.conf_se_gvolume\10]" top="&tf.conf_se_y[tf.conf_se_gvolume\10]"]
; 全効果音の大域音量を変更
[eval exp="tf.conf_i=0"]
*config_se_gvolume_loop
	[seopt buf="&tf.conf_i" gvolume="&tf.conf_se_gvolume"]
	[jump target=*config_se_gvolume_loop cond="++tf.conf_i<kag.numSEBuffers"]
[s]
;タイトルに戻るが選択された
;
*config_title
;[jump storage="title.ks"target="gotostart"]
[gotostart]
[s]
;
;ゲームを終了するが選択された
;
*config_exit
[eval exp="kag.closeByScript(%['ask'=>'true'])"]
[s]
;
;設定の初期化がおされた
*config_restart
[layopt layer=0 page=fore visible=true left="&tf.conf_scr_x[0]" top="&tf.conf_scr_y[0]"]
; ウィンドウ表示にする
[eval exp="kag.onWindowedMenuItemClick(kag)"]
[eval exp="kag.userChSpeed = 100 - (468 - 224) * 100 \ 489"]
[layopt layer=2 page=fore left="&702 - kag.userChSpeed * 489 \ 100"]
[eval exp="kag.autoModePageWait = 4000 - (468 - 224) * 3900 \ 490"]
[eval exp="kag.autoModeLineWait = 2000 - (468 - 224) * 1950 \ 490"]
[layopt layer=3 page=fore left="&213 + (4000 - kag.autoModePageWait) * 490 \ 3900"]
;BGM
; マーカーの表示位置を変更
[layopt layer=4 page=fore visible=true left="&tf.conf_bgm_x[5]" top="&tf.conf_bgm_y[5]"]
; BGMの大域音量を変更
[bgmopt gvolume="&50"]
; 効果音音量メーターがクリックされた
; マーカーの表示位置を変更
[layopt layer=5 page=fore visible=true left="&tf.conf_se_x[5]" top="&tf.conf_se_y[5]"]
; 全効果音の大域音量を変更
	[seopt buf="&0" gvolume="&50"]
[s]
; 「戻る」が選択された／マウス右クリックされた
;
*config_return
; メモリ上の栞３を読み込み、状態復帰
[tempload place=3]
[rclick call=false jump=false]
; メッセージ履歴の出力・表示を有効にします
[history output=true enabled=true]
; メッセージ表示速度の設定を反映します
[delay speed=user cond="kag.chUserMode"]
; 戻る（※呼び出し側でマウス右クリックの設定を元に戻すこと）
[return]