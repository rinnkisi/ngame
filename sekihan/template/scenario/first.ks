[loadplugin module="wuvorbis.dll"]
[loadplugin module="krmovie.dll"]
[loadplugin module="extrans.dll"]
[loadplugin module="wump3.dll"]
; �}�N����`
[call storage="macro.ks"] 
;
[playbgm storage=����-Answer-��.ogg loop=true]
; �^�C�g�����j���[��ʂ�
;
[call storage="ext.ks"] 

;// �{�^�������܂�

;// �{�^���ɉ摜��ݒ肵�܂�
[sysbutton graphic="sy_auto" top=559 left=680 exp="SysBtn_onAutoReadButtonClick()"]
[sysbutton graphic="sy_save" top=559 left=585 exp="kag.callExtraConductor('save.ks','*save_menu')"]
[sysbutton graphic="sy_load" top=559 left=490 exp="kag.callExtraConductor('load.ks','*load_menu')"]
[sysbutton graphic="sy_config" top=559 left=395 exp="kag.callExtraConductor('config.ks','*config_menu')"]
[sysbutton graphic="sy_skip" top=559 left=300 exp="SysBtn_onSkipButtonClick()"]
[sysbutton graphic="hidden_botton" top=430 left=720 exp="SysBtn_onTextHideButtonClick()"]
; �^�C�g�����j���[��ʂ�
;
[sysbutton_setopt visible =false]
[jump storage="title.ks"]
