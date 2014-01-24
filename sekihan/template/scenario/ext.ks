;�O������̃v���O�C��

[return cond="typeof(global.ExtSystemButton) != 'undefined'"]

; ��ʂɃV�X�e���{�^����ǉ�����v���O�C�� by KAICHO
; systembutton.ks �� TJS �̒m�����K�v���������A����� KAG ����g����

; Ver 0.9a2013/11/28
;	�EKrclick.ks�ɂ��킹�邽�߂ɁA*rclick_load��*krclick_load�ȂǂɕύX
; Ver 0.9 2011/12/04
;	�E�{�^�����w�肷��ID��key=����name=�ɕύX�BloadImages()��key=��
;	�@���̂܂܂킽���āA���F(key=0)���摜�̓����L�[�Ƃ��ė��p�����
;	�@���܂��Ă������߁B
; Ver 0.8 2011/07/30
;	�Eskip�ۂ�kag.nextSkipEnabled ���`�F�b�N����悤�ɕύX
;	�Ehistory�\���ۂ�kag.historyEnabled���`�F�b�N����悤�ɕύX
; Ver 0.7 2011/06/20
;	�Ecalltarget=��ǉ��BextraConductor���g����[call]����B
; Ver 0.6 2011/02/21
;	�Esysbtn �쐬���A���w��Ȃ� enabled = kag.inStable �ɂ���悤�ύX
;	�E[sysbutton_setopt]�Ŏ���setOptions���Ă�łȂ������̂��C��
; Ver 0.5 2011/01/01
;	�EKLayers��KLayersPluginOnMessage���Q�Ƃ���悤�ύX
; Ver 0.3 2010/11/27
;	�EKLayersPlugin �ύX�ɔ����A�C���^�[�t�F�[�X������ύX�B
;	�Efocusable �������ƃt�H�[�J�X���̉摜��\�����Ȃ��̂ŁA
;	�@showfocusimage=true/false ��ݒ�ł���悤�ɒǉ��B
;	�EKLayersPlugin�ɓ����������߁AExtSystemButtons�N���X��p�~�B
;	�EExtSystemButton �ŏ��������� name ��ݒ肵�Y��Ă��̂Œǉ��B
; Ver 0.2 2010/11/23
; 	�Efocusable(def=true) ���w��ł���悤�ɂ����B�w�肷���
;	�@�L�[�{�[�h�t�H�[�J�X���g�p�\�ƂȂ�B
;	�Ename �����o�͍ŏ�����Layer�N���X�ɑ��݂��邩���`���폜
; Ver 0.1 2010/11/23
; 	���������[�X

[call storage="KLayers.ks"]

[iscript]

global.extsystembutton_obj = new KLayersPluginOnMessage('extsystembutton');
kag.addPlugin(global.extsystembutton_obj);

// �ȉ��̓V�X�e���{�^���������ꂽ���̓���T���v���֐��B�g���Ă��g��Ȃ��Ă�
// �悵�B�g���ꍇ�́A
// [sysbutton graphic="xxx" exp="SysBtn_onSkipButtonClick()"]
// �̂悤�Ɏg���B

// SKIP�{�^���������ꂽ
function SysBtn_onSkipButtonClick()
{
	if (!kag.nextSkipEnabled)
		return;
	if (typeof kag.skipToNextStopMenuItem != "undefined" &&
	    kag.skipToNextStopMenuItem.enabled)
		kag.onSkipToNextStopMenuItemClick(kag);
	// �ȉ���Menu���폜����ĂĂ������悤��
	else
		kag.skipToStop();
}

// �����ǐi�{�^���������ꂽ
function SysBtn_onAutoReadButtonClick()
{
	if(typeof kag.autoModeMenuItem != "undefined" &&
	   kag.autoModeMenuItem.enabled)
		kag.onAutoModeMenuItemClick(kag);
}

// �����{�^���������ꂽ
function SysBtn_onHistoryButtonClick()
{
	if (!kag.historyEnabled)
		return;
	if (typeof kag.showHistoryMenuItem != "undefined" &&
	    kag.showHistoryMenuItem.enabled)
		kag.onShowHistoryMenuItemClick(kag);
	// �ȉ���Menu���폜����ĂĂ������悤��
	else
		kag.showHistory();
}

// �e�L�X�g�����{�^���������ꂽ
function SysBtn_onTextHideButtonClick()
{
	kag.hideMessageLayerByUser();
}

// �Z�[�u �{�^���������ꂽ�� ks �t�@�C�����Ăяo��
function SysBtn_onSaveButtonClick()
{
	if(kag.canStore())
		kag.callExtraConductor('Krclick.ks', '*krclick_save');
}

// ���[�h �{�^���������ꂽ�� ks �t�@�C�����Ăяo��
function SysBtn_onLoadButtonClick()
{
	if(kag.canRestore())
		kag.callExtraConductor('Krclick.ks', '*krclick_load');
}

// ���j���[ �{�^���������ꂽ�� ks �t�@�C�����Ăяo��
function SysBtn_onMenuButtonClick()
{
	kag.callExtraConductor('Krclick.ks', '*krclick_menu');
}

[endscript]


; �V�X�e���{�^����ǉ�����
[macro name="sysbutton"]
[eval exp="mp.classobj = 'KAnimButtonLayer'" cond="mp.classobj == void"]
; ��������I�u�W�F�N�g�ɕϊ�
[eval exp="mp.classobj = Scripts.eval(mp.classobj)"]
; kag.inStable �ɂ��킹�� enabled ��ݒ�
[eval exp="mp.enabled = kag.inStable" cond="mp.enabled === void"]
[eval exp="global.extsystembutton_obj.add(mp.name, mp.classobj, mp.page, mp)"]
[endmacro]

; �V�X�e���{�^�����폜����
[macro name="sysbutton_erase"]
[eval exp="global.extsystembutton_obj.del(mp.name, mp.page)"]
[endmacro]

; �V�X�e���{�^����ݒ肷��
[macro name="sysbutton_setopt"]
[eval exp="global.extsystembutton_obj.setOptions(mp.name, mp.page, mp)"]
[endmacro]

[return]