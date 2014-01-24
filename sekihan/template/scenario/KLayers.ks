;プラグイン
[return cond="typeof(global.KLayersLoaded) != 'undefined'"]

; ToDo:
;	・最初に実行するスクリプト・、最後に実行するスクリプトを追加する
;	・トランジション中は mousedown/keydown できないようにする
;	・restore(dic)の時、dicにvoidメンバがあったらスキップされないか？
;	・setOptions_クラス名()はsetLocalMembers()に変更した方がいいか？しかし
;	　そうすると再起呼び出しになって遅くならないか？
;	・ボタン上で右クリックしたら右クリックルーチンが上がるかどうか
; KCheckBoxLayerまで copyLocalMembers()/copyAllMembers()を実装
;	・アニメーションボタン：push後状態をロックする、animが終わるまで待つ
;	・アニメーションのセーブ・ロードでアニメが復活できるか？
; クリックは、onMouseDown()じゃなくてonMouseUpで引っ掛けたほうがいいのか？
; 領域外でマウス放したときに無効にすることができるから。
;
; 2013/12/07	0.99g	・Layer_copyLocalMembers()のtypo再修正…
; 2013/12/05	0.99f	・Layer_copyLocalMembers()で、setImagePos()の指定が
;			　悪く、「レイヤ領域に画像のない領域が発生しました」
;			　エラーとなっていたのを修正
; 2013/11/25	0.99e	・ボタンフォントを、kfontを指定するとコレに合わせるよう
;			　修正。同じように、ボタン色のcolor指定を優先
;			・KFontのcopyLocalMembers()でsrc→sに修正
;			・setOptions()したら無条件にredraw()するよう変更
;			・KRadioButtonLayer()でnameを指定してなかったので修正
;			・KRadioButtonLayerのcopyLocalMembers()でd.が指定されて
;			　いないものがあったのを修正
; 2013/11/18	0.99d	・SliderLayerのonSliderDragged()の引数が間違ってたので
;			　修正
;			・SliderLayerにhval/vvalのmin/maxとintflgを追加
;			・SliderLayerのupdateSliderTabPos()で、hval/vvalに同じ
;			　値が設定されたときは、更新をスキップするよう修正
;			・KRadioButtonLayerのsetOptions_button()の引数を修正
; 2013/09/08	0.99c	・Layer_copyLocalMembers() で imageLeft+imageWidth < 0
;			　などの場合にエラー終了していたのを修正
; 2013/08/10	0.99β	・copyLocalMembers()を単純なものに差し替え。
;			　copyMembers()を使うと三倍以上時間がかかるため。
;			・KClickableLayer.playSound()でbufを指定してもbuf=0と
;			　処理されていたのを修正
; 2013/04/21	0.99α	・ButtonLayerにentercolor/clickcolorを追加
;			・ButtonLayerのface = dfAlphaを削除。defだから不要の筈
;			・フォントをKFont()クラスとして新規作成
;			・アニメーションを実行するstartAnim()を、関数の最後
;			　ではなく、可能な限り上位で実行するように変更
;			・K*_setOptions()をcopyLocalMembers()に名称変更
;			・↑での値設定をcopyAllMember()関数で実行するよう変更
;			・ToggleのonCheck/onUncheckをonMouseRelease()で動作
;			　するように変更。フルスクリーン切り替え時に onMouseUp
;			　イベントが起こらない場合がある問題への対策
;			・RadioButtonは、assignするとボタン順が変わる？focusの
;			　順番も変わってるっぽい
;
; 2012/04/23	0.98c	・フォーカスされているレイヤを削除する時(delOnPage()と
;			　del()する時)にwindow.focusedLayer=nullを追加
;			・onFocus()でマウスカーソルを動かすのを、キーが
;			　押された時のみに限定(MessageLayerでそうやってるし)
; 2012/02/21	0.98b	フォーカスされているレイヤをvisible/enabled=falseに
;			設定してフォーカスが動くのを避けるために、KLayer
;			クラスにonSearchNextFocusable()を追加
; 2011/08/13	0.98a	Layerクラスのorderメンバを変更しないように修正
; 2011/06/25	0.98	setOptions()でsetOptions_sub()を使わぬよう変更
;			setOptions()で(keys(elm).count <= 0))を判定せぬように
;			evalstr()をTJSFunctionsのstr2num()に変更
; 2011/06/11	0.97	KLayerクラスにcaptionface を追加
; 2011/05/30	0.95	classid が無いものがあったので追加
;			KLayersPluginのonStore/Restoreのforの順番を変更
;			onRestore()時、elm.backlay == true でfore->back戻し要
;			onRestore()の第二引数がclearだったのを忘れてて修正
;			setOptions()でloadImages()の前にsetOptions_sub() すると
;			imageLeftなどが設定される場合に「範囲外の画像表示」
;			エラーとなるのを修正
;			KSliderLayerのfinalize()にtimer.enabled=falseを追加
;			discardImage() に hasImage=0, hasImage=1 を追加
;			KRadioButtonLayerのsetOptions()で、ボタン数==0を弾いた
; 2011/04/06	0.91	hitThresholdをKLayerで256に、KClickableLayerで16にした
;			hitThresholdを保存するようにした
; 2011/03/26	0.90	KAnimButtonLayerのタグをKAnimLayerと統合
;			各所startanim()の引数間違いを修正
;			setOptions() で elm.clickstorage!==voidかつ
;			elm.clicktarget===voidの時のclicktarget初期化違いを修正
;			KAnimButtonLayerにonBlur()追加
;			KAnimLayerなどの[disp]引数を x,y → sx,sy に変更

[call storage="TJSFunctions.ks"]

[iscript]

/*
   KLayers継承ツリー

Layer
    → KLayer .................................. 基本レイヤ
        → KAnimLayer .......................... アニメーションレイヤ
        → KClickableLayer ..................... クリック可能レイヤ
            → KButtonLayer .................... ボタンレイヤ
                → KAnimButtonLayer ............ アニメーションボタンレイヤ
                    → KToggleButtonLayer ...... トグルボタンレイヤ
                        → KCheckBoxTopLayer ... チェックボックスのトップ部分
                        → KRadioButtonItem .... ラジオボタンの１アイテム
                    → KCheckBoxLayer .......... チェックボックスレイヤ
                    → KSliderTabLayer ......... スライダーのタブ部分
        → KSliderLayer ........................ スライダーレイヤ(ベースのみ)
        → KRadioButtonLayer ................... ラジオボタンレイヤ(ベースのみ)

 */

// デフォルトの表示優先順位
sf.KLAYERS_DEFABSOLUTE = 2000000-2;

/*
KLayersのスケルトンは以下の通り。
class KAGLayers_skelton // extends KAGLayer(またはその派生レイヤ)
{
	var classid;	// クラス名の文字列
	// var name; name は Layer クラスに有るので定義不要。

	// コンストラクタ。name/elmは省略可能
	function KAGLayers_skelton(w, p, name, elm);

	// デストラクタ
	function finalize();

	// オプション設定。elm===voidのことも考えておくこと
	function setOptions(elm);

	// オブジェクトのコピー
	function assign(src);

	// オブジェクトセーブ時に、自身の辞書配列dicを作って返す
	function store();

	// オブジェクトロード時に、辞書配列dicを元に自身を設定する(dicを返す)
	function restore(dic);
}
行頭から書いちゃうとラベルと認識されてしまう。注意 */

// レイヤーを派生すると遅くなるので、KAGLayerではなく、Layerクラスをそのまま
// 使う。なんかの拍子に戻してもいいけど…。



// 必要ならコピーする... メンバの変更や辞書コピーにはこれを使う
function copyMember(d, s, key, numeric=true, copyifvoid=false)
{
	if (typeof(s[key]) != 'undefined' &&
	    (s[key] !== void || copyifvoid))
		d[key] = (numeric && !copyifvoid) ? +s[key] : s[key];
}


// このプラグインを読み込んだ時の kag.fore.messages[0] の値を得る
// で、これを KFont のデフォルト値に使う。
var KFont_default = %[];
{
	var l = kag.fore.messages[0];
	KFont_default = %[
		vertical	: l.vertical,	// 縦書き・横書き
		face		: l.userFace,
		color		: l.defaultChColor,
		height		: l.defaultFontSize,
		bold		: l.defaultBold,
		italic		: 0,		// イタリックは初期値がなかった
// strikeout/underline は今は意味がないらしいから削除
//		strikeout	: false,	// 取り消し線
//		underline	: false,	// アンダーライン
		opacity		: 255,		// 透明度は初期値がなかった
		antialiased	: l.antialiased,
		// ここから後は l.defaultEdge/defaultShadowにより変わる
		shadowlevel	: 0,
		shadowcolor	: 0x000000,
		shadowwidth	: 0,
		shadowoffsetx	: 0,
		shadowoffsety	: 0
	];

	// 影指定だったときのデフォルト値
	if (l.defaultShadow) {
		KFont_default.shadowlevel	= 255;
		KFont_default.shadowcolor	= l.defaultShadowColor;
		KFont_default.shadowwidth	= 0;
		KFont_default.shadowoffsetx	= l.shadowOffsetX;
		KFont_default.shadowoffsety	= l.shadowOffsetY;
	}
	// 縁取り指定だったときのデフォルト値
	if (l.defaultEdge) {
		KFont_default.shadowlevel	= l.edgeEmphasis;
		KFont_default.shadowcolor	= l.defaultEdgeColor;
		KFont_default.shadowwidth	= l.edgeExtent;
		KFont_default.shadowoffsetx	= 0;
		KFont_default.shadowoffsety	= 0;
	}
}


// フォント情報を保存するクラス
class KFont
{
	var vertical;		// 縦書き・横書き
	var face;		// フォント名
	var color;		// フォント色
	var height;		// フォントサイズ
	var bold;		// 太字か否か(true/false)
	var italic;		// 斜体か否か(true/false)
// strikeout/underline は今は意味がないらしいから削除
//		strikeout	: false,	// 取り消し線
//		underline	: false,	// アンダーライン
	var opacity;		// 文字の透明度
	var antialiased;	// 文字のぼかし具合
	var shadow;		// 影付き文字か否か(true/false)
	var shadowlevel;	// 影の透明度
	var shadowcolor;	// 影付き文字の影の色
	var shadowwidth;	// 影付き文字の影のぼかし具合
	var shadowoffsetx;	// 影付き文字の影の横オフセット
	var shadowoffsety;	// 影付き文字の影の横オフセット

	// コンストラクタ
	function KFont(elm)
	{
		setOptions(KFont_default);
		setOptions(elm);
	}

	// デストラクタ
	function finalize()
	{
	}

	// オプション設定(2オペランド版)
	function copyLocalMembers(d, s)
	{
		if (d === void || s === void)
			return;
		if (typeof(s) == "String") // 引数が文字列なら辞書にして設定
			s = ("%["+s+"]")!; 
		d.vertical      = +s.vertical      if (s.vertical    !== void);
		d.face          = s.face           if (s.face        !== void);
		d.color         = +s.color         if (s.color       !== void);
		d.height        = +s.height        if (s.height      !== void);
		d.bold          = +s.bold          if (s.bold        !== void);
		d.italic        = +s.italic        if (s.italic      !== void);
// strikeout/underline は今は意味がないらしいから削除
//		d.strikeout     = s.strikeout      if (s.strikeout   !== void);
//		d.underline     = s.underline      if (s.underline   !== void);
		d.opacity       = +s.opacity       if (s.opacity     !== void);
		d.antialiased   = +s.antialiased   if (s.antialiased !== void);
		d.shadowlevel   = +s.shadowlevel   if (s.shadowlevel !== void);
		d.shadowcolor   = +s.shadowcolor   if (s.shadowcolor !== void);
		d.shadowwidth   = +s.shadowwidth   if (s.shadowwidth !== void);
		d.shadowoffsetx = +s.shadowoffsetx if (s.shadowoffsetx!==void);
		d.shadowoffsety = +s.shadowoffsety if (s.shadowoffsety!==void);
	}

	// このクラス以下の全てのメンバーをコピーする
	function copyAllMembers(dst, src)
	{
		.KFont.copyLocalMembers(dst, src);
	}

	// オプション設定
	function setOptions(elm)
	{
		.KFont.copyLocalMembers(this, elm);
	}

	// フォントを設定する
	function setFont(layer) {
		selectcopy_dic(layer.font, this,
			    ['bold','face','height','italic']);
		layer.font.angle = 0;
		if (vertical) {
			// 縦書きの時
			layer.font.angle = 2700;
			layer.font.face = '@' + face;
		}
	}

	// テキスト描画
	function drawText(layer, x, y, text)
	{
		if (text === void || text == '')
			return;
		.KFont.setFont(layer);
		layer.drawText(x, y, text, color, opacity, antialiased,
				shadowlevel, shadowcolor, shadowwidth,
				shadowoffsetx, shadowoffsety);
	}

	// テキスト幅
	function getTextWidth(layer, text)
	{
		.KFont.setFont(layer);
		return layer.font.getTextWidth(text);
	}

	// テキスト高
	function getTextHeight(layer, text)
	{
		.KFont.setFont(layer);
		return l.font.getTextHeight(text);
	}

	// コピー
	function assign(src)
	{
		.KFont.copyLocalMembers(this, src);
	}

	// セーブ時に上から呼ばれる
	function store()
	{
		var dic = %[];
		.KFont.copyLocalMembers(dic, this);
		return dic;
	}

	// ロード時に上から呼ばれる
	function restore(dic)
	{
		if (dic === void) {
			.KFont.setOptions(KFont_default); //せめてデフォルトに
			return;
		}
		.KFont.setOptions(dic);
		return dic;
	}
};


// 画像・テキストを表示するだけのレイヤー
class KLayer extends Layer
{
	var classid = "KLayer";		// 定数
//	var name;			// 名前(Layerクラス中で定義済ゆえ不要)
	var kfont;			// フォント(ボタン用にkfontとした)
					// fontはLayerにあるので使えないし
	var vertical   = false;		// 縦書きかどうか
	var text       = "";		// 表示する文字
	var texthalign = 'center';	// 文字表示位置(left/center/right)
	var textvalign = 'center';	// 文字表示位置(top/center/bottom)
	var textleft   = 0;		// 文字表示領域の上座標X
	var texttop    = 0;		// 文字表示領域の上座標Y
	var textwidth  = 0;		// 文字表示領域の横サイズ(0で横一杯)
	var textheight = 0;		// 文字表示領域の縦サイズ(0で縦一杯)
	var linespace  = 2;		// 行間隔
	var color;
	var graphic;			// 画像ファイル名(voidで画像なし)
	var graphickey;			// 画像の抜き色

	// prevFocusable/nextFocusableはreadonlyなので新たにメンバを作る
	var _prevfocus = null, _nextfocus = null;

// 追加するか後で考える
//	var oncreate;
//	var createstorage;
//	var createtarget;
//	var ondestroy;
//	var destroystorage;
//	var destroytarget;

	// コンストラクタ
	function KLayer(window, parent, i_name = "", elm)
	{
		super.Layer(window, parent);
		name         = i_name;
//		setSize(32,32);		// デフォルトサイズなので設定不要
		focusable    = false;	// デフォルトでは unfocusable
		hitThreshold = 256;	// デフォルトでは当たり判定なし
		absolute     = sf.KLAYERS_DEFABSOLUTE;
		visible      = true;
		kfont        = new KFont();
		color        = 0xff404040;
		setOptions(elm);
	}

	// デストラクタ
	function finalize()
	{
		invalidate kfont;
		super.finalize();
	}

