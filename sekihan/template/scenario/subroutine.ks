;
; subroutine.ks…サブルーチン集
;
;
; 全メッセージレイヤ表画面、全前景レイヤ表画面を非表示にする
;
; 使い方：
;   [call storage="subroutine.ks" target=*sub_layernoshow]
;
; 注意事項：
;   ‐前景レイヤの透明度は完全不透明（255）に変更する
;
; 使用している変数：
;   tf.sub_i … ループカウンタ
;
*sub_layernoshow
; 全メッセージレイヤ表画面を非表示
[eval exp="tf.sub_i = 0"]
*sub_layernoshow_loop0
	[layopt layer="&'message'+tf.sub_i" page=fore visible=false]
	[jump target=*sub_layernoshow_loop0 cond="++tf.sub_i < kag.numMessageLayers"]
; 全前景レイヤ表画面を非表示
[eval exp="tf.sub_i = 0"]
*sub_layernoshow_loop1
	[layopt layer="&tf.sub_i" page=fore visible=false opacity=255]
	[jump target=*sub_layernoshow_loop1 cond="++tf.sub_i < kag.numCharacterLayers"]
[return]
