; load.ks�c���[�h���
; �g�����F
;   [call storage="rclick_load.ks" target=*load_menu]
; ���ӎ����F
;   �]���T�u���[�`���ł̓�������̞x�P���g�p���Ă���
;   �]���T�u���[�`�����ŁA�E�N���b�N���̐ݒ��ύX���Ă���B�Ăяo�����Ō��̐ݒ�ɖ߂����Ɓi���d�v�j
;   �]�\�߁AConfig.tjs�̈ȉ��̍��ڂ��C�����邱��
;       numCharacterLayers  �c 4�ȏ�i�����j
;       restoreMenu.visible �c false�ɕύX
; �g�p���Ă���ϐ��F�ꕔ��load_bg_normal.ma���ł��g�p���Ă���
;   sf.load_now_page               �c ���݁A�\�����̃y�[�W�i0�`9�j
;   tf.load_message                �c ���[�h��ʂ���郁�b�Z�[�W���C����
;   tf.load_i                      �c ���[�v�J�E���^
;   tf.load_x, tf.load_y           �c �T���l�C���摜��`�悷����W�i�z��j
;   tf.load_column                 �c �T���l�C���摜��`�悷���
;   tf.load_line                   �c �T���l�C���摜��`�悷��s
;   tf.load_page_x, tf.load_page_y �c �y�[�W�ԍ��摜��`�悷����W�i�z��j
;   tf.load_ent_button             �c �}�E�X��������Ƃ��ɕ`�悷��y�[�W�ԍ��摜�t�@�C�����i�z��j
;   tf.load_now_button             �c ���݁A�\�����ł��邱�Ƃ������y�[�W�ԍ��摜�t�@�C�����i�z��j
;   tf.load_index                  �c �N���b�N���ꂽ�T���l�C���摜�̔ԍ�
;
*load_menu
; ��������̞x�P�Ɍ��݂̏�Ԃ�ۑ�
[tempsave place=1]
[sysbutton_erase]
[history output=false enabled=false]
; ���[�h��ʂŃ}�E�X�E�N���b�N���ꂽ��A�u�߂�v�Ɠ��������������
[rclick call=false jump=false]
; ���[�h��ʂ�\�����郁�b�Z�[�W���C����
[eval exp="tf.load_message = 'message1'"]
; �T���l�C���摜��`�悷����W���Z�o���A�z��Ɋi�[���Ă���
[eval exp="tf.load_x = []" cond="tf.load_x === void"]
[eval exp="tf.load_y = []" cond="tf.load_y === void"]
[eval exp="tf.load_i=0"]
*load_menu_loop0
	; �T���l�C���摜��`�悷�����v�Z
	[eval exp="tf.load_column = tf.load_i % 5"]
	; �T���l�C���摜��`�悷��s���v�Z
	[eval exp="tf.load_line   = tf.load_i \ 5"]
	; �T���l�C���摜��`�悷����W���v�Z���A�z��Ɋi�[
	[eval exp="tf.load_x[tf.load_i] = 11 + 157*tf.load_column"]
	[eval exp="tf.load_y[tf.load_i] = 131 + 145*tf.load_line"]
	[jump target=*load_menu_loop0 cond="++tf.load_i<10"]

; �y�[�W�p�{�^����\��������W�̔z��
[eval exp="tf.load_page_x = [205, 289, 372, 453, 532, 207, 289, 372, 453, 533]" cond="tf.load_page_x === void"]
[eval exp="tf.load_page_y = [  5,   5,   5,   5,   5,   69,   69,   69,   69,   69]" cond="tf.load_page_y === void"]
; �}�E�X��������Ƃ��ɕ`�悷��y�[�W�ԍ��摜�t�@�C�����̔z��
[eval exp="tf.load_ent_button = ['mode01.png', 'mode02.png', 'mode03.png', 'mode04.png', 'mode05.png', 'mode06.png', 'mode07.png', 'mode08.png', 'mode09.png', 'mode10.png']" cond="tf.load_ent_button === void"]
; ���݁A�\�����ł��邱�Ƃ������y�[�W�ԍ��摜�t�@�C�����̔z��
[eval exp="tf.load_now_button = ['modenow01.png', 'modenow02.png', 'modenow03.png', 'modenow04.png', 'modenow05.png', 'modenow06.png', 'modenow07.png', 'modenow08.png', 'modenow09.png', 'modenow10.png']" cond="tf.load_now_button === void"]
; ���݁A�\�����̃y�[�W�i���߂ă��[�h��ʂ��Ăяo���ꂽ��O��������j
[eval exp="sf.load_now_page = 0" cond="sf.load_now_page === void"]

; �S���b�Z�[�W���C���\��ʁA�S�O�i���C���\��ʂ��\���ɂ���
[call storage="subroutine.ks" target=*sub_layernoshow]
; �O�i���C��������Ȃ���Βǉ��i�\��Config.tjs��numCharacterLayers��4�ȏ�ɂ��Ă��������ǂ��j
[laycount layers=4 cond="kag.numCharacterLayers<4"]
; �J�����g�̃��b�Z�[�W���C����ύX
[current layer="&tf.load_message" page=fore]
; ���b�Z�[�W���C���̑�����ݒ�G�Z�[�u�f�[�^�̓��t�ƌ��o����`�悷��
[position layer="&tf.load_message" page=fore left=15 top=490 width=500 height=100 frame="" color=0x000000 opacity=0 marginl=5 margint=-3 marginr=0 marginb=0 vertical=false draggable=false visible=true]
; ���b�Z�[�W���C���̃N���A
[er]
; �t�H���g��ύX
[font size=26 face="�l�r �S�V�b�N" color=0xFFFFFF italic=false rubysize=10 rubyoffset=0 shadow=false edge=false edgecolor=0x000000 shadowcolor=0x000000 bold=false]

; �N���b�J�u���}�b�v���N���b�N���ꂽ��A�T���l�C���摜�̕ύX�����f�����悤*load_redraw�ɖ߂��čĕ`�悷��
*load_redraw
; �w�i���C���\��ʂɃZ�[�u�f�[�^�ꗗ�p�摜��ǂݍ��݁A�\���i�N���b�J�u���}�b�v���@�\����j
[image storage="load_bg_normal.png" layer=base page=fore]
; ���݂̃y�[�W�{�^����O�i���C���O�ɓǂݍ���
[image storage="&tf.load_now_button[sf.load_now_page]" layer=0 page=fore visible=true left="&tf.load_page_x[sf.load_now_page]" top="&tf.load_page_y[sf.load_now_page]"]
; �v���I��p�̃T���l�C���摜��O�i���C���P�ɓǂݍ���
[image storage="thumbnail_preview_mouseover.png" layer=1 page=fore visible=false]
; �v���I��p�́u����v�{�^����O�i���C���Q�ɓǂݍ���
[image storage="loadmode_back_bt.png" layer=2 page=fore visible=false]
; �Z�[�u�f�[�^�̐��Ԃ�J��Ԃ�
[eval exp="tf.load_i=0"]
*load_menu_loop1
	; �Z�[�u�f�[�^�����݂���Ȃ�c
	[if exp="kag.getBookMarkDate(sf.load_now_page*10+tf.load_i) != ''"]
		; �T���l�C���摜��w�i���C���\��ʂɒǉ��ǂݍ���
		[pimage storage="&kag.getBookMarkFileNameAtNum(sf.load_now_page*10+tf.load_i)" layer=base page=fore dx="&tf.load_x[tf.load_i]" dy="&tf.load_y[tf.load_i]" sw="&kag.thumbnailWidth" sh="&kag.thumbnailWidth*kag.scHeight\kag.scWidth"]
	[endif]
	[jump target=*load_menu_loop1 cond="++tf.load_i<10"]
[s]
;
; �T���l�C���摜���N���b�N���ꂽ
;
*load_click
; �x�����ǂ�
[load place="&sf.load_now_page*10+tf.load_index" ask=true]
[s]
; �y�[�W�ԍ����N���b�N���ꂽ
*load_click_page
; ���݂̃y�[�W�{�^����O�i���C���O�ɓǂݍ���
[image storage="&tf.load_now_button[sf.load_now_page]" layer=0 page=fore visible=true left="&tf.load_page_x[sf.load_now_page]" top="&tf.load_page_y[sf.load_now_page]"]
[jump target=*load_redraw]
;
; �u�߂�v���I�����ꂽ
*load_return
; ���b�Z�[�W�����̏o�́E�\����L���ɂ��܂�
[history output=true enabled=true]
; ��������̞x�P��ǂݍ��݁A��ԕ��A
[tempload place=1]

; �߂�i���Ăяo�����Ń}�E�X�E�N���b�N�̐ݒ�����ɖ߂����Ɓj
[return]