	// Layerクラスのローカルのメンバをコピー
	function Layer_copyLocalMembers(d, s)
	{
		if (Scripts.getClassNames(d).find('Layer') >= 0) {
			// Layerのときは setPos()/setImagePos() を使う
			if (Scripts.getClassNames(s).find('Layer') >= 0) {
				d.setPos(+s.left, +s.top, +s.width, +s.height);
				// imagepos=(0,0)にしてサイズ変更するのがミソ
				// こうしないと「画像ない領域を描画」になる
				d.setImagePos(0, 0);
				d.setImageSize(+s.imageWidth, +s.imageHeight);
				d.setImagePos(+s.imageLeft,  +s.imageTop);
			} else {
				var l, t, w, h;
				l = (s.left  !==void) ? +s.left   : +d.left;
				t = (s.top   !==void) ? +s.top    : +d.top;
				w = (s.width !==void) ? +s.width  : +d.width;
				h = (s.height!==void) ? +s.height : +d.height;
				d.setPos(l, t, w, h);
				l = (s.imageLeft  !==void) ? +s.imageLeft   : +d.imageLeft;
				t = (s.imageTop   !==void) ? +s.imageTop    : +d.imageTop;
				w = (s.imageWidth !==void) ? +s.imageWidth  : +d.imageWidth;
				h = (s.imageHeight!==void) ? +s.imageHeight : +d.imageHeight;
				// imagepos=(0,0)にしてサイズ変更するのがミソ
				// こうしないと「画像ない領域を描画」になる
				d.setImagePos(0, 0);
				d.setImageSize(w, h);
				d.setImagePos(l, t);
			}
		} else {
			// Layerでないときはテキトーにコピー
			d.left       = +s.left        if (s.left      !==void);
			d.top        = +s.top         if (s.top       !==void);
			d.width      = +s.width       if (s.width     !==void);
			d.height     = +s.height      if (s.height    !==void);
			d.imageLeft  = +s.imageLeft   if (s.imageLeft !==void);
			d.imageTop   = +s.imageTop    if (s.imageTop  !==void);
			d.imageWidth = +s.imageWidth  if (s.imageWidth!==void);
			d.imageHeight= +s.imageHeight if (s.imageHeight!==void);
		}

		// コメントアウトされているメンバはreadonlyのもの
		d.absolute     = +s.absolute     if (s.absolute     !== void);
		d.absoluteOrderMode = s.absoluteOrderMode if (s.absoluteOrderMode !== void);
		d.attentionLeft = +s.attentionLeft if(s.attentionLeft!== void);
		d.attentionTop = +s.attentionTop if (s.attentionTop !== void);
		d.cached       = +s.cached       if (s.cached       !== void);
//		"callOnPaint",		//onPaint()を呼ぶか
//		"children",		//子レイヤ配列
		d.clipHeight   = +s.clipHeight   if (s.clipHeight   !== void);
		d.clipLeft     = +s.clipLeft     if (s.clipLeft     !== void);
		d.clipTop      = +s.clipTop      if (s.clipTop      !== void);
		d.clipWidth    = +s.clipWidth    if (s.clipWidth    !== void);
		d.cursor       = s.cursor        if (s.cursor       !== void);
//		"cursorX",		// マウスカーソル位置X
//		"cursorY",		// マウスカーソル位置Y
		d.enabled      = +s.enabled      if (s.enabled      !== void);
		d.face         = +s.face         if (s.face         !== void);
		d.focusable    = +s.focusable    if (s.focusable    !== void);
//		"focused",		//フォーカスされているかどうか
//		"font",			//フォント
//		"hasImage",		//レイヤが画像持ちかどうか

//##コピー済み	d.height       = +s.height       if (s.height       !== void);
		d.hint         = s.hint          if (s.hint         !== void);
		d.hitThreshold = +s.hitThreshold if (s.hitThreshold !== void);
		d.hitType      = +s.hitType      if (s.hitType      !== void);
		d.holdAlpha    = +s.holdAlpha    if (s.holdAlpha    !== void);

//##コピー済み	d.imageHeight  = +s.imageHeight  if (s.imageHeight  !== void);
//##コピー済み	d.imageLeft    = +s.imageLeft    if (s.imageLeft    !== void);
		d.imageModified= +s.imageModified if(s.imageModified!== void);
//##コピー済み	d.imageTop     = +s.imageTop     if (s.imageTop     !== void);
//##コピー済み	d.imageWidth   = +s.imageWidth   if (s.imageWidth   !== void);
		d.imeMode      = +s.imeMode      if (s.imeMode      !== void);
//		"isPrimary",		//プライマリレイヤかどうか
		d.joinFocusChain=s.joinFocusChain if(s.joinFocusChain!==void);
//##コピー済み	d.left         = +s.left         if (s.left         !== void);
//		"mainImageBuffer",	//メイン画像バッファ
//		"mainImageBufferForWrite",//メイン画像バッファ(書き込み用)
//		"mainImageBufferPitch",	//メイン画像バッファピッチ
		d.name         = s.name          if (s.name         !== void);
		d.neutralColor = +s.neutralColor if (s.neutralColor !== void);
//		"nextFocusable",	//後方のフォーカスを受け取れるレイヤ
//		"nodeEnabled",		//レイヤノードが操作可能かどうか
//		"nodeVisible",		//ノードが可視かどうか
		d.opacity      = +s.opacity      if (s.opacity      !== void);
//指定するとabsoluteが変わるのでここでは指定しない "order"	//相対位置
//		"parent",		//親レイヤ
//		"prevFocusable",	//前方のフォーカスを受け取れるレイヤ
//		"provinceImageBuffer",	//領域画像バッファ
//		"provinceImageBufferForWrite",//領域画像バッファ(書き込み用)
//		"provinceImageBufferPitch",//領域画像バッファピッチ
		d.showParentHint=+s.showParentHint if(s.showParentHint!==void);
//##コピー済み	d.top          = +s.top          if (s.top          !== void);
		d.type         = +s.type         if (s.type         !== void);

		d.useAttention = +s.useAttention if (s.useAttention !== void);
		d.visible      = +s.visible      if (s.visible      !== void);
//##コピー済み	d.width        = +s.width        if (s.width        !== void);
//		"window"		//ウィンドウオブジェクト

//		if (!parent.absoluteOrderMode) こうすると兄弟レイヤのabsolute
//			dst.order = src.order; を変えてた時に困るので削除

	}

	// このクラスのメンバ設定
	function copyLocalMembers(d, s)
	{
		if (d === void || s === void)
			return;
		d.classid    = s.classid     if (s.classid    !== void);
		d.vertical   = +s.vertical   if (s.vertical   !== void);
		d.text       = s.text        if (s.text       !== void);
		d.texthalign = s.texthalign  if (s.texthalign !== void);
		d.textvalign = s.textvalign  if (s.textvalign !== void);
		d.textleft   = +s.textleft   if (s.textleft   !== void);
		d.texttop    = +s.texttop    if (s.texttop    !== void);
		d.textwidth  = +s.textwidth  if (s.textwidth  !== void);
		d.textheight = +s.textheight if (s.textheight !== void);
		d.linespace  = +s.linespace  if (s.linespace  !== void);
		d.color      = +s.color      if (s.color      !== void);
		d.graphic    = s.graphic     if (s.graphic    !== void);
		d.graphickey = +s.graphickey if (s.graphickey !== void);
// nextfocus/prevfocus は、assign()、store()いずれでもコピーしない。
// コピーすると、裏画面・表画面での参照レイヤがおかしくなるため。

		d.kfont = %[] if (d.kfont === void);
		.KFont.copyLocalMembers(d.kfont, s.kfont);
	}

	// このクラス以下の全てのメンバーをコピーする
	function copyAllMembers(dst, src)
	{
		Layer_copyLocalMembers(dst, src);
		.KLayer.copyLocalMembers(dst, src);
	}

	// オプション設定
	function setOptions(elm)
	{
		if (elm === void)
			return;

		// 先に画像を読む。imageLeft等設定され画像範囲外の表示を防ぐ為
		.KLayer.loadImages(elm.graphic, elm.graphickey); // voidでもOK
		Layer_copyLocalMembers(this, elm);
		.KLayer.copyLocalMembers(this, elm);
		if (elm.graphic !== void && elm.graphic == "")
			graphic = void;	// loadImages()で設定したgraphicが
					// setOptions()で上書きされるため再設定
		redraw();
	}

	// イメージを読む ※引数無しで同じイメージを読み込む
	function loadImages(graphic=this.graphic, key=this.graphickey)
	{
		this.graphickey = (key===void) ? void : +key;
		this.graphic    = graphic;
		if (graphic === void || graphic == "") {
			.KLayer.discardImage();
			return;
		}
		// 画像があれば
		super.loadImages(graphic, this.graphickey);
		// サイズをイメージサイズに合わせる
		setSizeToImageSize();
		// 文字があるときは文字を描画
		drawTextWithAlign(kfont, text);
	}

	// 画像を無効化する
	function discardImage()
	{
		graphic = void;
		hasImage = 0;	hasImage = 1;	// これで画像を一度無効化する
		fillRect(0, 0, width, height, color);
		// 文字があるときは文字を描画
		drawTextWithAlign();
	}

	// マウスが押された場合
	function onMouseDown(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		// イベントを透過するため、親へ伝えるだけ
		parent.onMouseDown(left+x, top+y, button, shift);
	}

	// マウスが放された場合
	function onMouseUp(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		// 親へイベントを伝えるだけ
		parent.onMouseUp(left+x, top+y, button, shift);
	}

	// マウスが入った時
	function onMouseEnter()
	{
		if (focusable && enabled && visible) {
			focus() if (!focused);
			return;
		}
		super.onMouseEnter(...);
	}

	// キーが押された時
	function onKeyDown(key, shift, process)
	{
		if (process && key == VK_TAB) {
			// TABが押されたら次のfocusableなレイヤを探す
			var l = shift ? prevfocus : nextfocus;
			while (l != null && l != this) {
				if (l.focusable && l.enabled && l.visible) {
					l.focus(!shift) if(!l.focused);
					break;
				}
				l = shift ? l.prevfocus : l.nextfocus;
			}
			super.onKeyDown(key, shift, false);
		} else {
			super.onKeyDown(...);
		}
	}

	// アラインを考えつつテキスト描画(横書き)
	function drawTextWithAlign_subH(tfont, lines, offx, offy)
	{
		var twidth  = (textwidth ==0) ? width -textleft*2 : textwidth;
		var theight = (textheight==0) ? height-texttop*2  : textheight;
		var lh = tfont.height*lines.count + linespace*(lines.count-1);
		var ly = texttop+(theight-lh)/2;
		if (textvalign == 'top')
			ly = texttop;
		else if (textvalign == 'bottom')
			ly = texttop+theight-lh;
		for (var i = 0; i < lines.count; i++) {
			var lw = tfont.getTextWidth(this, lines[i]);
			var lx = (width-lw)/2;
			if (texthalign == 'left')
				lx = textleft;
			else if (texthalign == 'right')
				lx = textleft+twidth-lw;
			tfont.drawText(this, lx+offx, ly+offy, lines[i]);
			ly += tfont.height+linespace;
		}
	}

	// アラインを考えつつテキスト描画(縦書き)
	function drawTextWithAlign_subV(tfont, lines, offx, offy)
	{
		var twidth  = (textwidth ==0) ? width -textleft*2 : textwidth;
		var theight = (textheight==0) ? height-texttop*2  : textheight;
		var lw = tfont.height*lines.count + linespace*(lines.count-1);
		var lx = textleft+(twidth-lw)/2 + tfont.height;
		if (texthalign == 'left')
			lx = textleft + tfont.height;
		else if (texthalign == 'right')
			lx = textleft+theight-lw + tfont.height;
		for (var i = 0; i < lines.count; i++) {
			var lh = tfont.getTextWidth(this, lines[i]);
			var ly = (height-lh)/2;
			if (textvalign == 'top')
				ly = texttop;
			else if (textvalign == 'bottom')
				ly = texttop+theight-lh;
			tfont.drawText(this, lx+offx, ly+offy, lines[i]);
			lx += tfont.height+linespace;
		}
	}

	// アラインを考えつつテキスト描画
	function drawTextWithAlign(tfont=kfont, text=this.text, offx=0, offy=0)
	{
		if (text === void || text == "")
			return;
		// setOptions_subで数値に変換される場合があるので文字列に変換
		text = string(text);
		var lines = text.split(/\[r\]/); // 改行マークで配列に変換
		if (lines.count <= 0)
			return;
		kfont.vertical = vertical;
		if (vertical)
			drawTextWithAlign_subV(tfont, lines, offx, offy);
		else
			drawTextWithAlign_subH(tfont, lines, offx, offy);
	}

	// スクリプト文字列を、自身をコンテキストとして実行する
	function eval(str)
	{
		if (str === void || str == "")
			return;
		if (str[0] == '&')
			str = str.substr(1);
		// 末尾が ! だったら、自身をコンテキストとして実行
		if (str[str.length-1] == '!') {
			str = str.substr(0, str.length-1);
			return str!;
		}
		return Scripts.eval(str);
	}

	// 表示されているものをもう一度描く
	function redraw()
	{
		if (graphic === void) {
			// 画像がなければ
			fillRect(0, 0, width, height, color);
		} else if (graphic !== void) {
			// 画像があれば
			super.loadImages(graphic, graphickey);
			// サイズをイメージサイズに合わせる
			setSizeToImageSize();
		}
		// 文字があるときは文字を描画
		drawTextWithAlign();
	}

	// レイヤ枠にでこぼこを描画
	function drawRuggedness(rugged=true, offx=0, dekocolor=0xffffff, dekoopa=128, bokocolor=0x000000, bokoopa=128)
	{
		var w = width, h = height;
		var c1 = rugged ? dekocolor : bokocolor;
		var o1 = rugged ? dekoopa   : bokoopa;
		var c2 = rugged ? bokocolor : dekocolor;
		var o2 = rugged ? bokoopa   : dekoopa;
		colorRect(  0+offx,   0,   w,   1, c1, o1);
		colorRect(  0+offx,   1,   1, h-2, c1, o1);
		colorRect(w-1+offx,   1,   1, h-1, c2, o2);
		colorRect(  1+offx, h-1, w-2,   1, c2, o2);
	}

	// コピー
	function assign(src)
	{
		.KLayer.copyAllMembers(this, src);
		// ↓KAGLayerにはassign()はない、最後に実行する必要あり
		super.assignImages(src, true);
	}

	// セーブ時に上から呼ばれる
	function store()
	{
//		var dic = super.store(); スーパークラスが Layerだから不要
		var dic = %[];
		.KLayer.copyAllMembers(dic, this);
		return dic;
	}

	// ロード時に上から呼ばれる
	function restore(dic)
	{
		if (dic === void)
			return;
//		super.restore(dic);	スーパークラスが Layerだから不要
		.KLayer.setOptions(dic);
		return dic;
	}

	// フォーカスの直前に呼ばれる
	function onBeforeFocus(layer, blurred, dir)
	{
//dm('onBeforeFocus on KLayer: ' + this);
		if (focusable && enabled && visible) {
			super.onBeforeFocus(layer, blurred, dir);
			return;
		}
		if (blurred == layer)
			return;	// これでフォーカスの無限ループを防ぐ。
				// ただし、一つ以上focusableがあれば。
		// 次のフォーカス可能レイヤを探す
		(dir ? nextfocus : prevfocus).focus(dir);
	}
/*
 これがあると、assign()した時にもグラフィックがdiscardされてしまうので削除
	property color {
		setter(x) {
			color_save = x;
			discardImage();	// 画像を無効化してcolorで塗りつぶす
		}
		getter {
			return color_save;
		}
	}
行頭に*を配置しない  */
/*
redraw()を呼ぶと子クラスに悪影響が出るので、呼ばないようにする
	// widthのproperty。設定されるとredrawする
	property width {
		setter(x) {
			if (x != super.width) {
				super.width = x;
				redraw();
			}
		}
		getter {
			return super.width;
		}
	}

	// heightのproperty。設定されるとredrawする
	property height {
		setter(x) {
			if (x != super.height) {
				super.height = x;
				redraw();
			}
		}
		getter {
			return super.height;
		}
	}

行頭に*を配置しない  */

	// フォーカスレイヤを双方向に設定
	property prevfocus {
		setter(x) {
			_prevfocus = x;
			x._nextfocus = this if (x != null);
		}
		getter {
			return _prevfocus;
		}
	}
	property nextfocus {
		setter(x) {
			_nextfocus = x;
			x._prevfocus = this if (x != null);
		}
		getter {
			return _nextfocus;
		}
	}

	// setSizeのproperty。設定されるとredrawする
	function setSize(w=width, h=height)
	{
		if (w != width || h != height) {
			super.setSize(w, h);
			redraw();
		}
	}
}


