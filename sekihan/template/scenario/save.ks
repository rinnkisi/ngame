; save.ks�c�Z�[�u���
; �g�����F
;   [call storage="rclick_save.ks" target=*save_menu]
; ���ӎ����F

;   �]���T�u���[�`���ł̓�������̞x�Q���g�p���Ă���
;   �]�\�߁AConfig.tjs�̈ȉ��̍��ڂ��C�����邱��
;       numCharacterLayers  �c 4�ȏ�i�����j
;       storeMenu.visible �c false�ɕύX
; �g�p���Ă���ϐ��F�ꕔ��savemode_bg_normal.ma���ł��g�p���Ă���
;   sf.save_now_page               �c ���݁A�\�����̃y�[�W�i0�`9�j
;   tf.save_message              �c �Z�[�u��ʂ���郁�b�Z�[�W���C����
;   tf.save_i                      �c ���[�v�J�E���^
;   tf.save_x, tf.save_y           �c �T���l�C���摜��`�悷����W�i�z��j
;   tf.save_column                 �c �T���l�C���摜��`�悷���
;   tf.save_line                   �c �T���l�C���摜��`�悷��s
;   tf.save_page_x, tf.save_page_y �c �y�[�W�ԍ��摜��`�悷����W�i�z��j
;   tf.save_ent_button             �c �}�E�X��������Ƃ��ɕ`�悷��y�[�W�ԍ��摜�t�@�C�����i�z��j
;   tf.save_now_button             �c ���݁A�\�����ł��邱�Ƃ������y�[�W�ԍ��摜�t�@�C�����i�z��j
;   tf.save_index                  �c �N���b�N���ꂽ�T���l�C���摜�̔ԍ�
;
*save_menu
; ��������̞x�Q�Ɍ��݂̏�Ԃ�ۑ�
[tempsave place=2]
[locksnapshot]
[sysbutton_erase]
[history output=false enabled=false]
; �Z�[�u��ʂŃ}�E�X�E�N���b�N���ꂽ��A�u�߂�v�Ɠ��������������
;[rclick call=false jump=false]

; ���[�h��ʂ�\�����郁�b�Z�[�W���C����
[eval exp="tf.save_message = 'message1'"]
; �T���l�C���摜��`�悷����W���Z�o���A�z��Ɋi�[���Ă���
[eval exp="tf.save_x = []" cond="tf.save_x === void"]
[eval exp="tf.save_y = []" cond="tf.save_y === void"]
[eval exp="tf.save_i=0"]
*save_menu_loop0
	; �T���l�C���摜��`�悷�����v�Z
	[eval exp="tf.save_column = tf.save_i % 5"]
	; �T���l�C���摜��`�悷��s���v�Z
	[eval exp="tf.save_line   = tf.save_i \ 5"]
	; �T���l�C���摜��`�悷����W���v�Z���A�z��Ɋi�[
	[eval exp="tf.save_x[tf.save_i] = 10 + 157*tf.save_column"]
	[eval exp="tf.save_y[tf.save_i] = 132 + 145*tf.save_line"]
	[jump target=*save_menu_loop0 cond="++tf.save_i<10"]

; �y�[�W�p�{�^����\��������W�̔z��
[eval exp="tf.save_page_x = [205, 289, 372, 453, 532, 207, 289, 372, 453, 533]" cond="tf.save_page_x === void"]
[eval exp="tf.save_page_y = [  5,   5,   5,   5,   5,   69,   69,   69,   69,   69]" cond="tf.save_page_y === void"]
; �}�E�X��������Ƃ��ɕ`�悷��y�[�W�ԍ��摜�t�@�C�����̔z��
[eval exp="tf.save_ent_button = ['mode01.png', 'mode02.png', 'mode03.png', 'mode04.png', 'mode05.png', 'mode06.png', 'mode07.png', 'mode08.png', 'mode09.png', 'mode10.png']" cond="tf.save_ent_button === void"]
; ���݁A�\�����ł��邱�Ƃ������y�[�W�ԍ��摜�t�@�C�����̔z��
[eval exp="tf.save_now_button = ['modenow01.png', 'modenow02.png', 'modenow03.png', 'modenow04.png', 'modenow05.png', 'modenow06.png', 'modenow07.png', 'modenow08.png', 'modenow09.png', 'modenow10.png']" cond="tf.save_now_button === void"]
; ���݁A�\�����̃y�[�W�i���߂ăZ�[�u��ʂ��Ăяo���ꂽ��O��������j
[eval exp="sf.save_now_page = 0" cond="sf.save_now_page === void"]

; �S���b�Z�[�W���C���\��ʁA�S�O�i���C���\��ʂ��\���ɂ���
[call storage="subroutine.ks" target=*sub_layernoshow]
; �O�i���C��������Ȃ���Βǉ��i�\��Config.tjs��numCharacterLayers��4�ȏ�ɂ��Ă��������ǂ��j
[laycount layers=4 cond="kag.numCharacterLayers<4"]
; �J�����g�̃��b�Z�[�W���C����ύX
[current layer="&tf.save_message" page=fore]
; ���b�Z�[�W���C���̑�����ݒ�G�Z�[�u�f�[�^�̓��t�ƌ��o����`�悷��
[position layer="&tf.save_message" page=fore left=15 top=490 width=500 height=100 frame="" color=0x000000 opacity=0 marginl=5 margint=-3 marginr=0 marginb=0 vertical=false draggable=false visible=true]
; ���b�Z�[�W���C���̃N���A
[er]
; �t�H���g��ύX
[font size=26 face="�l�r �S�V�b�N" color=0xFFFFFF italic=false rubysize=10 rubyoffset=0 shadow=false edge=false edgecolor=0x000000 shadowcolor=0x000000 bold=false]

; �N���b�J�u���}�b�v���N���b�N���ꂽ��A�T���l�C���摜�̕ύX�����f�����悤*save_redraw�ɖ߂��čĕ`�悷��
*save_redraw
; �w�i���C���\��ʂɃZ�[�u�f�[�^�ꗗ�p�摜��ǂݍ��݁A�\���i�N���b�J�u���}�b�v���@�\����j
[image storage="save_bg_normal.png" layer=base page=fore]
; ���݂̃y�[�W�{�^����O�i���C���O�ɓǂݍ���
[image storage="&tf.save_now_button[sf.save_now_page]" layer=0 page=fore visible=true left="&tf.save_page_x[sf.save_now_page]" top="&tf.save_page_y[sf.save_now_page]"]
; �v���I��p�̃T���l�C���摜��O�i���C���P�ɓǂݍ���
[image storage="thumbnail_preview_mouseover.png" layer=1 page=fore visible=false]
; �v���I��p�́u����v�{�^����O�i���C���Q�ɓǂݍ���
[image storage="savemode_back_bt.png" layer=2 page=fore visible=false]
; �Z�[�u�f�[�^�̐��Ԃ�J��Ԃ�
[eval exp="tf.save_i=0"]
*save_menu_loop1
	; �Z�[�u�f�[�^�����݂���Ȃ�c
	[if exp="kag.getBookMarkDate(sf.save_now_page*10+tf.save_i) != ''"]
		; �T���l�C���摜��w�i���C���\��ʂɒǉ��ǂݍ���
		[pimage storage="&kag.getBookMarkFileNameAtNum(sf.save_now_page*10+tf.save_i)" layer=base page=fore dx="&tf.save_x[tf.save_i]" dy="&tf.save_y[tf.save_i]" sw="&kag.thumbnailWidth" sh="&kag.thumbnailWidth*kag.scHeight\kag.scWidth"]
	[endif]
	[jump target=*save_menu_loop1 cond="++tf.save_i<10"]
[s]
;
; �T���l�C���摜���N���b�N���ꂽ
;
*save_click
; �x�ɋ���
[save place="&sf.save_now_page*10+tf.save_index" ask=true]
[jump target=*save_redraw]
;
; �y�[�W�ԍ����N���b�N���ꂽ
;
*save_click_page
; ���݂̃y�[�W�{�^����O�i���C���O�ɓǂݍ���
[image storage="&tf.save_now_button[sf.save_now_page]" layer=0 page=fore visible=true left="&tf.save_page_x[sf.save_now_page]" top="&tf.save_page_y[sf.save_now_page]"]
[jump target=*save_redraw]
;
; �u�߂�v���I�����ꂽ
*save_return
; ���b�Z�[�W�����̏o�́E�\����L���ɂ��܂�
[history output=true enabled=true]
; ��������̞x�Q��ǂݍ��݁A��ԕ��A
[tempload place=2]
[history output=true enabled=true]
; �X�i�b�v�V���b�g���A�����b�N���܂�
[unlocksnapshot]
; �߂�
[return]
