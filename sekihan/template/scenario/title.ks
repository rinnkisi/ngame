; title.ks�c�^�C�g�����j���[���
;
; �g����
;   [jump storage="title.ks"]
;
; ���ӎ����F
;   �]first.ks����W�����v���Ă��邱��
;   �]���x��title_menu�́A�g���g��/KAG�N�����A�ŏ��ɒʉ߂���u�Z�[�u�\�ȃ��x���v�ł��邱�Ɓigotostart�^�O�Łu�ŏ��ɖ߂�v�̂Ɏg���j
;   �]���[�h��ʁA�R���t�B�O��ʂ́u�E�N���b�N�T�u���[�`������낤�v��load.ks,config.ks��p���遦�������E�N���b�N�����͍���͕ς��Ă���
;
; �g�p���Ă���ϐ��F
;   tf.title_message �c �O���t�B�J���{�^����\�����郁�b�Z�[�W���C�����i�E�N���b�N�T�u���[�`���p���b�Z�[�W���C���Ɠ����ł��ǂ��j
;
*title_menu|�^�C�g�����j���[
; �u�ŏ��ɖ߂�v��L���ɂ��遫
[startanchor]
;�����ŃV�X�e���{�^�����\���ɂ���
[sysbutton_setopt visible =false]
; �V�[����z���Ɂu�V�X�e���]�ŏ��ɖ߂�v���j���[���I�����ꂽ�ꍇ�̒��덇�킹���s��
;[call storage="scene.ks" target=*scene_reset] ��U�R�����g�A�E�g�@12��17��
; �S���b�Z�[�W���C���\��ʁA�S�O�i���C���\��ʂ��\���ɂ���
[call storage="subroutine.ks" target=*sub_layernoshow]
; �^�C�g����ʂŃO���t�B�J���{�^����\�����郁�b�Z�[�W���C����
[eval exp="tf.title_message = 'message1'"]
; ���b�Z�[�W�����ւ̏o�͂��~���A�\���s�ɂ���
[history output=false enabled=false]
; �x�ɂ͂��߂Ȃ�����i���̃Z�[�u�\�ȃ��x��title_menu�́u�ŏ��ɖ߂�v���߂ɂ̂ݎg�p����j
[disablestore store=true restore=false]
; �E�N���b�N�𖳌��ɂ���
[rclick enabled=false]
; �^�C�g�����j���[��ʂ�w�i���C���\��ʂɓǂݍ���
[image storage="title_bg.jpg" layer=base page=fore]
; �^�C�g�����j���[��ʗp���b�Z�[�W���C���̊e��ݒ�
[position layer="&tf.title_message" page=fore left=0 top=0 width="&kag.scWidth" height="&kag.scHeight" frame="" color=0x000000 opacity=0 marginl=0 margint=0 marginr=0 marginb=0 draggable=false visible=true]
[layopt layer="&tf.title_message" page=fore visible=true]
[current layer="&tf.title_message" page=fore]
; �m�[�E�F�C�g
[delay speed=nowait]

; ���e���j���[����߂��Ă��郉�x��
*title_menu_loop
; ���b�Z�[�W���C�����N���A
[er]
; �O���t�B�J���{�^���uSTART�v�`�uEXIT�v��z�u
[locate x=100 y=235]
[button graphic="title_bt_start.png" target=*title_menu_start hint="�Q�[���J�n"]
[locate x=180 y=310]
[button graphic="title_bt_load.png" target=*title_menu_load hint="�r������ĊJ"]
[locate x=260 y=385]
[button graphic="title_bt_config.png" target=*title_menu_config hint="�ݒ�"]
[locate x=340 y=460]
[button graphic="title_bt_exit.png" target=*title_exit hint="�I��"]
[s]
;
; �u�r������ĊJ�v���I�����ꂽ

*title_menu_load
 �����[�h��ʂ��Ăяo��
[call storage="load.ks" target=*load_menu]
 �}�E�X�E�N���b�N���ꂽ�Ƃ��̓�������ɖ߂��iload.ks���Ń}�E�X�E�N���b�N�̐ݒ肪�ς���Ă��邽�߁j
;[rclick enable]
[rclick call=false jump=false]
[jump target=*title_menu_loop]
 �u�ݒ�v���I�����ꂽ
*title_menu_config
; ���R���t�B�O��ʂ��Ăяo��
[call storage="config.ks" target=*config_menu]
; �}�E�X�E�N���b�N���ꂽ�Ƃ��̓�������ɖ߂��iconfig.ks���Ń}�E�X�E�N���b�N�̐ݒ肪�ς���Ă��邽�߁j

[rclick call=false jump=false]
[jump target=*title_menu_loop]
;
[s]
;�Q�[�����I�����邪�I�����ꂽ
;
*title_exit
[eval exp="kag.closeByScript(%['ask'=>'true'])"]
[jump target=*title_menu_loop]
[s]



; �u�Q�[���J�n�v���I�����ꂽ�G�ݒ�𕜋A����
;
*title_menu_start
; �E�F�C�g����
[delay speed=user]
; �^�C�g�����j���[��ʗp���b�Z�[�W���C�����\��
[layopt layer="&tf.title_message" page=fore visible=false]
; �x�ɂ͂��߂�悤�ɂ���
[disablestore store=false restore=false]
; ���b�Z�[�W�����ւ̏o�͂��ĊJ�A�\���ɂ���
[history output=true enabled=true]
; �E�N���b�N�T�u���[�`���̐ݒ��ύX
[rclick call=false jump=false]


; ���ۂ̃V�i���I�P�ցc
;
[jump storage="chapter_1.ks"]