// アニメーションつきレイヤ
class KAnimLayer extends KLayer
{
	var classid = "KAnimLayer";	// 定数
//	var name;			// 名前(Layerクラス中で定義済ゆえ不要)
	var conductor;			// アニメーションのコンダクタ
//	var graphic;	// アニメーションパターン画像…は親クラスに既にあるので

	// コンストラクタ
	function KAnimLayer(win, par, i_name="", elm)
	{
		conductor = new AnimationConductor(this);
		super.KLayer(win, par, i_name);
		setOptions(elm);
	}

	// デストラクタ
	function finalize()
	{
		invalidate conductor;
		super.finalize();
	}

	// conductorはloadImages()中で設定されるのでsetOptions()は不要

	// アニメーションを停止する
	function stopAnim()
	{
		conductor.stop();
	}

	// イメージを読み込む。heightは後で指定すること
	function loadImages(graphic, key)
	{
		stopAnim();
		super.loadImages(graphic, key);
		// アニメーション情報があれば読む
		loadAnimInfo(graphic);
	}

	// アニメーション情報ファイルを読み込む
	function loadAnimInfo(graphic)
	{
		startAnim(Storages.chopStorageExt(graphic)+".adf", "");
	}

	// アニメーションを開始する
	function startAnim(storage=conductor.curStorage, label)
	{
		stopAnim();
		if (storage !== void && storage != "" &&
		    Storages.isExistentStorage(storage)) {
			// アニメーション定義ファイルが存在した
			conductor.startLabel = label;
			conductor.stopping = false;
			conductor.running = true;
			conductor.clearCallStack();
//			conductor.interrupted = Anim_interrupted;
			conductor.loadScenario(storage);
			conductor.goToLabel(label);
			conductor.startProcess(true);
		}
	}

	// コピー
	function assign(src)
	{
		super.assign(src);
		conductor.assign(src.conductor);
	}

	// セーブ
	function store()
	{
		var dic = super.store();
		dic.conductor = conductor.store();
		return dic;
	}

	// ロード
	function restore(dic)
	{
		stopAnim();
		if (dic === void)
			return;
		super.restore(dic);	// この中で setOptions(dic) を実行する
		// 以下は吉里吉里のバグだと思うけど、やっとかないと
		// 「ハードウェアエラーが発生しました」になってしまう…。
		if (dic.conductor.storageName != "")
			conductor.restore(dic.conductor);
		else {
			invalidate conductor;
			conductor = new AnimationConductor(this);
		}
		return dic;
	}

// ここからタグハンドラ ------------------------------------------------

	// いわゆる [s]
	function s(elm)
	{
		// 停止
		elm.context.running = false;
		return -1; // 停止
	}

	// タグハンドラ loadcell() は何もしない
	function loadcell()
	{
		// .adf ファイルに存在した時にエラーにしないためのダミー
		return 0;
	}

	// 追加タグハンドラ pos(x, y)
	function pos(elm)
	{
		left    =  str2num(elm.x,      left);
		top     =  str2num(elm.y,       top);
		left    += str2num(elm.dx,        0);
		top     += str2num(elm.dy,        0);
		opacity =  str2num(elm.opa, opacity);
		opacity += str2num(elm.iopa,      0);
		return 0;
	}

	// 追加タグハンドラ size(w, h)
	function size(elm)
	{
		setSize(str2num(elm.w, width), str2num(elm.h, height));
		return 0;
	}

	// index 値の範囲を 0～max に正規化する
	function evalidx(cur, max)
	{
		var ret = cur%max;
		return (ret >= 0) ? ret : ret+max;
	}

	// dispタグ上書きハンドラ
	function disp(elm)
	{
		var sx = str2num(elm.sx);
		var sy = str2num(elm.sy); // def=0(-imageLeftじゃない) に注意
		if (elm.six !== void) {
			var cursix = -imageLeft\width;
			var idx = str2num(elm.six.replace(/six/, cursix));
			sx = evalidx(idx, imageWidth\width) * width;
		}
		if (elm.siy !== void) {
			var cursiy = -imageTop\height;
			var idx = str2num(elm.siy.replace(/siy/, cursiy));
			sy = evalidx(idx, imgeHeight\height) * height;
		}
		if (elm.index !== void) {
			var curidx = -imageTop\height;
			var idx = str2num(elm.index.replace(/index/, curidx));
			sy = evalidx(idx, imageHeight\height) * height;
		}
		setImagePos(-(sx), -(sy));
		return 0;
	}

	// タグハンドラ追加、loop
	function loop(elm)
	{
		// ループすることを宣言する
		// セグメントによってはループしたりしなかったりするため。
		elm.context.looping = true;
		return 0;
	}

	// タグハンドラ追加、noloop：loopの反対。
	function noloop(elm)
	{
		// ループを使わないことを宣言する
		// セグメントによってはループしたりしなかったりするため。
		elm.context.looping = false;
		return 0;
	}

	// タグハンドラ追加 wait
	function wait(elm)
	{
		return elm.time; // 指定時間だけ停止
	}

// これ、KLayerのeval()とかぶるので削除。困んないかしら。
	// タグハンドラ
//	function eval(elm)
//	{
//		eval(elm.exp); // elm.exp を式として実行
//		return 0;
//	}
}

// KClickableLayer.ncactionに入る定数
var NCACTION_SENDPARENT = 0;	// マウスイベントを親に送る
var NCACTION_NOACTION = 1;	// マウスイベントを捨てる


// ボタンにも使えるが画像変化しないレイヤ
class KClickableLayer extends KLayer
{
	var classid 		= "KClickableLayer";// 定数

	var countpage 		= true;		// [button]タグのcountpage参照

	var repeatable          = false;	// リピート可能かどうか
	var repeatbutton;			// リピート中ボタン(テンポラリ)
	var repeattimer;			// リピート動作のタイマー
	var repeatinterval1     = 500;		// リピート間隔1(初回)
	var repeatinterval2     = 100;		// リピート間隔2

	// オプション群
	// 左ボタンを押された時に使用する変数
	var onclick;		// 押された時に実行する動作
	var clickse;		// 押された時に鳴らす音
	var clicksebuf = 0;	// 押された時に鳴らす音のバッファ
	var clickstorage;	// 押された時にジャンプするシナリオファイル
	var clicktarget;	// 押された時にジャンプするシナリオラベル

	// 右ボタンを押された時に使用する変数
	var onrclick;		// 押された時に実行する動作
	var rclickse;		// 押された時に鳴らす音
	var rclicksebuf = 0;	// 押された時に鳴らす音のバッファ
	var rclickstorage;	// 押された時にジャンプするシナリオファイル
	var rclicktarget;	// 押された時にジャンプするシナリオラベル

	// 中ボタンを押された時に使用する変数
	var onmclick;		// 押された時に実行する動作
	var mclickse;		// 押された時に鳴らす音
	var mclicksebuf = 0;	// 押された時に鳴らす音のバッファ
	var mclickstorage;	// 押された時にジャンプするシナリオファイル
	var mclicktarget;	// 押された時にジャンプするシナリオラベル

	// 左ボタンが離された時に使用する変数
	var onrelease;		// 離された時に実行する動作
	var releasese;		// 離された時に鳴らす音
	var releasesebuf = 0;	// 離された時に鳴らす音のバッファ
	var releasestorage;	// 離された時にジャンプするシナリオファイル
	var releasetarget;	// 離された時にジャンプするシナリオラベル

	// 右ボタンが離された時に使用する変数
	var onrrelease;		// 離された時に実行する動作
	var rreleasese;		// 離された時に鳴らす音
	var rreleasesebuf = 0;	// 離された時に鳴らす音のバッファ
	var rreleasestorage;	// 離された時にジャンプするシナリオファイル
	var rreleasetarget;	// 離された時にジャンプするシナリオラベル

	// 中ボタンが離された時に使用する変数
	var onmrelease;		// 離された時に実行する動作
	var mreleasese;		// 離された時に鳴らす音
	var mreleasesebuf = 0;	// 離された時に鳴らす音のバッファ
	var mreleasestorage;	// 離された時にジャンプするシナリオファイル
	var mreleasetarget;	// 離された時にジャンプするシナリオラベル

	var onenter;		// ポインタが入った時に実行する動作
	var enterse;		// ポインタが入った時に鳴らす音
	var entersebuf = 0;	// ポインタが入った時に鳴らす音のバッファ
	var enterstorage; // ポインタが入った時にジャンプするシナリオファイル
	var entertarget;  // ポインタが入った時にジャンプするシナリオラベル

	var onleave;		// ポインタが出た時に実行する動作
	var leavese;		// ポインタが出た時に鳴らす音
	var leavesebuf = 0;	// ポインタが出た時に鳴らす音のバッファ;
	var leavestorage; // ポインタが出た時にジャンプするシナリオファイル
	var leavetarget;  // ポインタが出た時にジャンプするシナリオラベル

	// ボタン押せるかどうか、押せないボタンが押された時の動作を定義。
	// defaultでは、「左クリックだけ可能、それ以外は親に通知」
	var clickablemb = VK_LBUTTON;		// 押せるボタン
			// ↑論理和にできるのは偶然なんだけどな…
	var ncaction    = NCACTION_SENDPARENT;		// 動作を定義

	// コンストラクタ
	function KClickableLayer(win, parent, i_name, elm)
	{
		super.KLayer(win, parent, i_name);
		if(typeof win.cursorPointed !== "undefined")
			cursor = win.cursorPointed;
		hitThreshold = 0;
		focusable = true;	// フォーカスを得られる

		repeattimer = new Timer(this, "onMouseDownRepeat");
		repeattimer.interval = repeatinterval1;

		setOptions(elm);
	}

	// デストラクタ
	function finalize()
	{
		repeattimer.enabled = false;
		invalidate repeattimer;
		super.finalize(...);
	}

	// このレイヤローカルのメンバをコピー
	function copyLocalMembers(d, s)
	{
		d.countpage  = +s.countpage  if (s.countpage !== void);
		d.repeatable = +s.repeatable if (s.repeatable !== void);
//	"repeattimer.interval"
//	"repeattimer.enabled"
		d.repeatinterval1 = +s.repeatinterval1 if (s.repeatinterval1 !== void);
		d.repeatinterval2 = +s.repeatinterval2 if (s.repeatinterval2 !== void);

		d.onclick      = s.onclick       if (s.onclick      !== void);
		d.clickse      = s.clickse       if (s.clickse      !== void);
		d.clicksebuf   = +s.clicksebuf   if (s.clicksebuf   !== void);
		d.clickstorage = s.clickstorage  if (s.clickstorage !== void);
		d.clicktarget  = s.clicktarget   if (s.clicktarget  !== void);

		d.onrclick     = s.onrclick      if (s.onrclick     !== void);
		d.rclickse     = s.rclickse      if (s.rclickse     !== void);
		d.rclicksebuf  = +s.rclicksebuf  if (s.rclicksebuf  !== void);
		d.rclickstorage= s.rclickstorage if (s.rclickstorage!== void);
		d.rclicktarget = s.rclicktarget  if (s.rclicktarget !== void);

		d.onmclick     = s.onmclick      if (s.onmclick     !== void);
		d.mclickse     = s.mclickse      if (s.mclickse     !== void);
		d.mclicksebuf  = +s.mclicksebuf  if (s.mclicksebuf  !== void);
		d.mclickstorage= s.mclickstorage if (s.mclickstorage!== void);
		d.mclicktarget = s.mclicktarget  if (s.mclicktarget !== void);

		d.onrelease    = s.onrelease     if (s.onrelease    !== void);
		d.releasese    = s.releasese     if (s.releasese    !== void);
		d.releasesebuf = +s.releasesebuf if (s.releasesebuf !== void);
		d.releasestorage=s.releasestorage if(s.releasestorage!==void);
		d.releasetarget= s.releasetarget if (s.releasetarget!== void);

		d.onrrelease   = s.onrrelease    if (s.onrrelease   !== void);
		d.rreleasese   = s.rreleasese    if (s.rreleasese    !== void);
		d.rreleasesebuf= +s.rreleasesebuf if(s.rreleasesebuf !== void);
		d.rreleasestorage=s.rreleasestorage if(s.rreleasestorage!==void);
		d.rreleasetarget=s.rreleasetarget if(s.rreleasetarget!== void);

		d.onmrelease   = s.onmrelease    if (s.onmrelease   !== void);
		d.mreleasese   = s.mreleasese    if (s.mreleasese    !== void);
		d.mreleasesebuf= +s.mreleasesebuf if(s.mreleasesebuf !== void);
		d.mreleasestorage=s.mreleasestorage if(s.mreleasestorage!==void);
		d.mreleasetarget=s.mreleasetarget if(s.mreleasetarget!== void);

		d.onenter      = s.onenter       if (s.onenter      !== void);
		d.enterse      = s.enterse       if (s.enterse      !== void);
		d.entersebuf   = +s.entersebuf   if (s.entersebuf   !== void);
		d.enterstorage = s.enterstorage  if (s.enterstorage !== void);
		d.entertarget  = s.entertarget   if (s.entertarget  !== void);

		d.onleave      = s.onleave       if (s.onleave      !== void);
		d.leavese      = s.leavese       if (s.leavese      !== void);
		d.leavesebuf   = +s.leavesebuf   if (s.leavesebuf   !== void);
		d.leavestorage = s.leavestorage  if (s.leavestorage !== void);
		d.leavetarget  = s.leavetarget   if (s.leavetarget  !== void);

		d.clickablemb  = s.clickablemb   if (s.clickablemb  !== void);
		d.ncaction     = +s.ncaction     if (s.ncaction     !== void);

		if (typeof(s.repeattimer) != 'undefined') {
			if (typeof(d.repeattimer) == 'undefined')
				d.repeattimer = %[];
			d.repeattimer.interval = s.repeattimer.interval;
			d.repeattimer.enabled  = s.repeattimer.enabled;
		}
	}

	// これ以下の全てのメンバをコピーする
	function copyAllMembers(dst, src)
	{
		super.copyAllMembers(dst, src);
		.KClickableLayer.copyLocalMembers(dst, src);
	}

	// オプションを設定
	function setOptions(elm)
	{
		if (elm === void)
			return;
		if (elm.exp !== void)	// onreleaseはexpと全く同じ
			elm.onrelease = elm.exp;
		if (elm.storage !== void)
			elm.releasestorage = elm.storage;
		if (elm.target !== void)
			elm.releasetarget = elm.target;

		// 親レイヤにオプション指定
		super.setOptions(elm);
		.KClickableLayer.copyLocalMembers(this, elm);

		// *storage/*targetのみが指定されたら、*target/*storageをvoidに
		if (elm.clickstorage   !== void && elm.clicktarget   === void)
			clicktarget    = void;
		if (elm.clickstorage   === void && elm.clicktarget   !== void)
			clickstorage   = void;
		if (elm.releasestorage !== void && elm.releasetarget === void)
			releasetarget  = void;
		if (elm.releasestorage === void && elm.releasetarget !== void)
			releasestorage = void;
		if (elm.enterstorage   !== void && elm.entertarget   === void)
			entertarget    = void;
		if (elm.enterstorage   === void && elm.entertarget   !== void)
			enterstorage   = void;
		if (elm.leavestorage   !== void && elm.leavetarget   === void)
			leavetarget    = void;
		if (elm.leavestorage   === void && elm.leavetarget   !== void)
			leavestorage   = void;
	}

	// 現在のマウスボタンがclickと判断可能かどうか
	function isMbClickable(mb)
	{
		if (mb === void) {
			if (System.getKeyState(VK_LBUTTON))
				return (mbclickable|VK_LBUTTON);
			if (System.getKeyState(VK_RBUTTON))
				return (mbclickable|VK_RBUTTON);
			if (System.getKeyState(VK_MBUTTON))
				return (mbclickable|VK_MBUTTON);
		}
		return ((mb == mbLeft   && (clickablemb&VK_LBUTTON)) ||
			(mb == mbRight  && (clickablemb&VK_RBUTTON)) ||
			(mb == mbMiddle && (clickablemb&VK_MBUTTON)));
	}

