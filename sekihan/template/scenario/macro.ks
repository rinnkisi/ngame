[macro name=lrcm]
[l][r][cm]
[endmacro]
; fadeoutmessageマクロメッセージのフェードアウト
; KAGシナリオファイル中に[fadeoutmessage]と書けば、
; [backlay][layopt layer=message ……][trans time=1000 ……][wt]と書いたのと同じ
;システムボタンの非表示
[macro name=fadeoutmessage]
	[sysbutton_setopt visible =false]
	[backlay]
	[layopt layer=message page=back visible=false top=432 width=780 height=154]
	[trans time=1000 method=crossfade]
	[wt]
[endmacro]

; fadeinmessageマクロメッセージのフェードイン
;システムボタンの表示
[macro name=fadeinmessage]
	[ct]
	[layopt layer=message page=back visible=true top=432 width=780 height=154]
	[trans time=1000 method=crossfade]
	[wt]
	[sysbutton_setopt visible =true]
[endmacro]

; transcomboマクロ
;
[macro name=transcombo]
	[image storage=%storage layer=base page=back]
	[trans *]
	[wt]
[endmacro]

[return]