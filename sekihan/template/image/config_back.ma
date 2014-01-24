0: autodisable=false;

1: hint="戻る"; target="*config_return"; onenter="marker_on(11,496,30)"; onleave="marker_off(11)";
2: hint="ウィンドウ";     target="*config_window";     onenter="marker_on(9,tf.conf_scr_x[0],tf.conf_scr_y[0])"; onleave="marker_off(9)";
3: hint="フルスクリーン"; target="*config_fullscreen"; onenter="marker_on(9,tf.conf_scr_x[1],tf.conf_scr_y[1])"; onleave="marker_off(9)";
; 「メッセージ表示速度」のゲージをクリックした時は rclick.ks の *msgspeed にジャンプします
4: hint="メッセージ速度";  storage = "config.ks"; target = "*msgspeed";
; 「オートモード速度」のゲージをクリックした時は rclick.ks の *autospeed にジャンプします
5: hint="オートモード速度"; storage = "config.ks"; target = "*autospeed";

16: hint="0";   target="*config_bgm_gvolume"; onenter="marker_on(10,tf.conf_bgm_x[0],tf.conf_bgm_y[0])";   onleave="marker_off(10)"; exp="tf.conf_bgm_gvolume=0";
17: hint="10";  target="*config_bgm_gvolume"; onenter="marker_on(10,tf.conf_bgm_x[1],tf.conf_bgm_y[1])";   onleave="marker_off(10)"; exp="tf.conf_bgm_gvolume=10";
18: hint="20";  target="*config_bgm_gvolume"; onenter="marker_on(10,tf.conf_bgm_x[2],tf.conf_bgm_y[2])";   onleave="marker_off(10)"; exp="tf.conf_bgm_gvolume=20";
19: hint="30";  target="*config_bgm_gvolume"; onenter="marker_on(10,tf.conf_bgm_x[3],tf.conf_bgm_y[3])";   onleave="marker_off(10)"; exp="tf.conf_bgm_gvolume=30";
20: hint="40";  target="*config_bgm_gvolume"; onenter="marker_on(10,tf.conf_bgm_x[4],tf.conf_bgm_y[4])";   onleave="marker_off(10)"; exp="tf.conf_bgm_gvolume=40";
21: hint="50";  target="*config_bgm_gvolume"; onenter="marker_on(10,tf.conf_bgm_x[5],tf.conf_bgm_y[5])";   onleave="marker_off(10)"; exp="tf.conf_bgm_gvolume=50";
22: hint="60";  target="*config_bgm_gvolume"; onenter="marker_on(10,tf.conf_bgm_x[6],tf.conf_bgm_y[6])";   onleave="marker_off(10)"; exp="tf.conf_bgm_gvolume=60";
23: hint="70";  target="*config_bgm_gvolume"; onenter="marker_on(10,tf.conf_bgm_x[7],tf.conf_bgm_y[7])";   onleave="marker_off(10)"; exp="tf.conf_bgm_gvolume=70";
24: hint="80";  target="*config_bgm_gvolume"; onenter="marker_on(10,tf.conf_bgm_x[8],tf.conf_bgm_y[8])";   onleave="marker_off(10)"; exp="tf.conf_bgm_gvolume=80";
25: hint="90";  target="*config_bgm_gvolume"; onenter="marker_on(10,tf.conf_bgm_x[9],tf.conf_bgm_y[9])";   onleave="marker_off(10)"; exp="tf.conf_bgm_gvolume=90";
26: hint="100"; target="*config_bgm_gvolume"; onenter="marker_on(10,tf.conf_bgm_x[10],tf.conf_bgm_y[10])"; onleave="marker_off(10)"; exp="tf.conf_bgm_gvolume=100";

32: hint="0";   target="*config_se_gvolume"; onenter="marker_on(10,tf.conf_se_x[0],tf.conf_se_y[0])";   onleave="marker_off(10)"; exp="tf.conf_se_gvolume=0";
33: hint="10";  target="*config_se_gvolume"; onenter="marker_on(10,tf.conf_se_x[1],tf.conf_se_y[1])";   onleave="marker_off(10)"; exp="tf.conf_se_gvolume=10";
34: hint="20";  target="*config_se_gvolume"; onenter="marker_on(10,tf.conf_se_x[2],tf.conf_se_y[2])";   onleave="marker_off(10)"; exp="tf.conf_se_gvolume=20";
35: hint="30";  target="*config_se_gvolume"; onenter="marker_on(10,tf.conf_se_x[3],tf.conf_se_y[3])";   onleave="marker_off(10)"; exp="tf.conf_se_gvolume=30";
36: hint="40";  target="*config_se_gvolume"; onenter="marker_on(10,tf.conf_se_x[4],tf.conf_se_y[4])";   onleave="marker_off(10)"; exp="tf.conf_se_gvolume=40";
37: hint="50";  target="*config_se_gvolume"; onenter="marker_on(10,tf.conf_se_x[5],tf.conf_se_y[5])";   onleave="marker_off(10)"; exp="tf.conf_se_gvolume=50";
38: hint="60";  target="*config_se_gvolume"; onenter="marker_on(10,tf.conf_se_x[6],tf.conf_se_y[6])";   onleave="marker_off(10)"; exp="tf.conf_se_gvolume=60";
39: hint="70";  target="*config_se_gvolume"; onenter="marker_on(10,tf.conf_se_x[7],tf.conf_se_y[7])";   onleave="marker_off(10)"; exp="tf.conf_se_gvolume=70";
40: hint="80";  target="*config_se_gvolume"; onenter="marker_on(10,tf.conf_se_x[8],tf.conf_se_y[8])";   onleave="marker_off(10)"; exp="tf.conf_se_gvolume=80";
41: hint="90";  target="*config_se_gvolume"; onenter="marker_on(10,tf.conf_se_x[9],tf.conf_se_y[9])";   onleave="marker_off(10)"; exp="tf.conf_se_gvolume=90";
42: hint="100"; target="*config_se_gvolume"; onenter="marker_on(10,tf.conf_se_x[10],tf.conf_se_y[10])"; onleave="marker_off(10)"; exp="tf.conf_se_gvolume=100";

48: hint="設定初期化"; target="*config_restart"; onenter="marker_on(6,357,372)"; onleave="marker_off(6)";
49: hint="タイトルに戻る"; target="*config_title"; onenter="marker_on(7,471,372)"; onleave="marker_off(7)";
50: hint="ゲームを終了する"; target="*config_exit"; onenter="marker_on(8,621,372)"; onleave="marker_off(8)";