	// (ボタンクリック時などの)サウンドを鳴らす。
	function playSound(sndfile, buf = 0)
	{
		if (sndfile === void || sndfile == "")
			return;
		kag.se[buf].play(%[storage:sndfile]);
	}

	// KAGのシナリオジャンプ
	function jumpSenario(storage, target, countpage)
	{
		if (storage !== void || target !== void)
			window.process(storage, target, countpage); 
	}

	// マウスが押された場合
	function onMouseDown(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		// super/親のonMouseDown()を呼ぶと最終的にonPrimaryClickに
		// なるので呼ばない

		// ボタンごとに別々に指定の動作をさせる
		if (button == mbLeft) {
			if (!(clickablemb & VK_LBUTTON)) {
				if (ncaction == NCACTION_SENDPARENT)
					parent.onMouseDown(x+left,y+top,button,shift);
				return;
			}
			playSound(clickse, clicksebuf);
			eval(onclick);	// void チェックはこの中で
			jumpSenario(clickstorage, clicktarget, countpage);
		} else if (button == mbRight) {
			if (!(clickablemb & VK_RBUTTON)) {
				if (ncaction == NCACTION_SENDPARENT)
					parent.onMouseDown(x+left,y+top,button,shift);
				return;
			}
			playSound(rclickse, rclicksebuf);
			eval(onrclick);	// void チェックはこの中で
			jumpSenario(rclickstorage, rclicktarget, countpage);
		} else /* if (button == mbMiddle) */ {
			if (!(clickablemb & VK_MBUTTON)) {
				if (ncaction == NCACTION_SENDPARENT)
					parent.onMouseDown(x+left,y+top,button,shift);
				return;
			}
			playSound(mclickse, mclicksebuf);
			eval(onmclick);	// void チェックはこの中で
			jumpSenario(mclickstorage, mclicktarget, countpage);
		}
		// ここにきたときはボタン押されていること確定
		if (repeatable) {
			repeattimer.enabled  = true;
			repeatbutton = button;
		}
	}

	// マウス押されっぱなしの時のリピート関数
	function onMouseDownRepeat()
	{
		onMouseDown(cursorX, cursorY, repeatbutton, 0);
		repeattimer.interval = repeatinterval2;
	}

	// マウスが放された場合
	function onMouseUp(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		repeattimer.enabled  = false;
		repeattimer.interval = repeatinterval1;

//		super.onMouseUp(...); // parent.onMouseUp()を実行しないように

		// ボタンごとに別々に指定の動作をさせる
		if (button == mbLeft) {
			if (!(clickablemb & VK_LBUTTON)) {
				if (ncaction == NCACTION_SENDPARENT)
					parent.onMouseUp(x+left,y+top,button,shift);
				return;
			}
			playSound(releasese, releasesebuf);
			eval(onrelease);	// void チェックはこの中で
			// 「タイトルに戻る」の時はここでreturnしないとエラーに
			// なっちゃうけど…どうしよ。
			jumpSenario(releasestorage, releasetarget, countpage);
		} else if (button == mbRight) {
			if (!(clickablemb & VK_RBUTTON)) {
				if (ncaction == NCACTION_SENDPARENT)
					parent.onMouseUp(x+left,y+top,button,shift);
				return;
			}
			playSound(rreleasese, rreleasesebuf);
			eval(onrrelease);	// void チェックはこの中で
			jumpSenario(rreleasestorage, rreleasetarget,countpage);
		} else /* if (button == mbMiddle) */ {
			if (!(clickablemb & VK_MBUTTON)) {
				if (ncaction == NCACTION_SENDPARENT)
					parent.onMouseUp(x+left,y+top,button,shift);
				return;
			}
			playSound(mreleasese, mreleasesebuf);
			eval(onmrelease);	// void チェックはこの中で
			jumpSenario(mreleasestorage, mreleasetarget,countpage);
		}
	}

//	// なんでこっちでなくonMouseDown()使ってるんだっけ…。今は何もしない
//	// onClick()はmouseUp時に動くから、だったかなぁ。
//	function onClick()
//	{
//		super.onClick(...);
//	}

	// マウスが入った時
	function onMouseEnter()
	{
		super.onMouseEnter(...);
		playSound(enterse, entersebuf);
		eval(onenter);	// void チェックはこの中で
		jumpSenario(enterstorage, entertarget, countpage);
	}

	// マウスが出た時
	function onMouseLeave()
	{
		super.onMouseLeave(...);
		window.focusedLayer = null;

		playSound(leavese, leavesebuf);
		eval(onleave);	// void チェックはこの中で
		jumpSenario(leavestorage, leavetarget, countpage);
	}

	// フォーカスされた時
	function onFocus(focused, direction)
	{
		super.onFocus(...); // parent.onMouseUp()を実行しないように
		// マウス押された時も改めてフォーカスされるので、それは省く
		if (0 <= cursorX && cursorX < width &&
		    0 <= cursorY && cursorY < height)
			return;
		// キーが押された時のみフォーカスするので、そうでなければ省く
		var gks = window.getKeyState;
		if (!gks(VK_LEFT) && !gks(VK_UP) && !gks(VK_RIGHT) &&
		    !gks(VK_DOWN) && !gks(VK_TAB))
			return;

		// マウスを自身の中心に移動する。これでonMouseEnterの画像になる
		setCursorPos(width\2, height\2);
	}

	// キーが押された時(animbuttonでまだうまく動いてない)
	function onKeyDown(key, shift, process)
	{
		if (process && (key == VK_RETURN || key == VK_SPACE)) {
			// スペースキーまたはエンターキーが押されたら
			// 中央でmouseが押されたことにする
			onMouseDown(width\2, height\2, mbLeft, shift);
			super.onKeyDown(key, shift, false);
		} else {
			super.onKeyDown(...);
		}
	}

	// キーが放された時(animbuttonでまだうまく動いてない)
	function onKeyUp(key, shift, process)
	{
		if (process && (key == VK_RETURN || key == VK_SPACE)) {
			// スペースキーまたはエンターキーが押されたら
			// 中央でmouseが離されたことにする
			onMouseUp(width\2, height\2, mbLeft, shift);
			super.onKeyUp(key, shift, false);
		} else {
			super.onKeyUp(...);
		}
	}

	// レイヤーのコピー
	function assign(src)
	{
		super.assign(src);
		.KClickableLayer.copyLocalMembers(this, src);
	}

	// セーブ時に上から呼ばれる
	function store()
	{
		var dic = super.store();
		.KClickableLayer.copyLocalMembers(dic, this);
		return dic;
	}

	// ロード時に上から呼ばれる
	function restore(dic)
	{
		if (dic === void)
			return;
		.KClickableLayer.setOptions(dic);
		return dic;
	}
}


// ボタン群の共通レイヤ
// 0.99から、文字の時と画像の時とで区別しないようになり、Butt_imageLoaded削除
class KButtonLayer extends KClickableLayer
{
	var classid 		= "KButtonLayer";// 定数

	var Butt_mouseOn    = false;		// レイヤ内にマウスがあるか
	var Butt_mouseDown  = false;		// マウスボタンが押されているか
//	var color           = 0xff404040;	// 既に存在するから不要
	var entercolor      = 0xff909090;	// マウスが入った時の色
	var clickcolor      = 0xffd0d0d0;	// マウスがクリックされた時の色
	var disablecolor    = 0x80606060;	// 押せない時の色
	var Butt_keyPressed = false;	// キーが押されているかどうかの状態

//	var kfont;		定義済み	// 通常時のフォント
	var enterfont;				// マウスオン時のフォント
	var clickfont;				// クリック時のフォント
	var disablefont;			// 無効時のフォント

	var normalgraphic;			// マウスが乗っていない時の画像
	var clickgraphic;			// マウスが押された時の画像
	var entergraphic;			// マウスが乗った時の画像
	var disablegraphic;			// 無効時の画像

	// コンストラクタ
	function KButtonLayer(win, parent, i_name, elm)
	{
		super.KClickableLayer(win, parent, i_name);

//		kfont       = new KFont();	// 定義済み
		enterfont   = new KFont();	// 先にオプション設定しとく
		clickfont   = new KFont();
		disablefont = new KFont();

		setDefaultFont(elm);
		setOptions(elm);
	}

	// 色とフォント設定用(コンストラクタからのみ呼ばれる)
	function setDefaultFont(elm)
	{
		kfont.setOptions(elm.kfont) if (elm !== void);
		// ほかのフォントはデフォルトでkfontと同じにする
		enterfont  .assign(kfont);
		clickfont  .assign(kfont);
		disablefont.assign(kfont);

		// デフォルトではフォントは全て同じ、disableだけちょっと暗い
		var c = +kfont.color;
		c = (c&0xfe0000)/2 + (c&0x00fe00)/2 + (c&0x0000fe)/2;
		disablefont.setOptions(%[color:c]);
	}

	// デストラクタ
	function finalize()
	{
		invalidate enterfont;
		invalidate clickfont;
		invalidate disablefont;
		super.finalize(...);
	}

	// このレイヤローカルのメンバをコピー
	function copyLocalMembers(d, s)
	{
		if (d === void || s === void)
			return;

		d.Butt_mouseOn  = +s.Butt_mouseOn if (s.Butt_mouseOn !== void);
		d.Butt_mouseDown=+s.Butt_mouseDown if(s.Butt_mouseDown!==void);

		// ここから色設定
		if (s.color !== void)
			d.color = d.entercolor = d.clickcolor = d.disablecolor = +s.color;
		d.color         = +s.normalcolor  if (s.normalcolor  !== void);
		d.entercolor    = +s.entercolor   if (s.entercolor   !== void);
		d.clickcolor    = +s.clickcolor   if (s.clickcolor   !== void);
		d.disablecolor  = +s.disablecolor if (s.disablecolor !== void);
		d.normalgraphic = s.normalgraphic if (s.normalgraphic!== void);
		d.clickgraphic  = s.clickgraphic  if (s.clickgraphic !== void);
		d.entergraphic  = s.entergraphic  if (s.entergraphic !== void);
		d.disablegraphic= s.disablegraphic if(s.disablegraphic!==void);
//colorと同じなので不要	d.normalcolor = s.normalcolor if(s.normalcolor!==void);

		// ここからフォント設定
//不要		d.kfont       = %[] if (d.kfont       === void);
		d.enterfont   = %[] if (d.enterfont   === void);
		d.clickfont   = %[] if (d.clickfont   === void);
		d.disablefont = %[] if (d.disablefont === void);
		if (s.kfont !== void) {
			.KFont.copyLocalMembers(d.enterfont,   s.kfont);
			.KFont.copyLocalMembers(d.clickfont,   s.kfont);
			.KFont.copyLocalMembers(d.disablefont, s.kfont);
		}
		.KFont.copyLocalMembers(d.kfont,       s.normalfont);
		.KFont.copyLocalMembers(d.enterfont,   s.enterfont);
		.KFont.copyLocalMembers(d.clickfont,   s.clickfont);
		.KFont.copyLocalMembers(d.disablefont, s.disablefont);
	}

	// このレイヤ以下の全てのメンバをコピ
	function copyAllMembers(dst, src)
	{
		super.copyAllMembers(dst, src);
		.KButtonLayer.copyLocalMembers(dst, src);
	}

	// オプションを設定
	function setOptions(elm)
	{
		if (elm === void)
			return;
		super.setOptions(elm);
		.KButtonLayer.copyLocalMembers(this, elm);
		redraw();
	}

	// graphicのないボタンを一つだけ描く(縦横幅は既に決まっているとする)
	function drawButtonWithoutGraphic_one(xidx, rugged, color, font, text)
	{
		fillRect(width*xidx, 0, width, height, color);
		if (rugged == true || rugged == false)    // enabled!=t/fでは
			drawRuggedness(rugged,  width*xidx); //ruggedを描かない
		drawTextWithAlign(font, text, width*xidx, 0);
	}

	// graphicのないボタンを描く
	function drawButtonWithoutGraphic()
	{
		var w = width, h = height;
		setImagePos(0, 0);
		setSize(w, h);
		setImageSize(w * 3, h);

		if (enabled)
			drawButtonWithoutGraphic_one(0, true, normalcolor,  normalfont,  text);
		else			//この値はt/fで↓なければなんでもよい
			drawButtonWithoutGraphic_one(0, -100, disablecolor, disablefont, text);
		drawButtonWithoutGraphic_one(1, false, clickcolor,  clickfont,  text);
		drawButtonWithoutGraphic_one(2, true,  entercolor,  enterfont,  text);
	}

	// ボタンを描く
	function redraw()
	{
		drawButton();
	}

	// ボタンを描く
	function drawButton()
	{
		// これで画像があろうがなかろうがボタンが描画される
		.KButtonLayer.loadImages();
	}

	// ボタン画像を読み込む... 部分画像を読み込み、配置する
	function loadSubImage(g, key=graphickey, widx, widthfixed, wsiz=1)
	{
		if (g === void)
			return widthfixed;
		var l = new .Layer(window, parent);
		l.loadImages(g, (key === void) ? void : +key);
		if (!widthfixed) {
			setImagePos(0, 0);
			setSize(l.imageWidth\wsiz, l.imageHeight);
			setImageSize((l.imageWidth\wsiz) * 3, l.imageHeight);
			drawButtonWithoutGraphic();
		}
		copyRect(widx*width, 0, l, 0, 0, l.imageWidth, l.imageHeight);
		invalidate l;
		// 読み込んだ画像上にフォントで文字を描画
		if (widx == 0) {
			var f = (enabled) ? normalfont : disablefont;
			drawTextWithAlign(f, text, 0);
			widx++;
		}
		for (var i = widx; i < widx+wsiz; i++) {
			var f = [normalfont, clickfont, enterfont][i];
			drawTextWithAlign(f, text, width*i);
		}
		return true;
	}

	// 画像を読み込む
	function loadImages(g=graphic, key=graphickey, ng=normalgraphic, cg=clickgraphic, eg=entergraphic, dg=disablegraphic)
	{
		var wflg = false;
		// 最初に画像なし状態にしておく
		discardImage();
		graphic        = (g   == "") ? void : g   if (g   !== void);
		normalgraphic  = (ng  == "") ? void : ng  if (ng  !== void);
		clickgraphic   = (cg  == "") ? void : cg  if (cg  !== void);
		entergraphic   = (eg  == "") ? void : eg  if (eg  !== void);
		disablegraphic = (dg  == "") ? void : dg  if (dg  !== void);
		graphickey     = (key == "") ? void : key if (key !== void);

		// graphicだけは横幅が違うので特別扱い
		wflg = loadSubImage(graphic,        , 0, wflg, 3);
		wflg = loadSubImage(normalgraphic,  , 0, wflg);
		wflg = loadSubImage(clickgraphic,   , 1, wflg);
		wflg = loadSubImage(entergraphic,   , 2, wflg);
		wflg = loadSubImage(disablegraphic, , 0, wflg) if (!enabled);

		if (!wflg) {
			// 画像が指定されていなかったらテキスト表示して終わり
			drawButtonWithoutGraphic();
			return;
		}
	}

	// 画像を破棄する
	function discardImage()
	{
		super.discardImage();
		drawButtonWithoutGraphic();
	}

	// マウスが押された場合
	function onMouseDown(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		if (isMbClickable(button)) {
			Butt_mouseDown = true;
			update();
		}
		super.onMouseDown(...);
	}

	// マウスが放された場合
	function onMouseUp(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		if (isMbClickable(button)) {
			Butt_mouseDown = false;
			update();
		}
		super.onMouseUp(...);
	}

	// なんでこっちでなくonMouseDown()使ってるんだっけ…。今は何もしない
	// onClick()はmouseUp時に動くから、だったかなぁ。
//	function onClick()
//	{
//		super.onClick(...);
//	}

	// 現在の状態にあわせて描画を行う
	function drawState()
	{
		if(!enabled)
			imageLeft = 0 * width;	// 無効状態が既に描画されている
		else if (Butt_mouseDown)
			imageLeft = -1 * width;	// マウス押された状態
		else if (Butt_mouseOn)
			imageLeft = -2 * width;	// マウスが乗った状態
		else 
			imageLeft = 0 * width;	// マウス乗っていない状態
	}

	// 描画の直前に呼ばれる
	function onPaint()
	{
		super.onPaint(...);
		drawState();
	}

