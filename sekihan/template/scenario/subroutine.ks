;
; subroutine.ks�c�T�u���[�`���W
;
;
; �S���b�Z�[�W���C���\��ʁA�S�O�i���C���\��ʂ��\���ɂ���
;
; �g�����F
;   [call storage="subroutine.ks" target=*sub_layernoshow]
;
; ���ӎ����F
;   �]�O�i���C���̓����x�͊��S�s�����i255�j�ɕύX����
;
; �g�p���Ă���ϐ��F
;   tf.sub_i �c ���[�v�J�E���^
;
*sub_layernoshow
; �S���b�Z�[�W���C���\��ʂ��\��
[eval exp="tf.sub_i = 0"]
*sub_layernoshow_loop0
	[layopt layer="&'message'+tf.sub_i" page=fore visible=false]
	[jump target=*sub_layernoshow_loop0 cond="++tf.sub_i < kag.numMessageLayers"]
; �S�O�i���C���\��ʂ��\��
[eval exp="tf.sub_i = 0"]
*sub_layernoshow_loop1
	[layopt layer="&tf.sub_i" page=fore visible=false opacity=255]
	[jump target=*sub_layernoshow_loop1 cond="++tf.sub_i < kag.numCharacterLayers"]
[return]
