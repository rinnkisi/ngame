[macro name=lrcm]
[l][r][cm]
[endmacro]
; fadeoutmessage�}�N�����b�Z�[�W�̃t�F�[�h�A�E�g
; KAG�V�i���I�t�@�C������[fadeoutmessage]�Ə����΁A
; [backlay][layopt layer=message �c�c][trans time=1000 �c�c][wt]�Ə������̂Ɠ���
;�V�X�e���{�^���̔�\��
[macro name=fadeoutmessage]
	[sysbutton_setopt visible =false]
	[backlay]
	[layopt layer=message page=back visible=false top=432 width=780 height=154]
	[trans time=1000 method=crossfade]
	[wt]
[endmacro]

; fadeinmessage�}�N�����b�Z�[�W�̃t�F�[�h�C��
;�V�X�e���{�^���̕\��
[macro name=fadeinmessage]
	[ct]
	[layopt layer=message page=back visible=true top=432 width=780 height=154]
	[trans time=1000 method=crossfade]
	[wt]
	[sysbutton_setopt visible =true]
[endmacro]

; transcombo�}�N��
;
[macro name=transcombo]
	[image storage=%storage layer=base page=back]
	[trans *]
	[wt]
[endmacro]

[return]