	// マウスが入った時
	function onMouseEnter()
	{
		Butt_mouseOn = true;
		update();
		super.onMouseEnter(...);
	}

	// マウスが出た時
	function onMouseLeave()
	{
		Butt_mouseOn = false;
		Butt_mouseDown = false;
		update();
		super.onMouseLeave(...);
	}

	// レイヤのノードが不可になった
	function onNodeDisabled()
	{
		super.onNodeDisabled(...);
		Butt_mouseDown = false;
		update();
	}

	// レイヤのノードが有効になった
	function onNodeEnabled()
	{
		super.onNodeEnabled(...);
		update();
	}

	// キーが押された時(animbuttonでまだうまく動いてない)
	function onKeyDown(key, shift, process)
	{
		if (process && (key == VK_RETURN || key == VK_SPACE))
			Butt_keyPressed = true;
		super.onKeyDown(...);
	}

	// キーが放された時(animbuttonでまだうまく動いてない)
	function onKeyUp(key, shift, process)
	{
		if (process && (key == VK_RETURN || key == VK_SPACE))
			Butt_keyPressed = false;
		super.onKeyUp(...);
	}

/*親メンバにある名前でpropertyは作れないらしい…。くそう。
	property text
	{
		setter(x) {
			super.text = x;
			loadImages();	// 再描画する
		}
		getter {
			var ret = super.text;
			return ret; // なぜかここでエラーになる
		}
	}
行頭に*を配置しない  */

/*
//width/heightを変更するとグラフィックが無効になるのは結構辛いので使用しない
	property width
	{
		setter(x) {
			if (super.width == x)	// 同じなら何もしない
				return;

			super.width = 1;
			imageWidth = x * 3;
			super.width = x;

			// widthが指定されたら、それは画像を全部削除する合図！
			graphic        = void;
			normalgraphic  = void;
			clickgraphic   = void;
			entergraphic   = void;
			disablegraphic = void;
			drawButtonWithoutGraphic();	// ここで再描画する
		}
		getter {
			return super.width;
		}
	}

	property height
	{
		setter(y) {
			if (super.height == y)	// 同じなら何もしない
				return;

			super.height = 1;
			imageHeight = y;
			super.height = y;

			// heightが指定されたら、それは画像を全部削除する合図！
			graphic        = void;
			normalgraphic  = void;
			clickgraphic   = void;
			entergraphic   = void;
			disablegraphic = void;
			drawButtonWithoutGraphic();	// ここで再描画する
		}
		getter {
			return super.height;
		}
	}
行頭に*を配置しない  */

	property enabled
	{
		setter(x) {
			if (super.enabled == x)	// 同じなら何もしない
				return;
			super.enabled = x;
			drawButton();	// 設定値が違ったら描き直す
		}
		getter {
			return super.enabled;
		}
	}

	// normalcolorというメンバを作るためだけに、プロパティ作成
	property normalcolor
	{
		setter(x) {
			color = x;
		}
		getter {
			return color;
		}
	}

	// normalfontというメンバを作るためだけに、プロパティ作成
	property normalfont
	{
		setter(x) {
			kfont.assign(x);
		}
		getter {
			return kfont;
		}
	}

	// ボタンのコピー
	function assign(src)
	{
		super.assign(src);
		.KButtonLayer.copyLocalMembers(this, src);
		Butt_mouseOn = false;
		// ↑トランジション前後で、KRadioButtonItemのButt_mouseOnが
		// マウスはレイヤ外に出てるのにtrueのままになることがあったので
		// ここでButt_mouseOnを強制的にfalseにする。他にカッコいい直し
		// 方、ないかしらん
	}

	// セーブ時に上から呼ばれる
	function store()
	{
		var dic = super.store();
		.KButtonLayer.copyLocalMembers(dic, this);
		return dic;
	}

	// ロード時に上から呼ばれる
	function restore(dic)
	{
		if (dic === void)
			return;
		.KButtonLayer.setOptions(dic);
		return dic;
	}
}


// アニメーションつきリンクボタンレイヤ(AnimationButtonLayerの焼き直し)
class KAnimButtonLayer extends KButtonLayer
{
	var classid    = "KAnimButtonLayer";	// 定数
	// アニメーションボタンの追加部分
	var conductor;		// アニメーションのコンダクタ
	var maxpatternnum = 1;	// 現在のアニメーションセル最大数

	// コンストラクタ
	function KAnimButtonLayer(win, parent, i_name, elm)
	{
		conductor = new AnimationConductor(this);
		super.KButtonLayer(win, parent, i_name);
		setDefaultFont(elm);	// KButtonLayerのを呼ぶ
		setOptions(elm);
	}

	// デストラクタ
	function finalize()
	{
		stopAnim();
		super.finalize(...);
		// 最後に invalidate した方が、stopAnim()でエラー出ない
		invalidate conductor;
	}

	// このレイヤローカルのメンバをコピー
	function copyLocalMembers(dst, src)
	{
		if (dst === void || src === void)
			return;
		// conductorは loadImages()で読まれるので不要だが複製
		if (dst.conductor === void)
			dst.conductor = %[];
		if (dst.conductor instanceof "AnimationConductor") {
			if (src.conductor !== void)
				if (src.conductor instanceof "AnimationConductor")
					dst.conductor.assign(src.conductor);
				else {
				// 以下は吉里吉里のバグだけど、やっとかないと
				// 「ハードウェアエラーが発生しました」になる
					if (src.conductor.storageName != "")
						dst.conductor.restore(src.conductor);
					else {
						invalidate dst.conductor;
						dst.conductor = new AnimationConductor(this);
					}
				}
		} else { // dst=Dictionary
			if (src.conductor !== void)
				if (src.conductor instanceof "AnimationConductor")
					dst.conductor = src.conductor.store();
				else
					(Dictonary.assign incontextof dst.conductor)(src.conductor);
		}
		if (src.maxpatternnum !== void)
			dst.maxpatternnum = src.maxpatternnum;
	}

	// このレイヤ以下の全てのメンバをコピー
	function copyAllMembers(dst, src)
	{
		super.copyAllMembers(dst, src);
		.KAnimButtonLayer.copyLocalMembers(dst, src);
	}

	// オプションを設定
	function setOptions(elm)
	{
		if (elm === void)
			return;
		super.setOptions(elm);
		.KAnimButtonLayer.copyLocalMembers(this, elm);
		// loadImages() の後に height だけ設定する
		height = +elm.height if (elm.height !== void);
		redraw();
	}

	// アニメーションを停止する
	function stopAnim(resetidx=true)
	{
//いらんのでは？if (conductor !== void)	// 派生クラスからloadImages()の時void
			conductor.stop();
		imageTop = 0 if (resetidx);
	}

	// アニメーション情報ファイルを読み込む
	function loadAnimInfo(graphic)
	{
		startAnim(Storages.chopStorageExt(graphic)+".bsd", "");
	}

	// アニメーションを開始する
	function startAnim(storage=conductor.curStorage, label)
	{
		stopAnim(false);	// idxはリセットしない
		if (storage !== void && storage != "" && 
		    Storages.isExistentStorage(storage)) {
			// アニメーション定義ファイルが存在した
			conductor.startLabel = label;
			conductor.stopping = false;
			conductor.running = true;
			conductor.clearCallStack();
//			conductor.interrupted = Anim_interrupted;
			conductor.loadScenario(storage);
			conductor.goToLabel(label);
			conductor.startProcess(true);
		}
	}

	// イメージを読み込む。この後に適当な height に調整すること
	function loadImages(g, key, kg, ng, cg, eg, dg, newheight)
	{
		stopAnim();
// ToDo: これがあると slidertabが無効化されてしまう…原因不明、後で追求すること
//		.KAnimButtonLayer.discardImage();
		super.loadImages(g, key, kg, ng, cg, eg, dg);
		if (newheight !== void)
			height = newheight;
		maxpatternnum = imageHeight \ height;
		// アニメーション情報があれば読む
		loadAnimInfo(graphic);
	}

	// イメージを破棄する
	function discardImage()
	{
		stopAnim();
		super.discardImage();
		maxpatternnum = 1;
	}

	// クリック時の動作
	function onMouseDown(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		startAnim(, '*onclick');	// "*onclick"からアニメ開始
		super.onMouseDown(...);
	}

	// マウスが放された場合
	function onMouseUp(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		startAnim(, '*onenter');
		super.onMouseUp(...);
	}

	// マウスが入った時
	function onMouseEnter()
	{
//dm('onMouseEnter on KAnimButton: ' + this);
		startAnim(, '*onenter');	// "*onenter"からアニメ開始
		super.onMouseEnter(...);
	}

	// マウスが出た時
	function onMouseLeave()
	{
//dm('onMouseLeave on KAnimButton: ' + this);
		startAnim(, '*normal');	// "*normal"からアニメ開始
		super.onMouseLeave(...);
	}

	// フォーカス(unclicked focus)された時
	function onFocus(focused, direction)
	{
//dm('onFocus on KAnimButton: ' + this);
		startAnim(, '*onenter');
		super.onFocus(...);
	}

	// フォーカス(unclicked focus)を失った時
	function onBlur()
	{
//dm('onBlur on KAnimButton: ' + this);
		startAnim(, '*normal');
		super.onBlur(...);
	}

	// ボタンのコピー
	function assign(src)
	{
		super.assign(src);
		.KAnimButtonLayer.copyLocalMembers(this, src);
	}


// ------ ここからアニメーション定義ファイル(.bsd)のタグハンドラ --------------
// 殆どKAnimLayerの.adf と同じなんだけど…うまく統合できなかったので。

	// いわゆる [s]
	function s(elm)
	{
		// 停止
		elm.context.running = false;
		return -1; // 停止
	}

	// タグハンドラ loadcell() は何もしない
	function loadcell()
	{
		// .bsd ファイルに存在した時にエラーにしないためのダミー
		return 0;
	}

	// 追加タグハンドラ pos(x, y)
	function pos(elm)
	{
		left    =  str2num(elm.x,      left);
		top     =  str2num(elm.y,       top);
		left    += str2num(elm.dx,        0);
		top     += str2num(elm.dy,        0);
		opacity =  str2num(elm.opa, opacity);
		opacity += str2num(elm.iopa,      0);
		return 0;
	}

	// 追加タグハンドラ size(w, h)
	function size(elm)
	{
		setSize(str2num(elm.w, width), str2num(elm.h, height));
		return 0;
	}

	// index 値の範囲を 0～max に正規化する
	function evalidx(cur, max)
	{
		var ret = cur%max;
		return (ret >= 0) ? ret : ret+max;
	}

	// dispタグ上書きハンドラ
	function disp(elm)
	{
//		var sx = str2num(elm.sx); // 横方向位置補正はスキップ
		var sy = str2num(elm.sy); // def=0(-imageLeftじゃない) に注意
//		if (elm.six !== void) {
//			var cursix = -imageLeft\width;
//			var idx = str2num(elm.six.replace(/six/, cursix));
//			sx = evalidx(idx, imageWidth\width) * width;
//		}
		if (elm.siy !== void) {
			var cursiy = -imageTop\height;
			var idx = str2num(elm.siy.replace(/siy/, cursiy));
			sy = evalidx(idx, imgeHeight\height) * height;
		}
		if (elm.index !== void) {
			var curidx = -imageTop\height;
			var idx = str2num(elm.index.replace(/index/, curidx));
			sy = evalidx(idx, imageHeight\height) * height;
		}
		setImagePos(imageLeft, -(sy));	// ここも横方向は変更しない
		return 0;
	}

	// タグハンドラ追加、loop
	function loop(elm)
	{
		// ループすることを宣言する
		// セグメントによってはループしたりしなかったりするため。
		elm.context.looping = true;
		return 0;
	}

	// タグハンドラ追加、noloop：loopの反対。
	function noloop(elm)
	{
		// ループを使わないことを宣言する
		// セグメントによってはループしたりしなかったりするため。
		elm.context.looping = false;
		return 0;
	}

	// タグハンドラ追加 wait
	function wait(elm)
	{
		return elm.time; // 指定時間だけ停止
	}

// ------ ここからロード・セーブ ----------------------------------------

	// セーブ時に上から呼ばれる
	function store()
	{
		var dic = super.store();
		.KAnimButtonLayer.copyLocalMembers(dic, this);
		return dic;
	}

	// ロード時に上から呼ばれる
	function restore(dic)
	{
		stopAnim();
		if (dic === void)
			return;
		.KAnimButtonLayer.setOptions(dic);

/* 以前の
		super.restore(dic);	// この中で setOptions(dic) を実行する
		// 以下は吉里吉里のバグだと思うけど、やっとかないと
		// 「ハードウェアエラーが発生しました」になってしまう…。
		if (dic.conductor.storageName != "")
			conductor.restore(dic.conductor);
		else {
			invalidate conductor;
			conductor = new AnimationConductor(this);
		}
行頭に*を配置しない  */
		return dic;
	}
}


// トグルボタンレイヤー
// released/checked/checkedonmouseの三状態を表す
class KToggleButtonLayer extends KAnimButtonLayer
{
	var classid = "KToggleButtonLayer";

	// oncheck/onuncheckは、onMouseUp()の時に実行される。onMouseDown()で
	// 実行すると、Window/FullScreen 切り替えをさせると onMouseUp()イベント
	// が発生せず、切り替え後にボタンステータスがおかしくなるため。
	// 吉里吉里のバグだと思う…。

	var checked = false;	// チェックされているかどうか
	var oncheck;		// check された時に呼ばれる TJS 関数
	var checkse;		// check された時に鳴らす音
	var checksebuf = 0;	// 押された時に鳴らす音のバッファ
	var checkstorage;	// check された時に呼ばれる KAG ストレージ
	var checktarget;	// check された時に呼ばれる KAG target
	var onuncheck;		// uncheck された時に呼ばれる TJS 関数
	var uncheckse;		// check された時に鳴らす音
	var unchecksebuf = 0;	// 押された時に鳴らす音のバッファ
	var uncheckstorage;	// uncheck の時に呼ばれる KAG ストレージ
	var unchecktarget;	// uncheck の時に呼ばれる KAG target
	var stateval;		// check状態を保存する変数を文字列で指定する

	// コンストラクタ
	function KToggleButtonLayer(window, parent, name, elm)
	{
		super.KAnimButtonLayer(window, parent, name);
		setDefaultFont(elm);	// KButtonLayerのを呼ぶ
		setOptions(elm);
	}

	// デストラクタ
	function finalize()
	{
		super.finalize();
	}

	// このレイヤローカルのメンバをコピー
	function copyLocalMembers(d, s)
	{
		if (d === void || s === void)
			return;
		d.checked      = +s.checked     if (s.checked      !== void);
		d.oncheck      = s.oncheck      if (s.oncheck      !== void);
		d.checkse      = s.checkse      if (s.checkse      !== void);
		d.checksebuf   = +s.checksebuf  if (s.checksebuf   !== void);
		d.checkstorage = s.checkstorage if (s.checkstorage !== void);
		d.checktarget  = s.checktarget  if (s.checktarget  !== void);

		d.onuncheck    = s.onuncheck    if (s.onuncheck    !== void);
		d.uncheckse    = s.uncheckse    if (s.uncheckse    !== void);
		d.unchecksebuf = +s.unchecksebuf if(s.unchecksebuf !== void);
		d.uncheckstorage=s.uncheckstorage if(s.uncheckstorage!==void);
		d.unchecktarget = s.unchecktarget if(s.unchecktarget!==void);
		d.stateval     = s.stateval      if (s.stateval    !== void);
	}

	// このレイヤの全てのメンバをコピー
	function copyAllMembers(dst, src)
	{
		super.copyAllMembers(dst, drc);
		.KToggleButtonLayer.copyLocalMembers(dst, drc);
	}

