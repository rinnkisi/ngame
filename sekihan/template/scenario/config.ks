; _config.ks�c�R���t�B�O���
; �g�����F
;   [call storage="config.ks" target=*config_menu]
; ���ӎ����F
;   �]���T�u���[�`���ł̓�������̞x�R���g�p���Ă���
;   �]���T�u���[�`�����ŁA�E�N���b�N���̐ݒ��ύX���Ă���B�Ăяo�����Ō��̐ݒ�ɖ߂����Ɓi���d�v�j
;   �]�\�߁AConfig.tjs�̈ȉ��̍��ڂ��C�����邱��
;       numCharacterLayers    �c 12�ȏ�i�����j
;       characterMenu.visible �c false�ɕύX
;       displayMenu.visible   �c false�ɕύX
; �g�p���Ă���ϐ��F�ꕔ��config_t.ma���ł��g�p���Ă���
;   tf.conf_scr_x, tf.conf_scr_y         �c �E�B���h�E�^�t���X�N���[���I��p�}�[�J�[�̍��W�i�z��j
;   tf.conf_spd_x, tf.conf_spd_y         �c �����\�����x�p�}�[�J�[�̍��W�i�z��j
;   tf.conf_spdopt_x, tf.conf_spdopt_y   �c ���A�y�[�W���܂ő���}�[�J�[�̍��W�i�z��j
;   tf.conf_spd2_x, tf.conf_spd2_y       �c ���Ǖ����\�����x�p�}�[�J�[�̍��W�i�z��j
;   tf.conf_spd2opt_x, tf.conf_spd2opt_y �c ���A�y�[�W���܂ő���}�[�J�[�̍��W�i�z��j
;   tf.conf_lnwt_x, tf.conf_lnwt_y       �c ���s���̃E�F�C�g�p�}�[�J�[�̍��W�i�z��j
;   tf.conf_pgwt_x, tf.conf_pgwt_y       �c ���y�[�W���̃E�F�C�g�p�}�[�J�[�̍��W�i�z��j
;   tf.conf_bgm_x, tf.conf_bgm_y         �c BGM���ʗp���[�^�[�̍��W�i�z��j
;   tf.conf_se_x, tf.conf_se_y           �c SE���ʗp���[�^�[�̍��W�i�z��j
;   tf.conf_lnwt_offset                  �c �����ǂݐi�݃��[�h�F���s�E�F�C�g�̂P�ڐ��肠����̃E�F�C�g��
;   tf.conf_pgwt_offset                  �c �����ǂݐi�݃��[�h�F���y�[�W�E�F�C�g�̂P�ڐ��肠����̃E�F�C�g��
;   tf.conf_i                            �c ���[�v�J�E���^
;   tf.conf_ch_speed                     �c �I�����������\�����x�i0:�m�[�E�F�C�g�A1:�����A2:���ʁA3:�x���j
;   tf.conf_ch_2nd_speed                 �c �I���������Ǖ����\�����x�i0:�m�[�E�F�C�g�A1:�����A2:���ʁA3:���̂܂܁j
;   tf.conf_line_wait                    �c �I���������s���̃E�F�C�g���x�i0�`10�j
;   tf.conf_page_wait                    �c �I���������y�[�W���̃E�F�C�g���x�i0�`10�j
;   tf.conf_bgm_gvolume                  �c �I������BGM���ʁi0�`10�j
;   tf.conf_se_gvolume                   �c �I������SE���ʁi0�`10�j
;
*config_menu
; �E�B���h�E�^�t���X�N���[���I��p�}�[�J�[�̍��W��z��ŗp��
[eval exp="tf.conf_scr_x = [588, 588]" cond="tf.conf_scr_x === void"]
[eval exp="tf.conf_scr_y = [243, 300]" cond="tf.conf_scr_y === void"]
; BGM���ʗp���[�^�[�̍��W��z��ŗp��
[eval exp="tf.conf_bgm_x = [141, 181, 216, 251, 288, 325, 361, 399, 436, 472, 507]" cond="tf.conf_bgm_x === void"]
[eval exp="tf.conf_bgm_y = [227, 227, 227, 227, 227, 227, 227, 227, 227, 227, 227]" cond="tf.conf_bgm_y === void"]
; SE���ʗp���[�^�[�̍��W��z��ŗp��
[eval exp="tf.conf_se_x = [141, 181, 216, 251, 288, 325, 361, 399, 436, 472, 507]" cond="tf.conf_se_x === void"]
[eval exp="tf.conf_se_y = [291, 291, 291, 291, 291, 291, 291, 291, 291, 291, 291]" cond="tf.conf_se_y === void"]
; �R���t�B�O��ʂŃ}�E�X�E�N���b�N���ꂽ��A�u�߂�v�Ɠ��������������
[rclick call=false jump=false]
; ��������̞x�R�Ɍ��݂̏�Ԃ�ۑ�
[tempsave place=3]
; �S���b�Z�[�W���C���\��ʁA�S�O�i���C���\��ʂ��\���ɂ���
[call storage="subroutine.ks" target=*sub_layernoshow]
; �O�i���C��������Ȃ���Βǉ��i�\��Config.tjs��numCharacterLayers��12�ȏ�ɂ��Ă��������ǂ��j
[laycount layers=12 cond="kag.numCharacterLayers<12"]
; �R���t�B�O��ʁi�N���b�J�u���}�b�v�j��w�i���C���ɕ\��
[image storage="config_back.png" layer=base page=fore]
; �E�B���h�E�^�t���X�N���[����Ԃ̃`�F�b�N�}�[�N��O�i���C���O�ɕ\��
[image storage="window.png" layer=0 page=fore visible=true left="&tf.conf_scr_x[0]" top="&tf.conf_scr_y[0]" cond="!kag.fullScreen"]
[image storage="window.png" layer=0 page=fore visible=true left="&tf.conf_scr_x[1]" top="&tf.conf_scr_y[1]" cond="kag.fullScreen"]
; #2: ���b�Z�[�W�\�����x�p�C���W�P�[�^�摜
[image layer=2 storage="pin.png" page=fore visible=true top=457]
; #3: �I�[�g���[�h���x�p�C���W�P�[�^�摜
[image layer=3 storage="pin.png" page=fore visible=true top=529]
; BGM���ʂ̃}�[�J�[��O�i���C��4�ɕ\��
[image storage="�i�C�t.png" layer=4 page=fore visible=true left="&tf.conf_bgm_x[kag.bgm.currentBuffer.volume2\10000]" top="&tf.conf_bgm_y[kag.bgm.currentBuffer.volume2\10000]"]
; SE���ʂ̃}�[�J�[��O�i���C��5�ɕ\��
[image storage="�i�C�t.png" layer=5 page=fore visible=true left="&tf.conf_se_x[kag.se[0].volume2\10000]" top="&tf.conf_se_y[kag.se[0].volume2\10000]"]
; �v���I��p�̏������{�^����O�i���C��6�ɓǂݍ���
[image storage="configp_restart.png" layer=6 page=fore visible=false]
; �v���I��p�̃^�C�g���{�^����O�i���C��7�ɓǂݍ���
[image storage="configp_title.png" layer=7 page=fore visible=false]
; �v���I��p�̃Q�[���I���{�^����O�i���C��8�ɓǂݍ���
[image storage="configp_exit.png" layer=8 page=fore visible=false]
; �v���I��p�́uBACK�v�{�^����O�i���C��11�ɓǂݍ���
[image storage="loadmode_back_bt.png" layer=11 page=fore visible=false]
; �v���I��p�́uBACK�v�{�^����O�i���C��11�ɓǂݍ���
[image storage="loadmode_back_bt.png" layer=11 page=fore visible=false]
; �v���I��p�̃`�F�b�N�}�[�N��O�i���C���X�ɓǂݍ���
[image storage="windowp.png" layer=9 page=fore visible=false]
; �v���I��p�̃I�v�V�����}�[�N��O�i���C��10�ɓǂݍ���
[image storage="�i�C�t.png" layer=10 page=fore opacity=128 visible=false]
; �v���I��p�́uBACK�v�{�^����O�i���C��11�ɓǂݍ���
[image storage="����1.png" layer=11 page=fore visible=false]
; �e���ڂ̕\�������������܂�
[call target=*update_msgspeed]
[call target=*update_autospeed]
[history output=false enabled=false]
[sysbutton_erase]
; ���[�U�̑����҂��܂�
[s]
; �u�E�B���h�E�v���I�����ꂽ
*config_window
; �}�[�J�[�̕\���ʒu��ύX
[layopt layer=0 page=fore visible=true left="&tf.conf_scr_x[0]" top="&tf.conf_scr_y[0]"]
; �E�B���h�E�\���ɂ���
[eval exp="kag.onWindowedMenuItemClick(kag)"]
[s]
; �u�t���X�N���[���v���I�����ꂽ
;
*config_fullscreen
; �}�[�J�[�̕\���ʒu��ύX
[layopt layer=0 page=fore visible=true left="&tf.conf_scr_x[1]" top="&tf.conf_scr_y[1]"]
; �t���X�N���[���ɂ���
[eval exp="kag.onFullScreenMenuItemClick(kag)"]
[s]
; �u���b�Z�[�W�\�����x�v�̃Q�[�W���N���b�N�������Ɏ��s�����X�N���v�g
*msgspeed
[eval exp="kag.userChSpeed = 100 - (kag.fore.base.cursorX - 224) * 100 \ 489"]
[call target=*update_msgspeed]
[s]
; ���b�Z�[�W�\�����x�̃C���W�P�[�^�̕\�����X�V���܂�
*update_msgspeed
[layopt layer=2 page=fore left="&702 - kag.userChSpeed * 489 \ 100"]
[return]
[s]
; �u�I�[�g���[�h���x�v�̃Q�[�W���N���b�N�������Ɏ��s�����X�N���v�g
*autospeed
[eval exp="kag.autoModePageWait = 4000 - (kag.fore.base.cursorX - 224) * 3900 \ 490"]
[eval exp="kag.autoModeLineWait = 2000 - (kag.fore.base.cursorX - 224) * 1950 \ 490"]
[call target=*update_autospeed]
[s]
; �I�[�g���[�h���x�̃C���W�P�[�^�̕\�����X�V���܂�
*update_autospeed
[layopt layer=3 page=fore left="&213 + (4000 - kag.autoModePageWait) * 490 \ 3900"]
[return]
[s]
; BGM���ʃ��[�^�[���N���b�N���ꂽ
*config_bgm_gvolume
; �}�[�J�[�̕\���ʒu��ύX
[layopt layer=4 page=fore visible=true left="&tf.conf_bgm_x[tf.conf_bgm_gvolume\10]" top="&tf.conf_bgm_y[tf.conf_bgm_gvolume\10]"]
; BGM�̑�批�ʂ�ύX
[bgmopt gvolume="&tf.conf_bgm_gvolume"]
[s]
; ���ʉ����ʃ��[�^�[���N���b�N���ꂽ
;
*config_se_gvolume
; �}�[�J�[�̕\���ʒu��ύX
[layopt layer=5 page=fore visible=true left="&tf.conf_se_x[tf.conf_se_gvolume\10]" top="&tf.conf_se_y[tf.conf_se_gvolume\10]"]
; �S���ʉ��̑�批�ʂ�ύX
[eval exp="tf.conf_i=0"]
*config_se_gvolume_loop
	[seopt buf="&tf.conf_i" gvolume="&tf.conf_se_gvolume"]
	[jump target=*config_se_gvolume_loop cond="++tf.conf_i<kag.numSEBuffers"]
[s]
;�^�C�g���ɖ߂邪�I�����ꂽ
;
*config_title
;[jump storage="title.ks"target="gotostart"]
[gotostart]
[s]
;
;�Q�[�����I�����邪�I�����ꂽ
;
*config_exit
[eval exp="kag.closeByScript(%['ask'=>'true'])"]
[s]
;
;�ݒ�̏������������ꂽ
*config_restart
[layopt layer=0 page=fore visible=true left="&tf.conf_scr_x[0]" top="&tf.conf_scr_y[0]"]
; �E�B���h�E�\���ɂ���
[eval exp="kag.onWindowedMenuItemClick(kag)"]
[eval exp="kag.userChSpeed = 100 - (468 - 224) * 100 \ 489"]
[layopt layer=2 page=fore left="&702 - kag.userChSpeed * 489 \ 100"]
[eval exp="kag.autoModePageWait = 4000 - (468 - 224) * 3900 \ 490"]
[eval exp="kag.autoModeLineWait = 2000 - (468 - 224) * 1950 \ 490"]
[layopt layer=3 page=fore left="&213 + (4000 - kag.autoModePageWait) * 490 \ 3900"]
;BGM
; �}�[�J�[�̕\���ʒu��ύX
[layopt layer=4 page=fore visible=true left="&tf.conf_bgm_x[5]" top="&tf.conf_bgm_y[5]"]
; BGM�̑�批�ʂ�ύX
[bgmopt gvolume="&50"]
; ���ʉ����ʃ��[�^�[���N���b�N���ꂽ
; �}�[�J�[�̕\���ʒu��ύX
[layopt layer=5 page=fore visible=true left="&tf.conf_se_x[5]" top="&tf.conf_se_y[5]"]
; �S���ʉ��̑�批�ʂ�ύX
	[seopt buf="&0" gvolume="&50"]
[s]
; �u�߂�v���I�����ꂽ�^�}�E�X�E�N���b�N���ꂽ
;
*config_return
; ��������̞x�R��ǂݍ��݁A��ԕ��A
[tempload place=3]
[rclick call=false jump=false]
; ���b�Z�[�W�����̏o�́E�\����L���ɂ��܂�
[history output=true enabled=true]
; ���b�Z�[�W�\�����x�̐ݒ�𔽉f���܂�
[delay speed=user cond="kag.chUserMode"]
; �߂�i���Ăяo�����Ń}�E�X�E�N���b�N�̐ݒ�����ɖ߂����Ɓj
[return]