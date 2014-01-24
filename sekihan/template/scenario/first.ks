[loadplugin module="wuvorbis.dll"]
[loadplugin module="krmovie.dll"]
[loadplugin module="extrans.dll"]
[loadplugin module="wump3.dll"]
; マクロ定義
[call storage="macro.ks"] 
;
[playbgm storage=反照-Answer-仮.ogg loop=true]
; タイトルメニュー画面へ
;
[call storage="ext.ks"] 

;// ボタンを作ります

;// ボタンに画像を設定します
[sysbutton graphic="sy_auto" top=559 left=680 exp="SysBtn_onAutoReadButtonClick()"]
[sysbutton graphic="sy_save" top=559 left=585 exp="kag.callExtraConductor('save.ks','*save_menu')"]
[sysbutton graphic="sy_load" top=559 left=490 exp="kag.callExtraConductor('load.ks','*load_menu')"]
[sysbutton graphic="sy_config" top=559 left=395 exp="kag.callExtraConductor('config.ks','*config_menu')"]
[sysbutton graphic="sy_skip" top=559 left=300 exp="SysBtn_onSkipButtonClick()"]
[sysbutton graphic="hidden_botton" top=430 left=720 exp="SysBtn_onTextHideButtonClick()"]
; タイトルメニュー画面へ
;
[sysbutton_setopt visible =false]
[jump storage="title.ks"]