	// オプション設定
	function setOptions(elm)
	{
		if (elm === void)
			return;
		var e = %[];
		(Dictionary.assign incontextof e)(elm);
		// exp,storage,targetはoncheckに対するものなので設定
		if (e.exp !== void)
			e.oncheck = e.exp, delete e.exp;
		if (e.storage !== void)
			e.checkstorage = e.storage, delete e.storage;
		if (e.target !== void)
			e.checktarget = e.target, delete e.target;
		var c = e.checked;	// checkedは特別扱いする
		delete e.checked;
		if (e.stateval !== void)
			c = eval(e.stateval); // voidチェックしてるけどcのため
		super.setOptions(e);
		.KToggleButtonLayer.copyLocalMembers(this, e);

		// こうしないとgraphicと一緒に指定した時に領域外エラーになる
		if (c !== void && +c != checked)
			simpleStateChange(+c);
	}

	// 画像読み込み
	function loadImages(graphic, key)
	{
		if (graphic === void)
			return;
		super.loadImages(...);
	}

	// 状態を変更する(ボタン状態確認、音再生、スクリプト実行なし)
	function simpleStateChange(state)
	{
		state = +state;
		checked = state; // 強制チェック時にも呼ぶのでフラグon必要
		if (stateval !== void)
			eval(stateval + ' = ' + state);
		if (state)
			startAnim(, "*oncheck");
		else
			startAnim(, Butt_mouseOn ? "*onuncheck" : "*onenter");
		drawState();
	}

	// チェックされた時に呼ばれる(makeCheck()も兼ねる)
	function onCheck()
	{
		if (checked)	// 押されてた時は何もしない
			return;
		simpleStateChange(true);

		playSound(checkse, checksebuf);
		eval(oncheck);	// void チェックはこの中で
		jumpSenario(checkstorage, checktarget, countpage);
	}

	// チェックが解除された時に呼ばれる(makeCheck()も兼ねる)
	function onUncheck()
	{
		if (!checked)	// 押されてなかった時は何もしない
			return;
		simpleStateChange(false);

		playSound(uncheckse, unchecksebuf);
		eval(onuncheck);	// void チェックはこの中で
		jumpSenario(uncheckstorage, unchecktarget, countpage);
	}

	// マウスが押された時
	function onMouseDown(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		super.onMouseDown(...);
		// 表示状態だけ変更して checked のスクリプトは実行しない
	}

	// マウスが放された時
	function onMouseUp(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		super.onMouseUp(...);
		if (button != mbLeft) // 左クリック以外は無視
			return;
		if (!checked)
			onCheck();	// チェックされた
		else
			onUncheck();// チェック解除された
	}

	// マウスが入った時
	function onMouseEnter()
	{
		if (checked)
			startAnim(, "*onenter"); // チェック時のみ*onenter開始
		.KButtonLayer.onMouseEnter(...);
	}

	// マウスが出た時
	function onMouseLeave()
	{
		if (checked)
			startAnim(, "*oncheck");// チェック時のみ*oncheck開始
		.KButtonLayer.onMouseLeave(...);
	}

	// 現在の状態にあわせて描画を行う(onPaint()から呼ばれる)
	function drawState()
	{
		// check されてれば 1, checkでなければ 0
		if(!enabled)
			imageLeft = 0 * width;	// 無効状態は既に描画されている
		else if (checked || Butt_mouseDown)
			imageLeft = -1 * width;	// マウス押された状態
		else if (Butt_mouseOn)
			imageLeft = -2 * width;	// マウスが乗った状態
		else 
			imageLeft = 0 * width;	// マウス乗っていない状態
	}

	// ボタンのコピー
	function assign(src)
	{
		super.assign(src);
		.KToggleButtonLayer.copyLocalMembers(this, src);
	}

	// セーブ時に上から呼ばれる
	function store()
	{
		var dic = super.store();
		.KToggleButtonLayer.copyLocalMembers(dic, this);
		return dic;
	}

	// ロード時に上から呼ばれる
	function restore(dic)
	{
		if (dic === void)
			return;
		.KToggleButtonLayer.setOptions(dic);
//		super.restore(dic);	// この中で setOptions(dic) を実行する
		return dic;
	}
}


// チェックボックスの頭に貼るtogglebutton、親にイベントを送るようちょっと改造
class KCheckBoxTopLayer extends KToggleButtonLayer
{
	var classid = "KCheckBoxTopLayer";

	// コンストラクタ
	function KCheckBoxTopLayer(window, parent, name, elm)
	{
		super.KToggleButtonLayer(window, parent, name);
		focusable = false;	// これはフォーカスされない(親がされる)
		setDefaultFont(elm);	// KButtonLayerのを呼ぶ
		setOptions(elm);
	}

	// デストラクタ
	function finalize()
	{
		super.finalize();
	}

	// イメージ読み込み
	function loadImages()
	{
		super.loadImages(...);
		// 親のサイズを自分に合わせる
		parent.setSize(width, height);
	}

	// チェックされた時に呼ばれる(makeCheck()も兼ねる)
	function onCheck()
	{
		super.onCheck(...);
//		parent.onCheck(...);	// 親にはこの関数作ってない
	}

	// チェックが解除された時に呼ばれる(makeCheck()も兼ねる)
	function onUncheck()
	{
		super.onUncheck(...);
//		parent.onUncheck(...);	// 親にはこの関数作ってない
	}

	// マウスが押された時
	function onMouseDown(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		super.onMouseDown(...);
		parent.onMouseDown(left+x, top+y, button, shift);// 親も呼ぶ
	}

	// マウスが放された時
	function onMouseUp(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		super.onMouseUp(...);
		parent.onMouseUp(left+x, top+y, button, shift);// 親も呼ぶ
	}

	// マウスが入った時
	function onMouseEnter()
	{
		super.onMouseEnter(...);
		parent.onMouseEnter(...);	// 親も呼ぶ
	}

	// マウスが出た時
	function onMouseLeave()
	{
		super.onMouseLeave(...);
		parent.onMouseLeave(...);	// 親も呼ぶ
	}
}		


// チェックボックスレイヤー(実態はToggleButton + 背景)
class KCheckBoxLayer extends KAnimButtonLayer
{
	var classid    = "KCheckBoxLayer";	// 定数
	var toggle;		// トグルボタンレイヤ

	// コンストラクタ
	function KCheckBoxLayer(window, parent, name, elm)
	{
		super.KAnimButtonLayer(window, parent, name);
		toggle = new KCheckBoxTopLayer(window, this);
		setDefaultFont(elm);	// KButtonLayerのを呼ぶ
		setOptions(elm); // トグルと自身を設定するために別で呼ぶ
	}

	// デストラクタ
	function finalize()
	{
		invalidate toggle;
		super.finalize();
	}

	// このレイヤのローカルメンバをコピーする
	function copyLocalMembers(dst, src)
	{
		if (dst === void || src === void)
			return;
		.KCheckBoxTopLayer.copyLocalMembers(dst.toggle, src.toggle);
	}

	// このレイヤ以下の全てのメンバをコピーする
	function copyAllMembers(dst, src)
	{
		super.copyAllMembers(dst, src);
		.KCheckBoxLayer.copyLocalMembers(dst, src);
	}

	// オプション設定　ここではまだ toggle が定義されていないことがある
	function setOptions(elm)
	{
		if (elm === void)
			return;
		if (elm.toggle !== void) {
			// toggle が設定されていれば値を設定する(restore時)
			super.setOptions(elm);
			toggle.setOptions(elm.toggle) if (toggle !== void);
		} else {
			// 通常の setOptions() 時
			var e = %[
				left:elm.left, top:elm.top,
				width:elm.basewidth, height:elm.baseheight,
				graphic:elm.basegraphic, color:elm.basecolor
			];
			if (elm.basewidth === void && elm.width !== void)
				e.width = elm.width;
			if (elm.baseheight === void && elm.height !== void)
				e.height = elm.height;
			super.setOptions(e);
			(Dictionary.assign incontextof e)(elm);
			delete e.left;	// X/Y座標は0,0固定なので削除
			delete e.top;
			toggle.setOptions(e) if (toggle !== void);
		}
	}

	// ボタンを強制的に押す
	function makeCheck()
	{
		toggle.onCheck();
	}

	// ボタンを強制的に離す
	function makeUncheck()
	{
		toggle.onUncheck();
	}

	// マウスが押された時
	function onMouseDown(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		super.onMouseDown(...);
		if (button != mbLeft) // 左クリック以外は無視
			return;

		// onCheck()でクリックされるので、マウスが出てたらoffに
		if ((cursorX < 0 || width <= cursorX) ||
		    (cursorY < 0 || height <= cursorY))
			onMouseLeave();
	}

	// update するときに、base/toggleも updateする。
	function update()
	{
		toggle.update();
		super.update();
	}

	// ボタンのコピー
	function assign(src)
	{
		super.assign(src);
		toggle.assign(src.toggle);
	}

	// セーブ時に上から呼ばれる
	function store()
	{
		var dic = super.store();
		dic.toggle = toggle.store();
		return dic;
	}

	// ロード時に上から呼ばれる
	function restore(dic)
	{
		if (dic === void)
			return;
		super.restore(dic); // この中で setOptions(dic) を実行する
		toggle.restore(dic.toggle);
		return dic;
	}

	property checked {
		getter() {
			return toggle.checked;
		}
		setter(x) {
			if (x)
				toggle.onCheck();
			else
				toggle.onUncheck();
		}
	}
}


// スライダーレイヤで使うタブボタンレイヤー
// スライダーの一部なので、親からpos/sizeが変更されることに注意
class KSliderTabLayer extends KAnimButtonLayer
{
	var classid = "KSliderTabLayer";

	var dragging = false;	// ドラッグ中フラグ
	var dragbtn;		// ドラッグ中ボタン
	var clickx=0, clicky=0;	// クリックされた時の座標保存用

	// コンストラクタ
	function KSliderTabLayer(window, parent, elm)
	{
		super.KAnimButtonLayer(window, parent);
		setDefaultFont(elm);	// KButtonLayerのを呼ぶ
		setOptions(elm);
	}

	// デストラクタ
	function finalize()
	{
		super.finalize();
	}

	// マウスが押された時
	function onMouseDown(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		super.onMouseDown(...);
		if (button != mbLeft) // 左クリック以外は無視
			return;

		if (!enabled || button != mbLeft)
			dragging = false;
		else {
			dragging = true;
			dragbtn  = button;
			clickx = x;
			clicky = y;
		}
	}

	// マウスが放された時
	function onMouseUp(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		super.onMouseUp(...);
		dragging = false;
	}

	// マウスが動かされた時
	function onMouseMove(x, y, shift)
	{
		super.onMouseMove(...);
		if (!dragging)
			return;	// drag中でなければ終了
		// スライダがドラッグされた時は親のonSliderDragged()を呼ぶ
		parent.onSliderDragged(x, y, clickx, clicky, dragbtn, shift);
	}

	// キーが押された時
	function onKeyDown(key, shift, process)
	{
		parent.onKeyDown(...);	// 親を呼ぶ
	}

	// ボタンのコピー
	function assign(src)
	{
		super.assign(src);
		dragging = src.dragging;
		dragbtn  = src.dragbtn;
		clickx = src.clickx;
		clicky = src.clicky;
	}

	// セーブ時に上から呼ばれる(スーパークラスと同じなので不要)
//	function store()

	// ロード時に上から呼ばれる
	function restore(dic)
	{
		if (dic === void)
			return;
		super.restore(dic);	// この中で setOptions(dic) を実行する
		dragging = false;
		// dragbtn  = 0; 初期化しない
		clickx = clicky = 0;
		return dic;
	}
}


// スライダー(縦横両方ともドラッグ可能)、KClickableLayerの派生にしたい
class KSliderLayer extends KLayer
{
	var classid = "KSliderLayer";	// 定数
	var vval = 0.0;		// 縦の現在値(0～1.0)
	var hval = 0.0;		// 横の現在値(0～1.0)

	var vintflg = false;	// 垂直方向は整数値のみとるかどうか
	var vmin = 0, vmax = 1.0; // 垂直方向の最小値・最大値
	var vstep = 0;		// 縦の刻み幅(0で無段階)

	var hintflg = false;	// 水平方向は整数値のみとるかどうか
	var hmin = 0, hmax = 1.0; // 水平方向の最小値・最大値
	var hstep = 0;		// 横の刻み幅(0で無段階)

	var tab;		// スライダーのタブ部分レイヤ
	var timer;		// スライダータブ外を押した時のリピートタイマ
	var hdst, vdst;		// タブ外クリック時の自動移動時の目標場所

	var onchange;		// 変更された時に実行するTJSスクリプト
	var onchangefunc;	// 変更された時に実行するTJSスクリプト(関数)
	var onchangestorage;	// 変更された時に実行するKAGストレージ
	var onchangetarget;	// 変更された時に実行するKAGラベル

	// コンストラクタ
	function KSliderLayer(window, parent, i_name, elm)
	{
		super.KLayer(window, parent, i_name); // まだelmは設定しない
		var e = (elm !== void && elm.tab !== void) ? elm.tab : %[];
		tab = new KSliderTabLayer(window, this, e);

		hitThreshold = 0;	// 透明部分

		timer = new Timer(this, "onMouseDownRepeat");
		timer.interval = 100;
		timer.enabled = false;		// 最初は falseに

		// 縦横判断は vertical メンバを利用するので必須
		e = %[];
		(Dictionary.assign incontextof e)(elm) if (elm !== void);
		e.vertical = +e.vertical;	// 定義されてなかったらfalse

		setOptions(e);// updateState() はこの中で実行されるので不要
	}

	// デストラクタ
	function finalize()
	{
		timer.enabled = false;
		invalidate tab;
		invalidate timer;
		super.finalize(...);
	}

	// このレイヤローカルのメンバをコピー
	function copyLocalMembers(d, s)
	{
		if (d === void || s === void)
			return;
		d.vval         = +s.vval         if (s.vval         !== void);
		d.hval         = +s.hval         if (s.hval         !== void);

		d.hintflg      = +s.hintflg      if (s.hintflg      !== void);
		d.hmin         = +s.hmin	 if (s.hmin         !== void);
		d.hmax         = +s.hmax	 if (s.hmax         !== void);
		d.hstep        = +s.hstep        if (s.hstep        !== void);
		if (d.hintflg) {
			d.hval  = int(d.hval)  if (d.hval  !== void);
			d.hmin  = int(d.hmin)  if (d.hmin  !== void);
			d.hmax  = int(d.hmax)  if (d.hmax  !== void);
			d.hstep = int(d.hstep) if (d.hstep !== void);
		}

		d.vintflg      = +s.vintflg      if (s.vintflg      !== void);
		d.vmin         = +s.vmin	 if (s.vmin         !== void);
		d.vmax         = +s.vmax	 if (s.vmax         !== void);
		d.vstep        = +s.vstep        if (s.vstep        !== void);
		if (d.vintflg) {
			d.vval  = int(d.vval)  if (d.vval  !== void);
			d.vmin  = int(d.vmin)  if (d.vmin  !== void);
			d.vmax  = int(d.vmax)  if (d.vmax  !== void);
			d.vstep = int(d.vstep) if (d.vstep !== void);
		}

//		d.tab          = +s.tab          if (s.tab          !== void);
//		d.timer        = +s.timer        if (s.timer        !== void);
		d.hdst         = +s.hdst         if (s.hdst         !== void);
		d.vdst         = +s.vdst         if (s.vdst         !== void);

		d.onchange     = s.onchange      if (s.onchange     !== void);
		d.onchangefunc = s.onchangefunc  if (s.onchangefunc !== void);
		d.onchangestorage=+s.onchangestorage if(s.onchangestorage!==void);
		d.onchangetarget=+s.onchangetarget if(s.onchangetarget!==void);

		d.tab = %[] if (d.tab === void);
		.KSliderTabLayer.copyLocalMembers(d.tab, s.tab);

		// 本当はtimer.assing()した方がよいが、src/dstとも辞書だと不可
		if (typeof(s.timer) != 'undefined') {
			// Timerにはassignが無い
			d.timer = %[] if (typeof(d.timer) == 'undefined');
			d.timer.interval = s.timer.interval;
			d.timer.enabled  = s.timer.enabled;
		}
		// 最後に s[tab*]をtabに設定する
		var keyary = keys(s);
		var tabelm = %[];
		for (var i = keyary.count-1; i >= 0; i--)
			if (keyary[i].length > 3 &&
			    keyary[i].substr(0,3) == 'tab')
				tabelm[keyary[i].substr(3)] = s[keyary[i]];
		.KSliderTabLayer.copyLocalMembers(d.tab, tabelm);
	}

	// オプション設定
	function setOptions(elm)
	{
		if (elm === void)
			return;
		var e = %[];
		(Dictionary.assign incontextof e)(elm);
		if (e.basegraphic !== void)
			e.graphic = e.basegraphic;
		if (e.basecolor !== void)
			e.color = e.basecolor;
		// 以前と同じ値を設定する場合は無視させる。updateSliderTabPos()
		// でonchange/onchangefuncの無限ループを防ぐため
// 「以前と同じ値の時はスキップする仕組み」は、効率化のためにも必要。
// 後に全クラスにインプリすること。setOptions_sub()のような関数にしてもよい。
//		if (e.hval !== void && realeq(+e.hval, hval))
//			delete e.hval;
//		if (e.vval !== void && realeq(+e.vval, vval))
//			delete e.vval;

		super.setOptions(e);
		.KSliderLayer.copyLocalMembers(this, e);

		if (tab.graphic === void)
			if (vertical) {
				tab.left = 0;
				if (e.width !== void && tab.width > width)
					tab.setOptions(%[width : width]);
			} else {
				tab.top = 0;
				if (e.height !== void && tab.height > height)
					tab.setOptions(%[height : height]);
			}
		redraw();
	}

	// 表示されているものをもう一度描く
	function redraw()
	{
		super.redraw();	// KLayerのredraw()を呼ぶ
		if (graphic === void) {
			// 画像がなければ
			drawRuggedness(false); 	// へこませる
			if (tab !== void && width == tab.width) {
				// 縦スライダーだった
				var w = width/2;
				var k = tab.height;
				fillRect(w,   k/2, 1, height-k, 0x80000000);
				fillRect(w+1, k/2, 1, height-k, 0x80ffffff);
			} else if (tab !== void && height == tab.height) {
				// 横スライダーだった
				var h = height/2;
				var k = tab.width;
				fillRect(k/2, h,   width-k, 1, 0x80000000);
				fillRect(k/2, h+1, width-k, 1, 0x80ffffff);
			}
		}
		updateSliderTabPos();
	}

	// 状態更新、現在の値でスライダー位置を更新する。
	function updateSliderTabPos()
	{
		// step が指定されていたら値を正規化する
		if (hstep != 0)
			hval = int((hval+hstep/2)/hstep)*hstep;
		if (vstep != 0)
			vval = int((vval+vstep/2)/vstep)*vstep;
		hval = Math.max(hmin, Math.min(hval, hmax));
		vval = Math.max(vmin, Math.min(vval, vmax));
		if (hintflg)
			hval = int(hval);
		if (vintflg)
			vval = int(vval);

		// 現在の値にあわせてtabの位置を移動する
		var x = int((width-tab.width)*((hval-hmin)/(hmax-hmin)));
		var y = int((height-tab.height)*(1-((vval-vmin)/(vmax-vmin))));
		// 以前と同じ位置なら、何もしない
		if (x == tab.left && y == tab.top)
			return;
		tab.setPos(x, y);
		if (onchangefunc !== void)
			// onchangefunc(hval, vval, dragging, true) を実行
			eval(onchangefunc+
			     "(("+hval+"), ("+vval+"), ("+tab.dragging+"))");
		if (onchangestorage !== void || onchangetarget !== void) {
			// tf.xxxを設定しonchnagestorageのonchangetargetを呼ぶ
			tf.hval = hval, tf.vval = vval;
			tf.dragging = tab.dragging;
			window.process(onchangestorage, onchangetarget,
				       countpage);
		}
	}

	// スライダータブがドラッグされた時(スライダータブクラスから呼ばれる)
	function onSliderDragged(x, y, clickx, clicky, dragbtn, shift)
	{
		// 現在の表示すべき位置に移動
		// ステップはupdateSliderTabPos()で考えるのでここでは考えない

		// このif、ないとNaN/Infinityになってハマるため必要。
		if (width-tab.width != 0)
			hval = ((tab.left+(x-clickx))/(width -tab.width))*(hmax-hmin)+hmin;
		if (height-tab.height != 0)
			vval = (1-(tab.top +(y-clicky))/(height-tab.height))*(vmax-vmin)+vmin;
		updateSliderTabPos();
	}

	// 指定カウント数だけ移動
	function moveStep(hcount=0, vcount=0)
	{
		// 移動幅(Xstep)が 0 の時は、0.05(=1/20) 刻みで移動する
		hval += ((hstep == 0) ? 0.05 : hstep) * hcount;
		vval += ((vstep == 0) ? 0.05 : vstep) * vcount;
		updateSliderTabPos();
	}

	// スライダが押された時のリピート関数
	function onMouseDownRepeat()
	{
		// 横方向がtab領域に入っていなければtabを移動
		if (hdst < tab.left)
			moveStep(-1, 0);
		else if (hdst > tab.left + tab.width)
			moveStep(1, 0);
		// 縦方向がtab領域に入っていなければtabを移動
		if (vdst < tab.top)
			moveStep(0, 1);
		else if (vdst > tab.top + tab.height)
			moveStep(0, -1);
		// 領域に入ったら timer を停止
		if (tab.left <= hdst && hdst <= tab.left + tab.width &&
		    tab.top  <= vdst && vdst <= tab.top  + tab.height)
			timer.enabled = false;
	}

	// スクロールバーのスライダ外を押した時のリピート動作開始
	function scrollTo(x, y)
	{
		hdst = x, vdst = y;
		timer.enabled = true;
	}

	// マウスが押された時(この時は必ずスライダータブ外を押されている)
	function onMouseDown(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		super.onMouseDown(...);
		if (button != mbLeft) // 左クリック以外は無視
			return;

		scrollTo(x, y);
	}

	// マウスが動かされた時
	function onMouseMove(x, y, shift)
	{
		super.onMouseMove(...);
		if (timer.enabled)
			hdst = x, vdst = y;
	}

	// マウスが放された時
	function onMouseUp(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		super.onMouseUp(...);
		timer.enabled = false;
	}

	// キーが押された時(キーでスライダー操作は未実装)
	function onKeyDown(key, shift, process)
	{
		if (process) {
			if (key == VK_LEFT) {
				moveStep(-1, 0);
				return;
			} else if (key == VK_RIGHT) {
				moveStep(1, 0);
				return;
			} else if (key == VK_UP) {
				moveStep(0, 1);
				return;
			} else if (key == VK_DOWN) {
				moveStep(0, -1);
				return;
			}
		}
		parent.onKeyDown(...);
	}

	// 表示されるとき
	function onPaint()
	{
		if (graphic === void) {
			fillRect(0,0,width,height, color);
			if (tab !== void && width == tab.width) {
				// 縦スライダーだった
				var w = width/2;
				var k = tab.height;
				fillRect(w,   k/2, 1, height-k, 0x80000000);
				fillRect(w+1, k/2, 1, height-k, 0x80ffffff);

			} else if (tab !== void && height == tab.height) {
				// 横スライダーだった
				var h = height/2;
				var k = tab.width/2;
				fillRect(k/2, h,   width-k, 1, 0x80000000);
				fillRect(k/2, h+1, width-k, 1, 0x80ffffff);
			}
		}
		super.onPaint(...);
	}

	// ボタンのコピー
	function assign(src)
	{
		super.assign(src);
		.KSliderLayer.copyLocalMembers(this, src);
		tab.assign(src.tab);
	}

	// セーブ時に上から呼ばれる
	function store()
	{
		var dic = super.store();
		.KSliderLayer.copyLocalMembers(dic, this);
		dic.tab = tab.store();	// dic.tab.*にセーブ、dic.tab*は使わぬ
		return dic;
	}

	// ロード時に上から呼ばれる
	function restore(dic)
	{
		timer.enabled = false;		// タイマを止める
		if (dic === void)
			return;
		super.restore(dic);	// この中で setOptions(dic) を実行する
		tab.restore(dic.tab);
		timer.enabled = false;		// タイマを止める
		return dic;
	}
}


// RadioButtonの一アイテム。二度押ししてもトグルしないところが異なる。
class KRadioButtonItem extends KToggleButtonLayer
{
	var classid  = 'KRadioButtonItem';

	// コンストラクタ
	function KRadioButtonItem(window, parent, name, elm)
	{
		super.KToggleButtonLayer(...);
	}

	// デストラクタ
	function finalize()
	{
		super.finalize();
	}

	// マウスが押された時
	function onMouseDown(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		if (checked && button == mbLeft)
			return;
		super.onMouseDown(left+x, top+y, button, shift);
	}

	// マウスが離された時
	function onMouseUp(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		.KAnimButtonLayer.onMouseUp(...);	// superの上を呼ぶ
		if (button != mbLeft) // 左クリック以外は無視
			return;
		if (!checked)
			parent.onCheck(this);	// 親を呼ぶ
		// KToggleButtonLayer と違い、onUncheck()は実行しない
	}
}


// KRadioButtonItem を複数配置するラジオボタン
// onCheck()/onUncheck()は、このクラスのではなくてこの子のを呼ぶこと。
class KRadioButtonLayer extends KLayer
{
	var classid     = 'KRadioButtonLayer';
	// ボタンの縦横配置は 'vertical' で規定する
	var space       = 10;		// ボタンの間の距離
	var buttonleft  = 0;		// 第一ボタンの左上X座標
	var buttontop   = 0;		// 第一ボタンの左上Y座標
	var pushed      = -1;		// 押されているボタン(初期状態では-1)
	var buttons     = [];		// RadioButtonItem(ボタン)配列
	var buttonopts  = %[];		// ボタンのオプション
	var oncheck;			// 押された時の動作
	var oncheckfunc;		// 押された時の動作(関数)
	var onuncheck;			// 離された時の動作
	var onuncheckfunc;		// 離された時の動作(関数)

	// コンストラクタ
	function KRadioButtonLayer(window, parent, i_name, elm=%[])
	{
		super.KLayer(window, parent, i_name);
//		focusable = true;	// このレイヤはフォーカスさせないが、
//					// ボタンはフォーカスするのでtrue
		if (elm.pushed === void)
			elm.pushed = 0;	// 最初の一回は必ずpushed=0を指定
		setOptions(elm);
	}

	// デストラクタ
	function finalize()
	{
		for (var i = buttons.count-1; i >= 0; i--)
			invalidate buttons.pop();
		super.finalize();
	}

	// ボタンにオプション設定
	function setOptions_button(elm=%[]/*共通オプション*/, ielm=[]/*個別*/)
	{
		// ボタンオプションが指定されていたら設定
		for (var i = buttons.count-1; i >= 0; i--) {
			buttons[i].setOptions(elm);
			if (i < ielm.count)
				buttons[i].setOptions(ielm[i]);
		}
	}

	// このレイヤローカルのメンバをコピー
	function copyLocalMembers(d, s)
	{
		d.space        = +s.space        if (s.space         !== void);
		d.buttonleft   = +s.buttonleft   if (s.buttonleft    !== void);
		d.buttontop    = +s.buttontop    if (s.buttontop     !== void);
		d.pushed       = +s.pushed       if (s.pushed        !== void);
			// "buttons"     = [];	// RadioButtonItem(ボタン)配列
		d.oncheck      = s.oncheck       if (s.oncheck       !== void);
		d.oncheckfunc  = s.oncheckfunc   if (s.oncheckfunc   !== void);
		d.onuncheck    = s.onuncheck     if (s.onuncheck     !== void);
		d.onuncheckfunc=+s.onuncheckfunc if (s.onuncheckfunc !== void);

		d.buttonopts = %[];	// ボタンの共通オプション
		if (s.buttonopts !== void)
			(Dictionary.assignStruct incontextof d.buttonopts)(s.buttonopts);
	}

	// オプション設定
	function setOptions(elm)
	{
		if (elm === void)
			return;
		var e = %[];
		(Dictionary.assign incontextof e)(elm);
		// 最初に e.pushed を保存
		var new_pushed = e.pushed;
		delete e.pushed;
		super.setOptions(e);
		.KRadioButtonLayer.copyLocalMembers(this, e);
		if (e.buttons !== void)
			changeButtonNum(+e.buttons.count);
		if (buttons.count == 0)
			return;
		setOptions_button(buttonopts, e.buttons);
		if (e.vertical !== void || e.space !== void)
			alignButtons(); // 配置変更
		// e.pushed が指定されていたら、ボタンを押す
		if (new_pushed !== void)
			makeCheck(new_pushed);
	}

	// ボタン配置を更新する
	function alignButtons()
	{
		if (buttons.count <= 0)
			return;
		var pos = 0, max = 0;
		if (vertical) {
			// 縦配置する
			for (var i = 0 ; i < buttons.count; i++) {
				buttons[i].setPos(buttonleft, buttontop+pos);
				pos += buttons[i].height + space;
				if (max < buttons[i].width)
					max = buttons[i].width;
			}
			setSize(max, pos-space);
		} else {
			// 横配置する
			for (var i = 0; i < buttons.count; i++) {
				buttons[i].setPos(buttonleft+pos, buttontop);
				pos += buttons[i].width + space;
				if (max < buttons[i].height)
					max = buttons[i].height;
			}
			setSize(pos-space, max);
		}
	}

	// ボタン数を変更する
	function changeButtonNum(num)
	{
		var b_count = buttons.count;
		if (num == b_count)
			return;
		if (num < b_count) {
			// 現状より指定が少なかったらいくつか削除
			// 配列末尾から削除する
			for (var i = b_count-1; i >= num; i--) {
				invalidate buttons.pop();
			}
		} else {
			// 現状より指定が多かったら追加作成
			for (var i = b_count; i < num; i++) {
				var btn = new KRadioButtonItem(window, this);
				btn.setOptions(buttonopts);
				buttons.add(btn);
			}
		}
		setFocusOrder();
		alignButtons();
	}

	// フォーカスの順番を設定
	function setFocusOrder()
	{
		var i;
		if (buttons.count > 0)
			buttons[0].prevfocus = _prevfocus;
		for (i = 0; i < buttons.count-1; i++)
			buttons[i].nextfocus = buttons[i+1];
		if (i > 0)
			buttons[i].nextfocus = _nextfocus;
	}

	// ボタンのいずれかが押された時の動作(子レイヤから呼ばれる)
	function onCheck(btnobj)
	{
		var index = buttons.find(btnobj);
		if (pushed == index)
			return;			// 二度押しなら何もしない
		if (pushed >= 0)
			makeUncheck(pushed);	// 以前のボタンを解除
		makeCheck(index);

		// oncheck を実行
		eval(oncheck);
		// oncheckfunc で指定された関数を indexを引数置換して呼ぶ
		if (oncheckfunc !== void)
			eval(oncheckfunc+'('+index+')');
	}

	// ボタンのいずれかが放された時の動作(子レイヤから呼ばれる)
	function onUncheck(btnobj)
	{
		var index = buttons.find(btnobj);
		// onuncheck を実行
		eval(onuncheck);
		// onuncheckfuncで指定された関数を btnidxを引数置換して呼ぶ
		if (onuncheckfunc !== void)
			eval(onuncheckfunc+'('+index+')');
	}

	// あるボタンを押す(ここでは他のボタンのトグル動作はしないことに注意)
	// ぐるっと回って onCheck() でトグルされるので。
	function makeCheck(index)
	{
		pushed = index;
		buttons[index].onCheck();
	}

	// あるボタンを離す(他のボタンのトグル動作はしないことに注意)
	function makeUncheck(index)
	{
		buttons[index].onUncheck();
	}

	// ボタンのコピー
	function assign(src)
	{
		super.assign(src);
		.KRadioButtonLayer.copyLocalMembers(this, src);
		(Dictionary.assignStruct incontextof buttonopts)(src.buttonopts);
		changeButtonNum(src.buttons.count);
		for (var i = 0; i < src.buttons.count; i++)
			buttons[i].assign(src.buttons[i]);
	}

	// セーブ時に上から呼ばれる
	function store()
	{
		var dic = super.store();
		.KRadioButtonLayer.copyLocalMembers(dic, this);
		dic.buttons = [];
// これは restore 時に setOptions で設定されるのを考えるとない方がよい？
		for (var i = 0; i < buttons.count; i++)
			dic.buttons[i] = buttons[i].store();
		dic.buttonnum = buttons.count;	// restore()で使う
		return dic;
	}

	// ロード時に上から呼ばれる
	function restore(dic)
	{
		if (dic === void)
			return;
// これだと押されてたボタンがキャンセルされないかもしれないけれど
		pushed = -1;		// 先に pushed を別ボタンにしておく
		super.restore(dic);	// この中で setOptions(dic) を実行する
		return dic;
	}

	// フォーカスレイヤを子ボタンに設定
	// ボタンが1個以上あること前提
	property prevfocus {
		setter(x) {
			_prevfocus = x;
			buttons[0].prevfocus = x if (buttons.count > 0);
		}
		getter {
			return _prevfocus;
		}
	}
	property nextfocus {
		setter(x) {
			_nextfocus = x;
			var idx = buttons.count-1;
			buttons[idx].nextfocus = x if (idx >= 0); 
		}
		getter {
			return _nextfocus;
		}
	}
}


// このレイヤ以下の指定の名前を持つレイヤーを探す(一つだけ)
function findLayer_sub(name, baselayer=kag.fore.base, recursive, startidx=0)
{
	if (baselayer.name == name)
		return baselayer;
	var ret;
	if (!recursive) {
		for (var i = baselayer.children.count-1; i >= startidx; i--)
			if ((ret = baselayer.children[i]).name == name)
				return ret;
		return void;
	}
	// 裏画面コピーなので↓0が不要なときあり
	for (var i = baselayer.children.count-1; i >= startidx; i--) {
		ret = findLayer_sub(name, baselayer.children[i], recursive);
		if (ret !== void)
			return ret;
	}
	return void;
}
// このレイヤ以下の指定の名前を持つレイヤーを探す(一つだけ)
function findLayer(name, baselayer=kag.fore.base, recursive=true)
{
	var startidx = (baselayer != kag.fore.base) ? 0 : 1;
	return findLayer_sub(name, baselayer, recursive, startidx);
}


// このレイヤ以下の指定の名前を持つレイヤーを探す(複数)
function findLayers_sub(name, baselayer=kag.fore.base, startidx=0)
{
	var ret = [];
	if (name === void || baselayer.name == name)
		ret.add(baselayer);
	for (var i = baselayer.children.count-1; i >= startidx; i--)
		add_ary(ret, findLayer_sub(name, baselayer.children[i]));
	return ret;
}
// このレイヤ以下の指定の名前を持つレイヤーを探す(配列で返す)
function findLayers(name, baselayer=kag.fore.base)
{
	var startidx = (baselayer != kag.fore.base) ? 0 : 1;
	return findLayers_sub(name, baselayer, startidx);
}


// 辞書配列に従って一つレイヤーを作成する
function createLayer(dic, parent=kag.fore.base)
{
	var elm = %[];
	(Dictionary.assign incontextof elm)(dic);
	var classid = elm.classid;
	delete elm.classid;
	if (elm.parent !== void)
		parent = findLayer(elm.parent, parent);
	if (parent === void)
		em('Error: createLayer(): elm.parent = ' + elm.parent);
	delete elm.parent;
	return (new (global[classid])(kag, parent, elm.name, elm));
}


// 辞書配列の配列に従って、複数のレイヤを一気に作成する
function createLayers(ary, parent=kag.fore.base)
{
	var ret = [];
	// 昇順に作成する
	for (var i = 0; i < ary.count; i++) {
		var p = ary[i].parent;
		if (p === void || findLayer(p, parent) !== void)
			ret.add(createLayer(ary[i], parent));
		else {
			System.inform('createLayers(): 親レイヤ未定');
			dm('createLayers(): 親レイヤ未定');
			dm('name = ' + ary[i].name + ', parent = ' + ary[i].parent);
		}
	}
	return ret;
}


// 渡された配列のレイヤを円環フォーカスにする(focusableかどうかは見ない)
function configureFocus(ary)
{
	if (ary.count <= 0)
		return;
	// フォーカスの順番を設定
	var i;
	for (i = 0; i < ary.count-1; i++)
		ary[i].nextfocus = ary[i+1];
	ary[i].nextfocus = ary[0];

	// 特殊なフォーカスが必要なlayer(例:KRadioButtonLayer)向け
	for (i = 0; i < ary.count; i++)
		if (typeof(ary[i].setFocusOrder) != 'undefined')
			ary[i].setFocusOrder();
}


// 複数種類のKLayersを画面上に配置することができるラッパープラグイン
// SystemButtonやrclick画面などで使用する。
class KLayersPlugin extends KAGPlugin
{
	var window;		// 親ウインドウ
	var name;		// 名前。セーブの時に使うので必須
	var foreparent;		// 表画面の親
	var backparent;		// 裏画面の親
	var foreary = [];	// 表画面の子クラス配列
	var backary = [];	// 裏画面の子クラス配列

	// コンストラクタ
	function KLayersPlugin(w, i_name, fp=w.fore.base, bp=w.back.base)
	{
		super.KAGPlugin(...);
		window     = w;
		name       = i_name;
		foreparent = fp;
		backparent = bp;
	}

	// デストラクタ
	function finalize()
	{
		delOnPage('both');
		super.finalize(...);
	}

	// あるページの子Layerを全て削除
	function delOnPage(page='fore')
	{
		//フォーカスが動かないように変更
		window.focusedLayer = null;
		if(page == 'both' || page == 'fore')
			for(var i = foreary.count-1; i >= 0; i--)
				invalidate(foreary.pop());
		if(page == 'both' || page == 'back')
			for(var i = backary.count-1; i >= 0; i--)
				invalidate(backary.pop());
	}

	// 指定nameの子Layerを削除
	function del(name, page='fore')
	{
		//フォーカスが動かないように変更
		window.focusedLayer = null;
		if(name === void) {
			delOnPage(page);
			return;
		}
		if(page == 'both' || page == 'fore')
			for(var i = foreary.count-1; i >= 0; i--) {
				if(foreary[i].name == name) {
					invalidate(foreary[i]);
					foreary.erase(i);
				}
				configureFocus(foreary);
			}
		if(page == 'both' || page == 'back')
			for(var i = backary.count-1; i >= 0; i--) {
				if(backary[i].name == name) {
					invalidate(backary[i]);
					backary.erase(i);
				}
				configureFocus(backary);
			}
	}

	// 子Layerを一つ追加
	function add(name='noname', classobj, page='fore', elm)
	{
		var obj;
		if (page == 'fore' || page == 'both') {
			obj = new classobj(window, foreparent, name, elm);
			foreary.add(obj);
			configureFocus(foreary);
		}
		if (page == 'back' || page == 'both') {
			obj = new classobj(window, backparent, name, elm);
			backary.add(obj);
			configureFocus(backary);
		}
	}

	// nameとpageに対応する子レイヤを探す
	function search(name, page='fore')
	{
		var retary = [];
		if(page == 'both' || page == 'fore') {
			for(var i = foreary.count-1; i >= 0; i--)
				if(name === void || foreary[i].name == name)
					retary.add(foreary[i]);
		}
		if(page == 'both' || page == 'back') {
			for(var i = backary.count-1; i >= 0; i--)
				if(name === void || backary[i].name == name)
					retary.add(backary[i]);
		}
		return retary;
	}

	// nameとpageに対応する子レイヤを探す(一個だけ版)
	function search_one(name, page='fore')
	{
		var retary = search(name, page);
		if (retary.count == 0)
			return void;
		if (retary.count == 1)
			return retary[0];
		em("search_one()で対象レイヤが複数発見されました。"+
			"とりあえず void を返します。"+
			"search_one("+name+", "+page+")");
		return void;
	}

	// オプション指定
	function setOptions(name, page='fore', elm)
	{
		var focused = -1;
		// ↑マウスを移動させないために、フォーカスレイヤを最後に
		// 変更するための細工
		// ary中にフォーカスされたレイヤが存在しない場合もあるので、
		// window.focusedLayerは使用できない
		//
		// …これ、0.98bでKLayerにonSearchNextFocusable()追加したから、
		// 必要なくなったんじゃないだろうか…。
		var ary = search(name, page);
		for (var i = ary.count-1; i >= 0; i--) {
			if (ary[i].focused)
				focused = i;
			else
				ary[i].setOptions(elm);
		}
		if (focused >= 0)
			ary[focused].setOptions(elm);
	}

	// レイヤの表←→裏の情報のコピー
	// backlay タグやトランジションの終了時に呼ばれる
	function onCopyLayer(toback)
	{
		if (toback) {
			// 表→裏
			delOnPage('back');
			for(var i = foreary.count-1; i >= 0 ; i--) {
				var classobj = global[foreary[i].classid];
				backary[i] = new classobj(window,
					backparent, foreary[i].name);
				backary[i].assign(foreary[i]);
			}
		} else {
			// 裏→表
			delOnPage('fore');
			for(var i = backary.count-1; i >= 0 ; i--) {
				var classobj = global[backary[i].classid];
				foreary[i] = new classobj(window,
					foreparent, backary[i].name);
				foreary[i].assign(backary[i]);
			}
			configureFocus(foreary);
		}
	}

	// 裏と表の管理情報を交換
	function onExchangeForeBack()
	{
		// children = true のトランジションでは、トランジション終了時に
		// 表画面と裏画面のレイヤ構造がそっくり入れ替わるので、
		// それまで 表画面だと思っていたものが裏画面に、裏画面だと思って
		// いたものが表画面になってしまう。ここのタイミングでその情報を
		// 入れ替えれば、矛盾は生じない。
		var tmp = foreary;
		foreary = backary;
		backary = tmp;

		var tmp = foreparent;
		foreparent = backparent;
		backparent = tmp;
		configureFocus(foreary);
	}

	// セーブ
	function onStore(f, elm)
	{
		// 栞を保存するとき
		var dic = f["klayersplugin_" + name] = %[];
		dic.foreary = [];
		dic.backary = [];
		for(var i = 0; i < foreary.count; i++)
			dic.foreary.add(foreary[i].store());
		for(var i = 0; i < backary.count; i++)
			dic.backary.add(backary[i].store());
		return dic;	// 子クラスのために返す
	}

	// ロード
	function onRestore(f, clear, elm)
	{
		// 栞を読み出すとき
		delOnPage('both');
		var dic = f["klayersplugin_" + name];
		if(dic === void)
			return;
		// 読み込んだものを戻す
		if (elm !== void && elm.backlay) {
			// [tempload backlay=true]なら
			for(var i = 0; i < dic.foreary.count; i++) {
				var classobj = global[dic.foreary[i].classid];
				backary[i] = new classobj(window, backparent);
				backary[i].restore(dic.foreary[i]);
			}
		} else {
			// 通常時の読み込み
			for(var i = 0; i < dic.foreary.count; i++) {
				var classobj = global[dic.foreary[i].classid];
				foreary[i] = new classobj(window, foreparent);
				foreary[i].restore(dic.foreary[i]);
			}
			for(var i = 0; i < dic.backary.count; i++) {
				var classobj = global[dic.backary[i].classid];
				backary[i] = new classobj(window, backparent);
				backary[i].restore(dic.backary[i]);
			}
		}
		return dic;	// 子クラスのために返す
	}
}

/*
// 親レイヤを自分の中に持つ画面
class KLayersScreen extends KLayersPlugin
{
	var forelayer;
	var backlayer;

	function KLayersScreen(w, i_name, parent_elm)
	{
		forelayer; 
		fp=w.fore.base, bp=w.back.base
		super.KLayersPlugin(...);
	}

	function KLayers

}
 */

// KLayersPluginクラスをちょっとだけ拡張した、メッセージレイヤにボタンを
// 配置するためのクラス。
// メッセージウィンドウにくっついてvisible/unvisibleが設定される
// ようにするため。
class KLayersPluginOnMessage extends KLayersPlugin
{
	var withmessage     = true;	// メッセージ画面と一緒に隠すかどうか
	var foreary_visible = [];	// 隠した時の fore の layer の表示状態
	var backary_visible = [];	// 隠した時の back の layer の表示状態
	var anytimeenabled  = false;	// 常にenableか。通常はstable状態でのみenable

	// コンストラクタ
	function KLayersPluginOnMessage(name, fp, bp, withmessage=true, anytimeenabled=false)
	{
		super.KLayersPlugin(kag, name, fp, bp);
		this.withmessage = withmessage;
		this.anytimeenabled = anytimeenabled;
	}

	// Add の時に absolute を message レイヤの上にするよう細工
	function add(name='noname', classobj, page='fore', elm = %[])
	{
		if (elm.absolute === void)
			elm.absolute = 1100000;	//メッセージレイヤ100枚目と同じ
		super.add(...);
	}

	// 「安定」( s l p の各タグで停止中 ) か、
	// 「走行中」 ( それ以外 ) かの状態が変わったときに呼ばれる
	function onStableStateChanged(stable)
	{
		if (anytimeenabled)
			return;
		super.onStableStateChanged(...);
		// 走行中はレイヤを無効にする
		setOptions(, 'both', %[ enabled: stable ]);
	}

	// メッセージレイヤがユーザの操作によって表示・非表示される時
	// 呼ばれる。メッセージレイヤと表示/非表示を同期させるため設定
	function onMessageHiddenStateChanged(hidden)
	{
		if (!withmessage)
			return;
		super.onMessageHiddenStateChanged(...);
		if (hidden) {
			// 隠すとき：現在の状態を記憶する
			foreary_visible = [];
			backary_visible = [];
			for (var i = foreary.count-1; i >= 0; i--)
				foreary_visible[i] = foreary[i].visible;
			for (var i = backary.count-1; i >= 0; i--) 
				backary_visible[i] = backary[i].visible;
			setOptions(, 'both', %[ visible: false ]);
		} else {
			// 表示するとき：元の状態に戻す
			for (var i = foreary.count-1; i >= 0; i--)
				foreary[i].visible = foreary_visible[i];
			for (var i = backary.count-1; i >= 0; i--)
				backary[i].visible = backary_visible[i];
			foreary_visible = [];
			backary_visible = [];
		}
	}

	// 今のままでは、hidden 中に要素が add/del された場合を考慮していない。
	// 本当は、fore/backary_visible[] に追加・から削除する処理が必要。

	// レイヤの表←→裏の情報コピー
	function onCopyLayer(toback)
	{
		super.onCopyLayer(toback);
		if (toback)
			backary_visible.assign(foreary_visible); // 表→裏
		else
			foreary_visible.assign(backary_visible); // 裏→表
	}

	// 裏と表の管理情報を交換
	function onExchangeForeBack()
	{
		super.onExchangeForeBack();
		var tmp = [];
		tmp.assign(foreary_visible);
		foreary_visible.assign(backary_visible);
		backary_visible.assign(tmp);
	}

	// セーブ(メッセージ消去中にセーブできなければ不要)
	function onStore(f, elm)
	{
		var dic = super.onStore(f, elm);
		dic.withmessage = withmessage;
		dic.foreary_visible = [];
		dic.foreary_visible.assign(foreary_visible);
		dic.backary_visible = [];
		dic.backary_visible.assign(backary_visible);
		dic.anytimeenabled = anytimeenabled;
		return dic;	// 子クラスのために返す
	}

	// ロード(メッセージ消去中にセーブできなければ不要)
	function onRestore(f, clear, elm)
	{
		var dic = super.onRestore(f, clear, elm);
		if (dic === void)
			return dic;
		withmessage = dic.withmessage;
		if (elm !== void && elm.backlay) {
			// [tempload backlay=true]の時
			backary_visible = [];
			if (dic.foreary_visible !== void)
				backary_visible.assign(dic.foreary_visible);
		} else {
			// 通常時
			foreary_visible = [];
			if (dic.foreary_visible !== void)
				foreary_visible.assign(dic.foreary_visible);
			backary_visible = [];
			if (dic.backary_visible !== void)
				backary_visible.assign(dic.backary_visible);
		}
//		onMessageHiddenStateChanged(0);
//		↑これは不要。super.onRestore() 中で設定してしまうため。
		anytimeenabled = dic.anytimeenabled;
		return dic;	// 子クラスのために返す
	}
}


// このファイルを読み込んだフラグ
global.KLayersLoaded = true;

[endscript]

[return]