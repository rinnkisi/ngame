;�v���O�C��
[return cond="typeof(global.KLayersLoaded) != 'undefined'"]

; ToDo:
;	�E�ŏ��Ɏ��s����X�N���v�g�E�A�Ō�Ɏ��s����X�N���v�g��ǉ�����
;	�E�g�����W�V�������� mousedown/keydown �ł��Ȃ��悤�ɂ���
;	�Erestore(dic)�̎��Adic��void�����o����������X�L�b�v����Ȃ����H
;	�EsetOptions_�N���X��()��setLocalMembers()�ɕύX���������������H������
;	�@��������ƍċN�Ăяo���ɂȂ��Ēx���Ȃ�Ȃ����H
;	�E�{�^����ŉE�N���b�N������E�N���b�N���[�`�����オ�邩�ǂ���
; KCheckBoxLayer�܂� copyLocalMembers()/copyAllMembers()������
;	�E�A�j���[�V�����{�^���Fpush���Ԃ����b�N����Aanim���I���܂ő҂�
;	�E�A�j���[�V�����̃Z�[�u�E���[�h�ŃA�j���������ł��邩�H
; �N���b�N�́AonMouseDown()����Ȃ���onMouseUp�ň����|�����ق��������̂��H
; �̈�O�Ń}�E�X�������Ƃ��ɖ����ɂ��邱�Ƃ��ł��邩��B
;
; 2013/12/07	0.99g	�ELayer_copyLocalMembers()��typo�ďC���c
; 2013/12/05	0.99f	�ELayer_copyLocalMembers()�ŁAsetImagePos()�̎w�肪
;			�@�����A�u���C���̈�ɉ摜�̂Ȃ��̈悪�������܂����v
;			�@�G���[�ƂȂ��Ă����̂��C��
; 2013/11/25	0.99e	�E�{�^���t�H���g���Akfont���w�肷��ƃR���ɍ��킹��悤
;			�@�C���B�����悤�ɁA�{�^���F��color�w���D��
;			�EKFont��copyLocalMembers()��src��s�ɏC��
;			�EsetOptions()�����疳������redraw()����悤�ύX
;			�EKRadioButtonLayer()��name���w�肵�ĂȂ������̂ŏC��
;			�EKRadioButtonLayer��copyLocalMembers()��d.���w�肳���
;			�@���Ȃ����̂��������̂��C��
; 2013/11/18	0.99d	�ESliderLayer��onSliderDragged()�̈������Ԉ���Ă��̂�
;			�@�C��
;			�ESliderLayer��hval/vval��min/max��intflg��ǉ�
;			�ESliderLayer��updateSliderTabPos()�ŁAhval/vval�ɓ���
;			�@�l���ݒ肳�ꂽ�Ƃ��́A�X�V���X�L�b�v����悤�C��
;			�EKRadioButtonLayer��setOptions_button()�̈������C��
; 2013/09/08	0.99c	�ELayer_copyLocalMembers() �� imageLeft+imageWidth < 0
;			�@�Ȃǂ̏ꍇ�ɃG���[�I�����Ă����̂��C��
; 2013/08/10	0.99��	�EcopyLocalMembers()��P���Ȃ��̂ɍ����ւ��B
;			�@copyMembers()���g���ƎO�{�ȏ㎞�Ԃ������邽�߁B
;			�EKClickableLayer.playSound()��buf���w�肵�Ă�buf=0��
;			�@��������Ă����̂��C��
; 2013/04/21	0.99��	�EButtonLayer��entercolor/clickcolor��ǉ�
;			�EButtonLayer��face = dfAlpha���폜�Bdef������s�v�̔�
;			�E�t�H���g��KFont()�N���X�Ƃ��ĐV�K�쐬
;			�E�A�j���[�V���������s����startAnim()���A�֐��̍Ō�
;			�@�ł͂Ȃ��A�\�Ȍ����ʂŎ��s����悤�ɕύX
;			�EK*_setOptions()��copyLocalMembers()�ɖ��̕ύX
;			�E���ł̒l�ݒ��copyAllMember()�֐��Ŏ��s����悤�ύX
;			�EToggle��onCheck/onUncheck��onMouseRelease()�œ���
;			�@����悤�ɕύX�B�t���X�N���[���؂�ւ����� onMouseUp
;			�@�C�x���g���N����Ȃ��ꍇ��������ւ̑΍�
;			�ERadioButton�́Aassign����ƃ{�^�������ς��Hfocus��
;			�@���Ԃ��ς���Ă���ۂ�
;
; 2012/04/23	0.98c	�E�t�H�[�J�X����Ă��郌�C�����폜���鎞(delOnPage()��
;			�@del()���鎞)��window.focusedLayer=null��ǉ�
;			�EonFocus()�Ń}�E�X�J�[�\���𓮂����̂��A�L�[��
;			�@�����ꂽ���݂̂Ɍ���(MessageLayer�ł�������Ă邵)
; 2012/02/21	0.98b	�t�H�[�J�X����Ă��郌�C����visible/enabled=false��
;			�ݒ肵�ăt�H�[�J�X�������̂�����邽�߂ɁAKLayer
;			�N���X��onSearchNextFocusable()��ǉ�
; 2011/08/13	0.98a	Layer�N���X��order�����o��ύX���Ȃ��悤�ɏC��
; 2011/06/25	0.98	setOptions()��setOptions_sub()���g��ʂ悤�ύX
;			setOptions()��(keys(elm).count <= 0))�𔻒肹�ʂ悤��
;			evalstr()��TJSFunctions��str2num()�ɕύX
; 2011/06/11	0.97	KLayer�N���X��captionface ��ǉ�
; 2011/05/30	0.95	classid ���������̂��������̂Œǉ�
;			KLayersPlugin��onStore/Restore��for�̏��Ԃ�ύX
;			onRestore()���Aelm.backlay == true ��fore->back�߂��v
;			onRestore()�̑�������clear�������̂�Y��ĂďC��
;			setOptions()��loadImages()�̑O��setOptions_sub() �����
;			imageLeft�Ȃǂ��ݒ肳���ꍇ�Ɂu�͈͊O�̉摜�\���v
;			�G���[�ƂȂ�̂��C��
;			KSliderLayer��finalize()��timer.enabled=false��ǉ�
;			discardImage() �� hasImage=0, hasImage=1 ��ǉ�
;			KRadioButtonLayer��setOptions()�ŁA�{�^����==0��e����
; 2011/04/06	0.91	hitThreshold��KLayer��256�ɁAKClickableLayer��16�ɂ���
;			hitThreshold��ۑ�����悤�ɂ���
; 2011/03/26	0.90	KAnimButtonLayer�̃^�O��KAnimLayer�Ɠ���
;			�e��startanim()�̈����ԈႢ���C��
;			setOptions() �� elm.clickstorage!==void����
;			elm.clicktarget===void�̎���clicktarget�������Ⴂ���C��
;			KAnimButtonLayer��onBlur()�ǉ�
;			KAnimLayer�Ȃǂ�[disp]������ x,y �� sx,sy �ɕύX

[call storage="TJSFunctions.ks"]

[iscript]

/*
   KLayers�p���c���[

Layer
    �� KLayer .................................. ��{���C��
        �� KAnimLayer .......................... �A�j���[�V�������C��
        �� KClickableLayer ..................... �N���b�N�\���C��
            �� KButtonLayer .................... �{�^�����C��
                �� KAnimButtonLayer ............ �A�j���[�V�����{�^�����C��
                    �� KToggleButtonLayer ...... �g�O���{�^�����C��
                        �� KCheckBoxTopLayer ... �`�F�b�N�{�b�N�X�̃g�b�v����
                        �� KRadioButtonItem .... ���W�I�{�^���̂P�A�C�e��
                    �� KCheckBoxLayer .......... �`�F�b�N�{�b�N�X���C��
                    �� KSliderTabLayer ......... �X���C�_�[�̃^�u����
        �� KSliderLayer ........................ �X���C�_�[���C��(�x�[�X�̂�)
        �� KRadioButtonLayer ................... ���W�I�{�^�����C��(�x�[�X�̂�)

 */

// �f�t�H���g�̕\���D�揇��
sf.KLAYERS_DEFABSOLUTE = 2000000-2;

/*
KLayers�̃X�P���g���͈ȉ��̒ʂ�B
class KAGLayers_skelton // extends KAGLayer(�܂��͂��̔h�����C��)
{
	var classid;	// �N���X���̕�����
	// var name; name �� Layer �N���X�ɗL��̂Œ�`�s�v�B

	// �R���X�g���N�^�Bname/elm�͏ȗ��\
	function KAGLayers_skelton(w, p, name, elm);

	// �f�X�g���N�^
	function finalize();

	// �I�v�V�����ݒ�Belm===void�̂��Ƃ��l���Ă�������
	function setOptions(elm);

	// �I�u�W�F�N�g�̃R�s�[
	function assign(src);

	// �I�u�W�F�N�g�Z�[�u���ɁA���g�̎����z��dic������ĕԂ�
	function store();

	// �I�u�W�F�N�g���[�h���ɁA�����z��dic�����Ɏ��g��ݒ肷��(dic��Ԃ�)
	function restore(dic);
}
�s�����珑�����Ⴄ�ƃ��x���ƔF������Ă��܂��B���� */

// ���C���[��h������ƒx���Ȃ�̂ŁAKAGLayer�ł͂Ȃ��ALayer�N���X�����̂܂�
// �g���B�Ȃ񂩂̔��q�ɖ߂��Ă��������ǁc�B



// �K�v�Ȃ�R�s�[����... �����o�̕ύX�⎫���R�s�[�ɂ͂�����g��
function copyMember(d, s, key, numeric=true, copyifvoid=false)
{
	if (typeof(s[key]) != 'undefined' &&
	    (s[key] !== void || copyifvoid))
		d[key] = (numeric && !copyifvoid) ? +s[key] : s[key];
}


// ���̃v���O�C����ǂݍ��񂾎��� kag.fore.messages[0] �̒l�𓾂�
// �ŁA����� KFont �̃f�t�H���g�l�Ɏg���B
var KFont_default = %[];
{
	var l = kag.fore.messages[0];
	KFont_default = %[
		vertical	: l.vertical,	// �c�����E������
		face		: l.userFace,
		color		: l.defaultChColor,
		height		: l.defaultFontSize,
		bold		: l.defaultBold,
		italic		: 0,		// �C�^���b�N�͏����l���Ȃ�����
// strikeout/underline �͍��͈Ӗ����Ȃ��炵������폜
//		strikeout	: false,	// ��������
//		underline	: false,	// �A���_�[���C��
		opacity		: 255,		// �����x�͏����l���Ȃ�����
		antialiased	: l.antialiased,
		// ���������� l.defaultEdge/defaultShadow�ɂ��ς��
		shadowlevel	: 0,
		shadowcolor	: 0x000000,
		shadowwidth	: 0,
		shadowoffsetx	: 0,
		shadowoffsety	: 0
	];

	// �e�w�肾�����Ƃ��̃f�t�H���g�l
	if (l.defaultShadow) {
		KFont_default.shadowlevel	= 255;
		KFont_default.shadowcolor	= l.defaultShadowColor;
		KFont_default.shadowwidth	= 0;
		KFont_default.shadowoffsetx	= l.shadowOffsetX;
		KFont_default.shadowoffsety	= l.shadowOffsetY;
	}
	// �����w�肾�����Ƃ��̃f�t�H���g�l
	if (l.defaultEdge) {
		KFont_default.shadowlevel	= l.edgeEmphasis;
		KFont_default.shadowcolor	= l.defaultEdgeColor;
		KFont_default.shadowwidth	= l.edgeExtent;
		KFont_default.shadowoffsetx	= 0;
		KFont_default.shadowoffsety	= 0;
	}
}


// �t�H���g����ۑ�����N���X
class KFont
{
	var vertical;		// �c�����E������
	var face;		// �t�H���g��
	var color;		// �t�H���g�F
	var height;		// �t�H���g�T�C�Y
	var bold;		// �������ۂ�(true/false)
	var italic;		// �Α̂��ۂ�(true/false)
// strikeout/underline �͍��͈Ӗ����Ȃ��炵������폜
//		strikeout	: false,	// ��������
//		underline	: false,	// �A���_�[���C��
	var opacity;		// �����̓����x
	var antialiased;	// �����̂ڂ����
	var shadow;		// �e�t���������ۂ�(true/false)
	var shadowlevel;	// �e�̓����x
	var shadowcolor;	// �e�t�������̉e�̐F
	var shadowwidth;	// �e�t�������̉e�̂ڂ����
	var shadowoffsetx;	// �e�t�������̉e�̉��I�t�Z�b�g
	var shadowoffsety;	// �e�t�������̉e�̉��I�t�Z�b�g

	// �R���X�g���N�^
	function KFont(elm)
	{
		setOptions(KFont_default);
		setOptions(elm);
	}

	// �f�X�g���N�^
	function finalize()
	{
	}

	// �I�v�V�����ݒ�(2�I�y�����h��)
	function copyLocalMembers(d, s)
	{
		if (d === void || s === void)
			return;
		if (typeof(s) == "String") // ������������Ȃ玫���ɂ��Đݒ�
			s = ("%["+s+"]")!; 
		d.vertical      = +s.vertical      if (s.vertical    !== void);
		d.face          = s.face           if (s.face        !== void);
		d.color         = +s.color         if (s.color       !== void);
		d.height        = +s.height        if (s.height      !== void);
		d.bold          = +s.bold          if (s.bold        !== void);
		d.italic        = +s.italic        if (s.italic      !== void);
// strikeout/underline �͍��͈Ӗ����Ȃ��炵������폜
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

	// ���̃N���X�ȉ��̑S�Ẵ����o�[���R�s�[����
	function copyAllMembers(dst, src)
	{
		.KFont.copyLocalMembers(dst, src);
	}

	// �I�v�V�����ݒ�
	function setOptions(elm)
	{
		.KFont.copyLocalMembers(this, elm);
	}

	// �t�H���g��ݒ肷��
	function setFont(layer) {
		selectcopy_dic(layer.font, this,
			    ['bold','face','height','italic']);
		layer.font.angle = 0;
		if (vertical) {
			// �c�����̎�
			layer.font.angle = 2700;
			layer.font.face = '@' + face;
		}
	}

	// �e�L�X�g�`��
	function drawText(layer, x, y, text)
	{
		if (text === void || text == '')
			return;
		.KFont.setFont(layer);
		layer.drawText(x, y, text, color, opacity, antialiased,
				shadowlevel, shadowcolor, shadowwidth,
				shadowoffsetx, shadowoffsety);
	}

	// �e�L�X�g��
	function getTextWidth(layer, text)
	{
		.KFont.setFont(layer);
		return layer.font.getTextWidth(text);
	}

	// �e�L�X�g��
	function getTextHeight(layer, text)
	{
		.KFont.setFont(layer);
		return l.font.getTextHeight(text);
	}

	// �R�s�[
	function assign(src)
	{
		.KFont.copyLocalMembers(this, src);
	}

	// �Z�[�u���ɏォ��Ă΂��
	function store()
	{
		var dic = %[];
		.KFont.copyLocalMembers(dic, this);
		return dic;
	}

	// ���[�h���ɏォ��Ă΂��
	function restore(dic)
	{
		if (dic === void) {
			.KFont.setOptions(KFont_default); //���߂ăf�t�H���g��
			return;
		}
		.KFont.setOptions(dic);
		return dic;
	}
};


// �摜�E�e�L�X�g��\�����邾���̃��C���[
class KLayer extends Layer
{
	var classid = "KLayer";		// �萔
//	var name;			// ���O(Layer�N���X���Œ�`�ς䂦�s�v)
	var kfont;			// �t�H���g(�{�^���p��kfont�Ƃ���)
					// font��Layer�ɂ���̂Ŏg���Ȃ���
	var vertical   = false;		// �c�������ǂ���
	var text       = "";		// �\�����镶��
	var texthalign = 'center';	// �����\���ʒu(left/center/right)
	var textvalign = 'center';	// �����\���ʒu(top/center/bottom)
	var textleft   = 0;		// �����\���̈�̏���WX
	var texttop    = 0;		// �����\���̈�̏���WY
	var textwidth  = 0;		// �����\���̈�̉��T�C�Y(0�ŉ���t)
	var textheight = 0;		// �����\���̈�̏c�T�C�Y(0�ŏc��t)
	var linespace  = 2;		// �s�Ԋu
	var color;
	var graphic;			// �摜�t�@�C����(void�ŉ摜�Ȃ�)
	var graphickey;			// �摜�̔����F

	// prevFocusable/nextFocusable��readonly�Ȃ̂ŐV���Ƀ����o�����
	var _prevfocus = null, _nextfocus = null;

// �ǉ����邩��ōl����
//	var oncreate;
//	var createstorage;
//	var createtarget;
//	var ondestroy;
//	var destroystorage;
//	var destroytarget;

	// �R���X�g���N�^
	function KLayer(window, parent, i_name = "", elm)
	{
		super.Layer(window, parent);
		name         = i_name;
//		setSize(32,32);		// �f�t�H���g�T�C�Y�Ȃ̂Őݒ�s�v
		focusable    = false;	// �f�t�H���g�ł� unfocusable
		hitThreshold = 256;	// �f�t�H���g�ł͓����蔻��Ȃ�
		absolute     = sf.KLAYERS_DEFABSOLUTE;
		visible      = true;
		kfont        = new KFont();
		color        = 0xff404040;
		setOptions(elm);
	}

	// �f�X�g���N�^
	function finalize()
	{
		invalidate kfont;
		super.finalize();
	}

	// Layer�N���X�̃��[�J���̃����o���R�s�[
	function Layer_copyLocalMembers(d, s)
	{
		if (Scripts.getClassNames(d).find('Layer') >= 0) {
			// Layer�̂Ƃ��� setPos()/setImagePos() ���g��
			if (Scripts.getClassNames(s).find('Layer') >= 0) {
				d.setPos(+s.left, +s.top, +s.width, +s.height);
				// imagepos=(0,0)�ɂ��ăT�C�Y�ύX����̂��~�\
				// �������Ȃ��Ɓu�摜�Ȃ��̈��`��v�ɂȂ�
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
				// imagepos=(0,0)�ɂ��ăT�C�Y�ύX����̂��~�\
				// �������Ȃ��Ɓu�摜�Ȃ��̈��`��v�ɂȂ�
				d.setImagePos(0, 0);
				d.setImageSize(w, h);
				d.setImagePos(l, t);
			}
		} else {
			// Layer�łȂ��Ƃ��̓e�L�g�[�ɃR�s�[
			d.left       = +s.left        if (s.left      !==void);
			d.top        = +s.top         if (s.top       !==void);
			d.width      = +s.width       if (s.width     !==void);
			d.height     = +s.height      if (s.height    !==void);
			d.imageLeft  = +s.imageLeft   if (s.imageLeft !==void);
			d.imageTop   = +s.imageTop    if (s.imageTop  !==void);
			d.imageWidth = +s.imageWidth  if (s.imageWidth!==void);
			d.imageHeight= +s.imageHeight if (s.imageHeight!==void);
		}

		// �R�����g�A�E�g����Ă��郁���o��readonly�̂���
		d.absolute     = +s.absolute     if (s.absolute     !== void);
		d.absoluteOrderMode = s.absoluteOrderMode if (s.absoluteOrderMode !== void);
		d.attentionLeft = +s.attentionLeft if(s.attentionLeft!== void);
		d.attentionTop = +s.attentionTop if (s.attentionTop !== void);
		d.cached       = +s.cached       if (s.cached       !== void);
//		"callOnPaint",		//onPaint()���ĂԂ�
//		"children",		//�q���C���z��
		d.clipHeight   = +s.clipHeight   if (s.clipHeight   !== void);
		d.clipLeft     = +s.clipLeft     if (s.clipLeft     !== void);
		d.clipTop      = +s.clipTop      if (s.clipTop      !== void);
		d.clipWidth    = +s.clipWidth    if (s.clipWidth    !== void);
		d.cursor       = s.cursor        if (s.cursor       !== void);
//		"cursorX",		// �}�E�X�J�[�\���ʒuX
//		"cursorY",		// �}�E�X�J�[�\���ʒuY
		d.enabled      = +s.enabled      if (s.enabled      !== void);
		d.face         = +s.face         if (s.face         !== void);
		d.focusable    = +s.focusable    if (s.focusable    !== void);
//		"focused",		//�t�H�[�J�X����Ă��邩�ǂ���
//		"font",			//�t�H���g
//		"hasImage",		//���C�����摜�������ǂ���

//##�R�s�[�ς�	d.height       = +s.height       if (s.height       !== void);
		d.hint         = s.hint          if (s.hint         !== void);
		d.hitThreshold = +s.hitThreshold if (s.hitThreshold !== void);
		d.hitType      = +s.hitType      if (s.hitType      !== void);
		d.holdAlpha    = +s.holdAlpha    if (s.holdAlpha    !== void);

//##�R�s�[�ς�	d.imageHeight  = +s.imageHeight  if (s.imageHeight  !== void);
//##�R�s�[�ς�	d.imageLeft    = +s.imageLeft    if (s.imageLeft    !== void);
		d.imageModified= +s.imageModified if(s.imageModified!== void);
//##�R�s�[�ς�	d.imageTop     = +s.imageTop     if (s.imageTop     !== void);
//##�R�s�[�ς�	d.imageWidth   = +s.imageWidth   if (s.imageWidth   !== void);
		d.imeMode      = +s.imeMode      if (s.imeMode      !== void);
//		"isPrimary",		//�v���C�}�����C�����ǂ���
		d.joinFocusChain=s.joinFocusChain if(s.joinFocusChain!==void);
//##�R�s�[�ς�	d.left         = +s.left         if (s.left         !== void);
//		"mainImageBuffer",	//���C���摜�o�b�t�@
//		"mainImageBufferForWrite",//���C���摜�o�b�t�@(�������ݗp)
//		"mainImageBufferPitch",	//���C���摜�o�b�t�@�s�b�`
		d.name         = s.name          if (s.name         !== void);
		d.neutralColor = +s.neutralColor if (s.neutralColor !== void);
//		"nextFocusable",	//����̃t�H�[�J�X���󂯎��郌�C��
//		"nodeEnabled",		//���C���m�[�h������\���ǂ���
//		"nodeVisible",		//�m�[�h�������ǂ���
		d.opacity      = +s.opacity      if (s.opacity      !== void);
//�w�肷���absolute���ς��̂ł����ł͎w�肵�Ȃ� "order"	//���Έʒu
//		"parent",		//�e���C��
//		"prevFocusable",	//�O���̃t�H�[�J�X���󂯎��郌�C��
//		"provinceImageBuffer",	//�̈�摜�o�b�t�@
//		"provinceImageBufferForWrite",//�̈�摜�o�b�t�@(�������ݗp)
//		"provinceImageBufferPitch",//�̈�摜�o�b�t�@�s�b�`
		d.showParentHint=+s.showParentHint if(s.showParentHint!==void);
//##�R�s�[�ς�	d.top          = +s.top          if (s.top          !== void);
		d.type         = +s.type         if (s.type         !== void);

		d.useAttention = +s.useAttention if (s.useAttention !== void);
		d.visible      = +s.visible      if (s.visible      !== void);
//##�R�s�[�ς�	d.width        = +s.width        if (s.width        !== void);
//		"window"		//�E�B���h�E�I�u�W�F�N�g

//		if (!parent.absoluteOrderMode) ��������ƌZ�탌�C����absolute
//			dst.order = src.order; ��ς��Ă����ɍ���̂ō폜

	}

	// ���̃N���X�̃����o�ݒ�
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
// nextfocus/prevfocus �́Aassign()�Astore()������ł��R�s�[���Ȃ��B
// �R�s�[����ƁA����ʁE�\��ʂł̎Q�ƃ��C�������������Ȃ邽�߁B

		d.kfont = %[] if (d.kfont === void);
		.KFont.copyLocalMembers(d.kfont, s.kfont);
	}

	// ���̃N���X�ȉ��̑S�Ẵ����o�[���R�s�[����
	function copyAllMembers(dst, src)
	{
		Layer_copyLocalMembers(dst, src);
		.KLayer.copyLocalMembers(dst, src);
	}

	// �I�v�V�����ݒ�
	function setOptions(elm)
	{
		if (elm === void)
			return;

		// ��ɉ摜��ǂށBimageLeft���ݒ肳��摜�͈͊O�̕\����h����
		.KLayer.loadImages(elm.graphic, elm.graphickey); // void�ł�OK
		Layer_copyLocalMembers(this, elm);
		.KLayer.copyLocalMembers(this, elm);
		if (elm.graphic !== void && elm.graphic == "")
			graphic = void;	// loadImages()�Őݒ肵��graphic��
					// setOptions()�ŏ㏑������邽�ߍĐݒ�
		redraw();
	}

	// �C���[�W��ǂ� �����������œ����C���[�W��ǂݍ���
	function loadImages(graphic=this.graphic, key=this.graphickey)
	{
		this.graphickey = (key===void) ? void : +key;
		this.graphic    = graphic;
		if (graphic === void || graphic == "") {
			.KLayer.discardImage();
			return;
		}
		// �摜�������
		super.loadImages(graphic, this.graphickey);
		// �T�C�Y���C���[�W�T�C�Y�ɍ��킹��
		setSizeToImageSize();
		// ����������Ƃ��͕�����`��
		drawTextWithAlign(kfont, text);
	}

	// �摜�𖳌�������
	function discardImage()
	{
		graphic = void;
		hasImage = 0;	hasImage = 1;	// ����ŉ摜����x����������
		fillRect(0, 0, width, height, color);
		// ����������Ƃ��͕�����`��
		drawTextWithAlign();
	}

	// �}�E�X�������ꂽ�ꍇ
	function onMouseDown(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		// �C�x���g�𓧉߂��邽�߁A�e�֓`���邾��
		parent.onMouseDown(left+x, top+y, button, shift);
	}

	// �}�E�X�������ꂽ�ꍇ
	function onMouseUp(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		// �e�փC�x���g��`���邾��
		parent.onMouseUp(left+x, top+y, button, shift);
	}

	// �}�E�X����������
	function onMouseEnter()
	{
		if (focusable && enabled && visible) {
			focus() if (!focused);
			return;
		}
		super.onMouseEnter(...);
	}

	// �L�[�������ꂽ��
	function onKeyDown(key, shift, process)
	{
		if (process && key == VK_TAB) {
			// TAB�������ꂽ�玟��focusable�ȃ��C����T��
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

	// �A���C�����l���e�L�X�g�`��(������)
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

	// �A���C�����l���e�L�X�g�`��(�c����)
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

	// �A���C�����l���e�L�X�g�`��
	function drawTextWithAlign(tfont=kfont, text=this.text, offx=0, offy=0)
	{
		if (text === void || text == "")
			return;
		// setOptions_sub�Ő��l�ɕϊ������ꍇ������̂ŕ�����ɕϊ�
		text = string(text);
		var lines = text.split(/\[r\]/); // ���s�}�[�N�Ŕz��ɕϊ�
		if (lines.count <= 0)
			return;
		kfont.vertical = vertical;
		if (vertical)
			drawTextWithAlign_subV(tfont, lines, offx, offy);
		else
			drawTextWithAlign_subH(tfont, lines, offx, offy);
	}

	// �X�N���v�g��������A���g���R���e�L�X�g�Ƃ��Ď��s����
	function eval(str)
	{
		if (str === void || str == "")
			return;
		if (str[0] == '&')
			str = str.substr(1);
		// ������ ! ��������A���g���R���e�L�X�g�Ƃ��Ď��s
		if (str[str.length-1] == '!') {
			str = str.substr(0, str.length-1);
			return str!;
		}
		return Scripts.eval(str);
	}

	// �\������Ă�����̂�������x�`��
	function redraw()
	{
		if (graphic === void) {
			// �摜���Ȃ����
			fillRect(0, 0, width, height, color);
		} else if (graphic !== void) {
			// �摜�������
			super.loadImages(graphic, graphickey);
			// �T�C�Y���C���[�W�T�C�Y�ɍ��킹��
			setSizeToImageSize();
		}
		// ����������Ƃ��͕�����`��
		drawTextWithAlign();
	}

	// ���C���g�ɂł��ڂ���`��
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

	// �R�s�[
	function assign(src)
	{
		.KLayer.copyAllMembers(this, src);
		// ��KAGLayer�ɂ�assign()�͂Ȃ��A�Ō�Ɏ��s����K�v����
		super.assignImages(src, true);
	}

	// �Z�[�u���ɏォ��Ă΂��
	function store()
	{
//		var dic = super.store(); �X�[�p�[�N���X�� Layer������s�v
		var dic = %[];
		.KLayer.copyAllMembers(dic, this);
		return dic;
	}

	// ���[�h���ɏォ��Ă΂��
	function restore(dic)
	{
		if (dic === void)
			return;
//		super.restore(dic);	�X�[�p�[�N���X�� Layer������s�v
		.KLayer.setOptions(dic);
		return dic;
	}

	// �t�H�[�J�X�̒��O�ɌĂ΂��
	function onBeforeFocus(layer, blurred, dir)
	{
//dm('onBeforeFocus on KLayer: ' + this);
		if (focusable && enabled && visible) {
			super.onBeforeFocus(layer, blurred, dir);
			return;
		}
		if (blurred == layer)
			return;	// ����Ńt�H�[�J�X�̖������[�v��h���B
				// �������A��ȏ�focusable������΁B
		// ���̃t�H�[�J�X�\���C����T��
		(dir ? nextfocus : prevfocus).focus(dir);
	}
/*
 ���ꂪ����ƁAassign()�������ɂ��O���t�B�b�N��discard����Ă��܂��̂ō폜
	property color {
		setter(x) {
			color_save = x;
			discardImage();	// �摜�𖳌�������color�œh��Ԃ�
		}
		getter {
			return color_save;
		}
	}
�s����*��z�u���Ȃ�  */
/*
redraw()���ĂԂƎq�N���X�Ɉ��e�����o��̂ŁA�Ă΂Ȃ��悤�ɂ���
	// width��property�B�ݒ肳����redraw����
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

	// height��property�B�ݒ肳����redraw����
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

�s����*��z�u���Ȃ�  */

	// �t�H�[�J�X���C����o�����ɐݒ�
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

	// setSize��property�B�ݒ肳����redraw����
	function setSize(w=width, h=height)
	{
		if (w != width || h != height) {
			super.setSize(w, h);
			redraw();
		}
	}
}


// �A�j���[�V���������C��
class KAnimLayer extends KLayer
{
	var classid = "KAnimLayer";	// �萔
//	var name;			// ���O(Layer�N���X���Œ�`�ς䂦�s�v)
	var conductor;			// �A�j���[�V�����̃R���_�N�^
//	var graphic;	// �A�j���[�V�����p�^�[���摜�c�͐e�N���X�Ɋ��ɂ���̂�

	// �R���X�g���N�^
	function KAnimLayer(win, par, i_name="", elm)
	{
		conductor = new AnimationConductor(this);
		super.KLayer(win, par, i_name);
		setOptions(elm);
	}

	// �f�X�g���N�^
	function finalize()
	{
		invalidate conductor;
		super.finalize();
	}

	// conductor��loadImages()���Őݒ肳���̂�setOptions()�͕s�v

	// �A�j���[�V�������~����
	function stopAnim()
	{
		conductor.stop();
	}

	// �C���[�W��ǂݍ��ށBheight�͌�Ŏw�肷�邱��
	function loadImages(graphic, key)
	{
		stopAnim();
		super.loadImages(graphic, key);
		// �A�j���[�V������񂪂���Γǂ�
		loadAnimInfo(graphic);
	}

	// �A�j���[�V�������t�@�C����ǂݍ���
	function loadAnimInfo(graphic)
	{
		startAnim(Storages.chopStorageExt(graphic)+".adf", "");
	}

	// �A�j���[�V�������J�n����
	function startAnim(storage=conductor.curStorage, label)
	{
		stopAnim();
		if (storage !== void && storage != "" &&
		    Storages.isExistentStorage(storage)) {
			// �A�j���[�V������`�t�@�C�������݂���
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

	// �R�s�[
	function assign(src)
	{
		super.assign(src);
		conductor.assign(src.conductor);
	}

	// �Z�[�u
	function store()
	{
		var dic = super.store();
		dic.conductor = conductor.store();
		return dic;
	}

	// ���[�h
	function restore(dic)
	{
		stopAnim();
		if (dic === void)
			return;
		super.restore(dic);	// ���̒��� setOptions(dic) �����s����
		// �ȉ��͋g���g���̃o�O���Ǝv�����ǁA����Ƃ��Ȃ���
		// �u�n�[�h�E�F�A�G���[���������܂����v�ɂȂ��Ă��܂��c�B
		if (dic.conductor.storageName != "")
			conductor.restore(dic.conductor);
		else {
			invalidate conductor;
			conductor = new AnimationConductor(this);
		}
		return dic;
	}

// ��������^�O�n���h�� ------------------------------------------------

	// ������ [s]
	function s(elm)
	{
		// ��~
		elm.context.running = false;
		return -1; // ��~
	}

	// �^�O�n���h�� loadcell() �͉������Ȃ�
	function loadcell()
	{
		// .adf �t�@�C���ɑ��݂������ɃG���[�ɂ��Ȃ����߂̃_�~�[
		return 0;
	}

	// �ǉ��^�O�n���h�� pos(x, y)
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

	// �ǉ��^�O�n���h�� size(w, h)
	function size(elm)
	{
		setSize(str2num(elm.w, width), str2num(elm.h, height));
		return 0;
	}

	// index �l�͈̔͂� 0�`max �ɐ��K������
	function evalidx(cur, max)
	{
		var ret = cur%max;
		return (ret >= 0) ? ret : ret+max;
	}

	// disp�^�O�㏑���n���h��
	function disp(elm)
	{
		var sx = str2num(elm.sx);
		var sy = str2num(elm.sy); // def=0(-imageLeft����Ȃ�) �ɒ���
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

	// �^�O�n���h���ǉ��Aloop
	function loop(elm)
	{
		// ���[�v���邱�Ƃ�錾����
		// �Z�O�����g�ɂ���Ă̓��[�v�����肵�Ȃ������肷�邽�߁B
		elm.context.looping = true;
		return 0;
	}

	// �^�O�n���h���ǉ��Anoloop�Floop�̔��΁B
	function noloop(elm)
	{
		// ���[�v���g��Ȃ����Ƃ�錾����
		// �Z�O�����g�ɂ���Ă̓��[�v�����肵�Ȃ������肷�邽�߁B
		elm.context.looping = false;
		return 0;
	}

	// �^�O�n���h���ǉ� wait
	function wait(elm)
	{
		return elm.time; // �w�莞�Ԃ�����~
	}

// ����AKLayer��eval()�Ƃ��Ԃ�̂ō폜�B����Ȃ�������B
	// �^�O�n���h��
//	function eval(elm)
//	{
//		eval(elm.exp); // elm.exp �����Ƃ��Ď��s
//		return 0;
//	}
}

// KClickableLayer.ncaction�ɓ���萔
var NCACTION_SENDPARENT = 0;	// �}�E�X�C�x���g��e�ɑ���
var NCACTION_NOACTION = 1;	// �}�E�X�C�x���g���̂Ă�


// �{�^���ɂ��g���邪�摜�ω����Ȃ����C��
class KClickableLayer extends KLayer
{
	var classid 		= "KClickableLayer";// �萔

	var countpage 		= true;		// [button]�^�O��countpage�Q��

	var repeatable          = false;	// ���s�[�g�\���ǂ���
	var repeatbutton;			// ���s�[�g���{�^��(�e���|����)
	var repeattimer;			// ���s�[�g����̃^�C�}�[
	var repeatinterval1     = 500;		// ���s�[�g�Ԋu1(����)
	var repeatinterval2     = 100;		// ���s�[�g�Ԋu2

	// �I�v�V�����Q
	// ���{�^���������ꂽ���Ɏg�p����ϐ�
	var onclick;		// �����ꂽ���Ɏ��s���铮��
	var clickse;		// �����ꂽ���ɖ炷��
	var clicksebuf = 0;	// �����ꂽ���ɖ炷���̃o�b�t�@
	var clickstorage;	// �����ꂽ���ɃW�����v����V�i���I�t�@�C��
	var clicktarget;	// �����ꂽ���ɃW�����v����V�i���I���x��

	// �E�{�^���������ꂽ���Ɏg�p����ϐ�
	var onrclick;		// �����ꂽ���Ɏ��s���铮��
	var rclickse;		// �����ꂽ���ɖ炷��
	var rclicksebuf = 0;	// �����ꂽ���ɖ炷���̃o�b�t�@
	var rclickstorage;	// �����ꂽ���ɃW�����v����V�i���I�t�@�C��
	var rclicktarget;	// �����ꂽ���ɃW�����v����V�i���I���x��

	// ���{�^���������ꂽ���Ɏg�p����ϐ�
	var onmclick;		// �����ꂽ���Ɏ��s���铮��
	var mclickse;		// �����ꂽ���ɖ炷��
	var mclicksebuf = 0;	// �����ꂽ���ɖ炷���̃o�b�t�@
	var mclickstorage;	// �����ꂽ���ɃW�����v����V�i���I�t�@�C��
	var mclicktarget;	// �����ꂽ���ɃW�����v����V�i���I���x��

	// ���{�^���������ꂽ���Ɏg�p����ϐ�
	var onrelease;		// �����ꂽ���Ɏ��s���铮��
	var releasese;		// �����ꂽ���ɖ炷��
	var releasesebuf = 0;	// �����ꂽ���ɖ炷���̃o�b�t�@
	var releasestorage;	// �����ꂽ���ɃW�����v����V�i���I�t�@�C��
	var releasetarget;	// �����ꂽ���ɃW�����v����V�i���I���x��

	// �E�{�^���������ꂽ���Ɏg�p����ϐ�
	var onrrelease;		// �����ꂽ���Ɏ��s���铮��
	var rreleasese;		// �����ꂽ���ɖ炷��
	var rreleasesebuf = 0;	// �����ꂽ���ɖ炷���̃o�b�t�@
	var rreleasestorage;	// �����ꂽ���ɃW�����v����V�i���I�t�@�C��
	var rreleasetarget;	// �����ꂽ���ɃW�����v����V�i���I���x��

	// ���{�^���������ꂽ���Ɏg�p����ϐ�
	var onmrelease;		// �����ꂽ���Ɏ��s���铮��
	var mreleasese;		// �����ꂽ���ɖ炷��
	var mreleasesebuf = 0;	// �����ꂽ���ɖ炷���̃o�b�t�@
	var mreleasestorage;	// �����ꂽ���ɃW�����v����V�i���I�t�@�C��
	var mreleasetarget;	// �����ꂽ���ɃW�����v����V�i���I���x��

	var onenter;		// �|�C���^�����������Ɏ��s���铮��
	var enterse;		// �|�C���^�����������ɖ炷��
	var entersebuf = 0;	// �|�C���^�����������ɖ炷���̃o�b�t�@
	var enterstorage; // �|�C���^�����������ɃW�����v����V�i���I�t�@�C��
	var entertarget;  // �|�C���^�����������ɃW�����v����V�i���I���x��

	var onleave;		// �|�C���^���o�����Ɏ��s���铮��
	var leavese;		// �|�C���^���o�����ɖ炷��
	var leavesebuf = 0;	// �|�C���^���o�����ɖ炷���̃o�b�t�@;
	var leavestorage; // �|�C���^���o�����ɃW�����v����V�i���I�t�@�C��
	var leavetarget;  // �|�C���^���o�����ɃW�����v����V�i���I���x��

	// �{�^�������邩�ǂ����A�����Ȃ��{�^���������ꂽ���̓�����`�B
	// default�ł́A�u���N���b�N�����\�A����ȊO�͐e�ɒʒm�v
	var clickablemb = VK_LBUTTON;		// ������{�^��
			// ���_���a�ɂł���̂͋��R�Ȃ񂾂��ǂȁc
	var ncaction    = NCACTION_SENDPARENT;		// ������`

	// �R���X�g���N�^
	function KClickableLayer(win, parent, i_name, elm)
	{
		super.KLayer(win, parent, i_name);
		if(typeof win.cursorPointed !== "undefined")
			cursor = win.cursorPointed;
		hitThreshold = 0;
		focusable = true;	// �t�H�[�J�X�𓾂���

		repeattimer = new Timer(this, "onMouseDownRepeat");
		repeattimer.interval = repeatinterval1;

		setOptions(elm);
	}

	// �f�X�g���N�^
	function finalize()
	{
		repeattimer.enabled = false;
		invalidate repeattimer;
		super.finalize(...);
	}

	// ���̃��C�����[�J���̃����o���R�s�[
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

	// ����ȉ��̑S�Ẵ����o���R�s�[����
	function copyAllMembers(dst, src)
	{
		super.copyAllMembers(dst, src);
		.KClickableLayer.copyLocalMembers(dst, src);
	}

	// �I�v�V������ݒ�
	function setOptions(elm)
	{
		if (elm === void)
			return;
		if (elm.exp !== void)	// onrelease��exp�ƑS������
			elm.onrelease = elm.exp;
		if (elm.storage !== void)
			elm.releasestorage = elm.storage;
		if (elm.target !== void)
			elm.releasetarget = elm.target;

		// �e���C���ɃI�v�V�����w��
		super.setOptions(elm);
		.KClickableLayer.copyLocalMembers(this, elm);

		// *storage/*target�݂̂��w�肳�ꂽ��A*target/*storage��void��
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

	// ���݂̃}�E�X�{�^����click�Ɣ��f�\���ǂ���
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

	// (�{�^���N���b�N���Ȃǂ�)�T�E���h��炷�B
	function playSound(sndfile, buf = 0)
	{
		if (sndfile === void || sndfile == "")
			return;
		kag.se[buf].play(%[storage:sndfile]);
	}

	// KAG�̃V�i���I�W�����v
	function jumpSenario(storage, target, countpage)
	{
		if (storage !== void || target !== void)
			window.process(storage, target, countpage); 
	}

	// �}�E�X�������ꂽ�ꍇ
	function onMouseDown(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		// super/�e��onMouseDown()���ĂԂƍŏI�I��onPrimaryClick��
		// �Ȃ�̂ŌĂ΂Ȃ�

		// �{�^�����ƂɕʁX�Ɏw��̓����������
		if (button == mbLeft) {
			if (!(clickablemb & VK_LBUTTON)) {
				if (ncaction == NCACTION_SENDPARENT)
					parent.onMouseDown(x+left,y+top,button,shift);
				return;
			}
			playSound(clickse, clicksebuf);
			eval(onclick);	// void �`�F�b�N�͂��̒���
			jumpSenario(clickstorage, clicktarget, countpage);
		} else if (button == mbRight) {
			if (!(clickablemb & VK_RBUTTON)) {
				if (ncaction == NCACTION_SENDPARENT)
					parent.onMouseDown(x+left,y+top,button,shift);
				return;
			}
			playSound(rclickse, rclicksebuf);
			eval(onrclick);	// void �`�F�b�N�͂��̒���
			jumpSenario(rclickstorage, rclicktarget, countpage);
		} else /* if (button == mbMiddle) */ {
			if (!(clickablemb & VK_MBUTTON)) {
				if (ncaction == NCACTION_SENDPARENT)
					parent.onMouseDown(x+left,y+top,button,shift);
				return;
			}
			playSound(mclickse, mclicksebuf);
			eval(onmclick);	// void �`�F�b�N�͂��̒���
			jumpSenario(mclickstorage, mclicktarget, countpage);
		}
		// �����ɂ����Ƃ��̓{�^��������Ă��邱�Ɗm��
		if (repeatable) {
			repeattimer.enabled  = true;
			repeatbutton = button;
		}
	}

	// �}�E�X��������ςȂ��̎��̃��s�[�g�֐�
	function onMouseDownRepeat()
	{
		onMouseDown(cursorX, cursorY, repeatbutton, 0);
		repeattimer.interval = repeatinterval2;
	}

	// �}�E�X�������ꂽ�ꍇ
	function onMouseUp(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		repeattimer.enabled  = false;
		repeattimer.interval = repeatinterval1;

//		super.onMouseUp(...); // parent.onMouseUp()�����s���Ȃ��悤��

		// �{�^�����ƂɕʁX�Ɏw��̓����������
		if (button == mbLeft) {
			if (!(clickablemb & VK_LBUTTON)) {
				if (ncaction == NCACTION_SENDPARENT)
					parent.onMouseUp(x+left,y+top,button,shift);
				return;
			}
			playSound(releasese, releasesebuf);
			eval(onrelease);	// void �`�F�b�N�͂��̒���
			// �u�^�C�g���ɖ߂�v�̎��͂�����return���Ȃ��ƃG���[��
			// �Ȃ����Ⴄ���ǁc�ǂ�����B
			jumpSenario(releasestorage, releasetarget, countpage);
		} else if (button == mbRight) {
			if (!(clickablemb & VK_RBUTTON)) {
				if (ncaction == NCACTION_SENDPARENT)
					parent.onMouseUp(x+left,y+top,button,shift);
				return;
			}
			playSound(rreleasese, rreleasesebuf);
			eval(onrrelease);	// void �`�F�b�N�͂��̒���
			jumpSenario(rreleasestorage, rreleasetarget,countpage);
		} else /* if (button == mbMiddle) */ {
			if (!(clickablemb & VK_MBUTTON)) {
				if (ncaction == NCACTION_SENDPARENT)
					parent.onMouseUp(x+left,y+top,button,shift);
				return;
			}
			playSound(mreleasese, mreleasesebuf);
			eval(onmrelease);	// void �`�F�b�N�͂��̒���
			jumpSenario(mreleasestorage, mreleasetarget,countpage);
		}
	}

//	// �Ȃ�ł������łȂ�onMouseDown()�g���Ă�񂾂����c�B���͉������Ȃ�
//	// onClick()��mouseUp���ɓ�������A���������Ȃ��B
//	function onClick()
//	{
//		super.onClick(...);
//	}

	// �}�E�X����������
	function onMouseEnter()
	{
		super.onMouseEnter(...);
		playSound(enterse, entersebuf);
		eval(onenter);	// void �`�F�b�N�͂��̒���
		jumpSenario(enterstorage, entertarget, countpage);
	}

	// �}�E�X���o����
	function onMouseLeave()
	{
		super.onMouseLeave(...);
		window.focusedLayer = null;

		playSound(leavese, leavesebuf);
		eval(onleave);	// void �`�F�b�N�͂��̒���
		jumpSenario(leavestorage, leavetarget, countpage);
	}

	// �t�H�[�J�X���ꂽ��
	function onFocus(focused, direction)
	{
		super.onFocus(...); // parent.onMouseUp()�����s���Ȃ��悤��
		// �}�E�X�����ꂽ�������߂ăt�H�[�J�X�����̂ŁA����͏Ȃ�
		if (0 <= cursorX && cursorX < width &&
		    0 <= cursorY && cursorY < height)
			return;
		// �L�[�������ꂽ���̂݃t�H�[�J�X����̂ŁA�����łȂ���ΏȂ�
		var gks = window.getKeyState;
		if (!gks(VK_LEFT) && !gks(VK_UP) && !gks(VK_RIGHT) &&
		    !gks(VK_DOWN) && !gks(VK_TAB))
			return;

		// �}�E�X�����g�̒��S�Ɉړ�����B�����onMouseEnter�̉摜�ɂȂ�
		setCursorPos(width\2, height\2);
	}

	// �L�[�������ꂽ��(animbutton�ł܂����܂������ĂȂ�)
	function onKeyDown(key, shift, process)
	{
		if (process && (key == VK_RETURN || key == VK_SPACE)) {
			// �X�y�[�X�L�[�܂��̓G���^�[�L�[�������ꂽ��
			// ������mouse�������ꂽ���Ƃɂ���
			onMouseDown(width\2, height\2, mbLeft, shift);
			super.onKeyDown(key, shift, false);
		} else {
			super.onKeyDown(...);
		}
	}

	// �L�[�������ꂽ��(animbutton�ł܂����܂������ĂȂ�)
	function onKeyUp(key, shift, process)
	{
		if (process && (key == VK_RETURN || key == VK_SPACE)) {
			// �X�y�[�X�L�[�܂��̓G���^�[�L�[�������ꂽ��
			// ������mouse�������ꂽ���Ƃɂ���
			onMouseUp(width\2, height\2, mbLeft, shift);
			super.onKeyUp(key, shift, false);
		} else {
			super.onKeyUp(...);
		}
	}

	// ���C���[�̃R�s�[
	function assign(src)
	{
		super.assign(src);
		.KClickableLayer.copyLocalMembers(this, src);
	}

	// �Z�[�u���ɏォ��Ă΂��
	function store()
	{
		var dic = super.store();
		.KClickableLayer.copyLocalMembers(dic, this);
		return dic;
	}

	// ���[�h���ɏォ��Ă΂��
	function restore(dic)
	{
		if (dic === void)
			return;
		.KClickableLayer.setOptions(dic);
		return dic;
	}
}


// �{�^���Q�̋��ʃ��C��
// 0.99����A�����̎��Ɖ摜�̎��Ƃŋ�ʂ��Ȃ��悤�ɂȂ�AButt_imageLoaded�폜
class KButtonLayer extends KClickableLayer
{
	var classid 		= "KButtonLayer";// �萔

	var Butt_mouseOn    = false;		// ���C�����Ƀ}�E�X�����邩
	var Butt_mouseDown  = false;		// �}�E�X�{�^����������Ă��邩
//	var color           = 0xff404040;	// ���ɑ��݂��邩��s�v
	var entercolor      = 0xff909090;	// �}�E�X�����������̐F
	var clickcolor      = 0xffd0d0d0;	// �}�E�X���N���b�N���ꂽ���̐F
	var disablecolor    = 0x80606060;	// �����Ȃ����̐F
	var Butt_keyPressed = false;	// �L�[��������Ă��邩�ǂ����̏��

//	var kfont;		��`�ς�	// �ʏ펞�̃t�H���g
	var enterfont;				// �}�E�X�I�����̃t�H���g
	var clickfont;				// �N���b�N���̃t�H���g
	var disablefont;			// �������̃t�H���g

	var normalgraphic;			// �}�E�X������Ă��Ȃ����̉摜
	var clickgraphic;			// �}�E�X�������ꂽ���̉摜
	var entergraphic;			// �}�E�X����������̉摜
	var disablegraphic;			// �������̉摜

	// �R���X�g���N�^
	function KButtonLayer(win, parent, i_name, elm)
	{
		super.KClickableLayer(win, parent, i_name);

//		kfont       = new KFont();	// ��`�ς�
		enterfont   = new KFont();	// ��ɃI�v�V�����ݒ肵�Ƃ�
		clickfont   = new KFont();
		disablefont = new KFont();

		setDefaultFont(elm);
		setOptions(elm);
	}

	// �F�ƃt�H���g�ݒ�p(�R���X�g���N�^����̂݌Ă΂��)
	function setDefaultFont(elm)
	{
		kfont.setOptions(elm.kfont) if (elm !== void);
		// �ق��̃t�H���g�̓f�t�H���g��kfont�Ɠ����ɂ���
		enterfont  .assign(kfont);
		clickfont  .assign(kfont);
		disablefont.assign(kfont);

		// �f�t�H���g�ł̓t�H���g�͑S�ē����Adisable����������ƈÂ�
		var c = +kfont.color;
		c = (c&0xfe0000)/2 + (c&0x00fe00)/2 + (c&0x0000fe)/2;
		disablefont.setOptions(%[color:c]);
	}

	// �f�X�g���N�^
	function finalize()
	{
		invalidate enterfont;
		invalidate clickfont;
		invalidate disablefont;
		super.finalize(...);
	}

	// ���̃��C�����[�J���̃����o���R�s�[
	function copyLocalMembers(d, s)
	{
		if (d === void || s === void)
			return;

		d.Butt_mouseOn  = +s.Butt_mouseOn if (s.Butt_mouseOn !== void);
		d.Butt_mouseDown=+s.Butt_mouseDown if(s.Butt_mouseDown!==void);

		// ��������F�ݒ�
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
//color�Ɠ����Ȃ̂ŕs�v	d.normalcolor = s.normalcolor if(s.normalcolor!==void);

		// ��������t�H���g�ݒ�
//�s�v		d.kfont       = %[] if (d.kfont       === void);
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

	// ���̃��C���ȉ��̑S�Ẵ����o���R�s
	function copyAllMembers(dst, src)
	{
		super.copyAllMembers(dst, src);
		.KButtonLayer.copyLocalMembers(dst, src);
	}

	// �I�v�V������ݒ�
	function setOptions(elm)
	{
		if (elm === void)
			return;
		super.setOptions(elm);
		.KButtonLayer.copyLocalMembers(this, elm);
		redraw();
	}

	// graphic�̂Ȃ��{�^����������`��(�c�����͊��Ɍ��܂��Ă���Ƃ���)
	function drawButtonWithoutGraphic_one(xidx, rugged, color, font, text)
	{
		fillRect(width*xidx, 0, width, height, color);
		if (rugged == true || rugged == false)    // enabled!=t/f�ł�
			drawRuggedness(rugged,  width*xidx); //rugged��`���Ȃ�
		drawTextWithAlign(font, text, width*xidx, 0);
	}

	// graphic�̂Ȃ��{�^����`��
	function drawButtonWithoutGraphic()
	{
		var w = width, h = height;
		setImagePos(0, 0);
		setSize(w, h);
		setImageSize(w * 3, h);

		if (enabled)
			drawButtonWithoutGraphic_one(0, true, normalcolor,  normalfont,  text);
		else			//���̒l��t/f�Ł��Ȃ���΂Ȃ�ł��悢
			drawButtonWithoutGraphic_one(0, -100, disablecolor, disablefont, text);
		drawButtonWithoutGraphic_one(1, false, clickcolor,  clickfont,  text);
		drawButtonWithoutGraphic_one(2, true,  entercolor,  enterfont,  text);
	}

	// �{�^����`��
	function redraw()
	{
		drawButton();
	}

	// �{�^����`��
	function drawButton()
	{
		// ����ŉ摜�����낤���Ȃ��낤���{�^�����`�悳���
		.KButtonLayer.loadImages();
	}

	// �{�^���摜��ǂݍ���... �����摜��ǂݍ��݁A�z�u����
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
		// �ǂݍ��񂾉摜��Ƀt�H���g�ŕ�����`��
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

	// �摜��ǂݍ���
	function loadImages(g=graphic, key=graphickey, ng=normalgraphic, cg=clickgraphic, eg=entergraphic, dg=disablegraphic)
	{
		var wflg = false;
		// �ŏ��ɉ摜�Ȃ���Ԃɂ��Ă���
		discardImage();
		graphic        = (g   == "") ? void : g   if (g   !== void);
		normalgraphic  = (ng  == "") ? void : ng  if (ng  !== void);
		clickgraphic   = (cg  == "") ? void : cg  if (cg  !== void);
		entergraphic   = (eg  == "") ? void : eg  if (eg  !== void);
		disablegraphic = (dg  == "") ? void : dg  if (dg  !== void);
		graphickey     = (key == "") ? void : key if (key !== void);

		// graphic�����͉������Ⴄ�̂œ��ʈ���
		wflg = loadSubImage(graphic,        , 0, wflg, 3);
		wflg = loadSubImage(normalgraphic,  , 0, wflg);
		wflg = loadSubImage(clickgraphic,   , 1, wflg);
		wflg = loadSubImage(entergraphic,   , 2, wflg);
		wflg = loadSubImage(disablegraphic, , 0, wflg) if (!enabled);

		if (!wflg) {
			// �摜���w�肳��Ă��Ȃ�������e�L�X�g�\�����ďI���
			drawButtonWithoutGraphic();
			return;
		}
	}

	// �摜��j������
	function discardImage()
	{
		super.discardImage();
		drawButtonWithoutGraphic();
	}

	// �}�E�X�������ꂽ�ꍇ
	function onMouseDown(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		if (isMbClickable(button)) {
			Butt_mouseDown = true;
			update();
		}
		super.onMouseDown(...);
	}

	// �}�E�X�������ꂽ�ꍇ
	function onMouseUp(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		if (isMbClickable(button)) {
			Butt_mouseDown = false;
			update();
		}
		super.onMouseUp(...);
	}

	// �Ȃ�ł������łȂ�onMouseDown()�g���Ă�񂾂����c�B���͉������Ȃ�
	// onClick()��mouseUp���ɓ�������A���������Ȃ��B
//	function onClick()
//	{
//		super.onClick(...);
//	}

	// ���݂̏�Ԃɂ��킹�ĕ`����s��
	function drawState()
	{
		if(!enabled)
			imageLeft = 0 * width;	// ������Ԃ����ɕ`�悳��Ă���
		else if (Butt_mouseDown)
			imageLeft = -1 * width;	// �}�E�X�����ꂽ���
		else if (Butt_mouseOn)
			imageLeft = -2 * width;	// �}�E�X����������
		else 
			imageLeft = 0 * width;	// �}�E�X����Ă��Ȃ����
	}

	// �`��̒��O�ɌĂ΂��
	function onPaint()
	{
		super.onPaint(...);
		drawState();
	}

	// �}�E�X����������
	function onMouseEnter()
	{
		Butt_mouseOn = true;
		update();
		super.onMouseEnter(...);
	}

	// �}�E�X���o����
	function onMouseLeave()
	{
		Butt_mouseOn = false;
		Butt_mouseDown = false;
		update();
		super.onMouseLeave(...);
	}

	// ���C���̃m�[�h���s�ɂȂ���
	function onNodeDisabled()
	{
		super.onNodeDisabled(...);
		Butt_mouseDown = false;
		update();
	}

	// ���C���̃m�[�h���L���ɂȂ���
	function onNodeEnabled()
	{
		super.onNodeEnabled(...);
		update();
	}

	// �L�[�������ꂽ��(animbutton�ł܂����܂������ĂȂ�)
	function onKeyDown(key, shift, process)
	{
		if (process && (key == VK_RETURN || key == VK_SPACE))
			Butt_keyPressed = true;
		super.onKeyDown(...);
	}

	// �L�[�������ꂽ��(animbutton�ł܂����܂������ĂȂ�)
	function onKeyUp(key, shift, process)
	{
		if (process && (key == VK_RETURN || key == VK_SPACE))
			Butt_keyPressed = false;
		super.onKeyUp(...);
	}

/*�e�����o�ɂ��閼�O��property�͍��Ȃ��炵���c�B�������B
	property text
	{
		setter(x) {
			super.text = x;
			loadImages();	// �ĕ`�悷��
		}
		getter {
			var ret = super.text;
			return ret; // �Ȃ��������ŃG���[�ɂȂ�
		}
	}
�s����*��z�u���Ȃ�  */

/*
//width/height��ύX����ƃO���t�B�b�N�������ɂȂ�̂͌��\�h���̂Ŏg�p���Ȃ�
	property width
	{
		setter(x) {
			if (super.width == x)	// �����Ȃ牽�����Ȃ�
				return;

			super.width = 1;
			imageWidth = x * 3;
			super.width = x;

			// width���w�肳�ꂽ��A����͉摜��S���폜���鍇�}�I
			graphic        = void;
			normalgraphic  = void;
			clickgraphic   = void;
			entergraphic   = void;
			disablegraphic = void;
			drawButtonWithoutGraphic();	// �����ōĕ`�悷��
		}
		getter {
			return super.width;
		}
	}

	property height
	{
		setter(y) {
			if (super.height == y)	// �����Ȃ牽�����Ȃ�
				return;

			super.height = 1;
			imageHeight = y;
			super.height = y;

			// height���w�肳�ꂽ��A����͉摜��S���폜���鍇�}�I
			graphic        = void;
			normalgraphic  = void;
			clickgraphic   = void;
			entergraphic   = void;
			disablegraphic = void;
			drawButtonWithoutGraphic();	// �����ōĕ`�悷��
		}
		getter {
			return super.height;
		}
	}
�s����*��z�u���Ȃ�  */

	property enabled
	{
		setter(x) {
			if (super.enabled == x)	// �����Ȃ牽�����Ȃ�
				return;
			super.enabled = x;
			drawButton();	// �ݒ�l���������`������
		}
		getter {
			return super.enabled;
		}
	}

	// normalcolor�Ƃ��������o����邽�߂����ɁA�v���p�e�B�쐬
	property normalcolor
	{
		setter(x) {
			color = x;
		}
		getter {
			return color;
		}
	}

	// normalfont�Ƃ��������o����邽�߂����ɁA�v���p�e�B�쐬
	property normalfont
	{
		setter(x) {
			kfont.assign(x);
		}
		getter {
			return kfont;
		}
	}

	// �{�^���̃R�s�[
	function assign(src)
	{
		super.assign(src);
		.KButtonLayer.copyLocalMembers(this, src);
		Butt_mouseOn = false;
		// ���g�����W�V�����O��ŁAKRadioButtonItem��Butt_mouseOn��
		// �}�E�X�̓��C���O�ɏo�Ă�̂�true�̂܂܂ɂȂ邱�Ƃ��������̂�
		// ������Butt_mouseOn�������I��false�ɂ���B���ɃJ�b�R��������
		// ���A�Ȃ��������
	}

	// �Z�[�u���ɏォ��Ă΂��
	function store()
	{
		var dic = super.store();
		.KButtonLayer.copyLocalMembers(dic, this);
		return dic;
	}

	// ���[�h���ɏォ��Ă΂��
	function restore(dic)
	{
		if (dic === void)
			return;
		.KButtonLayer.setOptions(dic);
		return dic;
	}
}


// �A�j���[�V�����������N�{�^�����C��(AnimationButtonLayer�̏Ă�����)
class KAnimButtonLayer extends KButtonLayer
{
	var classid    = "KAnimButtonLayer";	// �萔
	// �A�j���[�V�����{�^���̒ǉ�����
	var conductor;		// �A�j���[�V�����̃R���_�N�^
	var maxpatternnum = 1;	// ���݂̃A�j���[�V�����Z���ő吔

	// �R���X�g���N�^
	function KAnimButtonLayer(win, parent, i_name, elm)
	{
		conductor = new AnimationConductor(this);
		super.KButtonLayer(win, parent, i_name);
		setDefaultFont(elm);	// KButtonLayer�̂��Ă�
		setOptions(elm);
	}

	// �f�X�g���N�^
	function finalize()
	{
		stopAnim();
		super.finalize(...);
		// �Ō�� invalidate ���������AstopAnim()�ŃG���[�o�Ȃ�
		invalidate conductor;
	}

	// ���̃��C�����[�J���̃����o���R�s�[
	function copyLocalMembers(dst, src)
	{
		if (dst === void || src === void)
			return;
		// conductor�� loadImages()�œǂ܂��̂ŕs�v��������
		if (dst.conductor === void)
			dst.conductor = %[];
		if (dst.conductor instanceof "AnimationConductor") {
			if (src.conductor !== void)
				if (src.conductor instanceof "AnimationConductor")
					dst.conductor.assign(src.conductor);
				else {
				// �ȉ��͋g���g���̃o�O�����ǁA����Ƃ��Ȃ���
				// �u�n�[�h�E�F�A�G���[���������܂����v�ɂȂ�
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

	// ���̃��C���ȉ��̑S�Ẵ����o���R�s�[
	function copyAllMembers(dst, src)
	{
		super.copyAllMembers(dst, src);
		.KAnimButtonLayer.copyLocalMembers(dst, src);
	}

	// �I�v�V������ݒ�
	function setOptions(elm)
	{
		if (elm === void)
			return;
		super.setOptions(elm);
		.KAnimButtonLayer.copyLocalMembers(this, elm);
		// loadImages() �̌�� height �����ݒ肷��
		height = +elm.height if (elm.height !== void);
		redraw();
	}

	// �A�j���[�V�������~����
	function stopAnim(resetidx=true)
	{
//�����̂ł́Hif (conductor !== void)	// �h���N���X����loadImages()�̎�void
			conductor.stop();
		imageTop = 0 if (resetidx);
	}

	// �A�j���[�V�������t�@�C����ǂݍ���
	function loadAnimInfo(graphic)
	{
		startAnim(Storages.chopStorageExt(graphic)+".bsd", "");
	}

	// �A�j���[�V�������J�n����
	function startAnim(storage=conductor.curStorage, label)
	{
		stopAnim(false);	// idx�̓��Z�b�g���Ȃ�
		if (storage !== void && storage != "" && 
		    Storages.isExistentStorage(storage)) {
			// �A�j���[�V������`�t�@�C�������݂���
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

	// �C���[�W��ǂݍ��ށB���̌�ɓK���� height �ɒ������邱��
	function loadImages(g, key, kg, ng, cg, eg, dg, newheight)
	{
		stopAnim();
// ToDo: ���ꂪ����� slidertab������������Ă��܂��c�����s���A��Œǋ����邱��
//		.KAnimButtonLayer.discardImage();
		super.loadImages(g, key, kg, ng, cg, eg, dg);
		if (newheight !== void)
			height = newheight;
		maxpatternnum = imageHeight \ height;
		// �A�j���[�V������񂪂���Γǂ�
		loadAnimInfo(graphic);
	}

	// �C���[�W��j������
	function discardImage()
	{
		stopAnim();
		super.discardImage();
		maxpatternnum = 1;
	}

	// �N���b�N���̓���
	function onMouseDown(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		startAnim(, '*onclick');	// "*onclick"����A�j���J�n
		super.onMouseDown(...);
	}

	// �}�E�X�������ꂽ�ꍇ
	function onMouseUp(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		startAnim(, '*onenter');
		super.onMouseUp(...);
	}

	// �}�E�X����������
	function onMouseEnter()
	{
//dm('onMouseEnter on KAnimButton: ' + this);
		startAnim(, '*onenter');	// "*onenter"����A�j���J�n
		super.onMouseEnter(...);
	}

	// �}�E�X���o����
	function onMouseLeave()
	{
//dm('onMouseLeave on KAnimButton: ' + this);
		startAnim(, '*normal');	// "*normal"����A�j���J�n
		super.onMouseLeave(...);
	}

	// �t�H�[�J�X(unclicked focus)���ꂽ��
	function onFocus(focused, direction)
	{
//dm('onFocus on KAnimButton: ' + this);
		startAnim(, '*onenter');
		super.onFocus(...);
	}

	// �t�H�[�J�X(unclicked focus)����������
	function onBlur()
	{
//dm('onBlur on KAnimButton: ' + this);
		startAnim(, '*normal');
		super.onBlur(...);
	}

	// �{�^���̃R�s�[
	function assign(src)
	{
		super.assign(src);
		.KAnimButtonLayer.copyLocalMembers(this, src);
	}


// ------ ��������A�j���[�V������`�t�@�C��(.bsd)�̃^�O�n���h�� --------------
// �w��KAnimLayer��.adf �Ɠ����Ȃ񂾂��ǁc���܂������ł��Ȃ������̂ŁB

	// ������ [s]
	function s(elm)
	{
		// ��~
		elm.context.running = false;
		return -1; // ��~
	}

	// �^�O�n���h�� loadcell() �͉������Ȃ�
	function loadcell()
	{
		// .bsd �t�@�C���ɑ��݂������ɃG���[�ɂ��Ȃ����߂̃_�~�[
		return 0;
	}

	// �ǉ��^�O�n���h�� pos(x, y)
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

	// �ǉ��^�O�n���h�� size(w, h)
	function size(elm)
	{
		setSize(str2num(elm.w, width), str2num(elm.h, height));
		return 0;
	}

	// index �l�͈̔͂� 0�`max �ɐ��K������
	function evalidx(cur, max)
	{
		var ret = cur%max;
		return (ret >= 0) ? ret : ret+max;
	}

	// disp�^�O�㏑���n���h��
	function disp(elm)
	{
//		var sx = str2num(elm.sx); // �������ʒu�␳�̓X�L�b�v
		var sy = str2num(elm.sy); // def=0(-imageLeft����Ȃ�) �ɒ���
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
		setImagePos(imageLeft, -(sy));	// �������������͕ύX���Ȃ�
		return 0;
	}

	// �^�O�n���h���ǉ��Aloop
	function loop(elm)
	{
		// ���[�v���邱�Ƃ�錾����
		// �Z�O�����g�ɂ���Ă̓��[�v�����肵�Ȃ������肷�邽�߁B
		elm.context.looping = true;
		return 0;
	}

	// �^�O�n���h���ǉ��Anoloop�Floop�̔��΁B
	function noloop(elm)
	{
		// ���[�v���g��Ȃ����Ƃ�錾����
		// �Z�O�����g�ɂ���Ă̓��[�v�����肵�Ȃ������肷�邽�߁B
		elm.context.looping = false;
		return 0;
	}

	// �^�O�n���h���ǉ� wait
	function wait(elm)
	{
		return elm.time; // �w�莞�Ԃ�����~
	}

// ------ �������烍�[�h�E�Z�[�u ----------------------------------------

	// �Z�[�u���ɏォ��Ă΂��
	function store()
	{
		var dic = super.store();
		.KAnimButtonLayer.copyLocalMembers(dic, this);
		return dic;
	}

	// ���[�h���ɏォ��Ă΂��
	function restore(dic)
	{
		stopAnim();
		if (dic === void)
			return;
		.KAnimButtonLayer.setOptions(dic);

/* �ȑO��
		super.restore(dic);	// ���̒��� setOptions(dic) �����s����
		// �ȉ��͋g���g���̃o�O���Ǝv�����ǁA����Ƃ��Ȃ���
		// �u�n�[�h�E�F�A�G���[���������܂����v�ɂȂ��Ă��܂��c�B
		if (dic.conductor.storageName != "")
			conductor.restore(dic.conductor);
		else {
			invalidate conductor;
			conductor = new AnimationConductor(this);
		}
�s����*��z�u���Ȃ�  */
		return dic;
	}
}


// �g�O���{�^�����C���[
// released/checked/checkedonmouse�̎O��Ԃ�\��
class KToggleButtonLayer extends KAnimButtonLayer
{
	var classid = "KToggleButtonLayer";

	// oncheck/onuncheck�́AonMouseUp()�̎��Ɏ��s�����BonMouseDown()��
	// ���s����ƁAWindow/FullScreen �؂�ւ���������� onMouseUp()�C�x���g
	// �����������A�؂�ւ���Ƀ{�^���X�e�[�^�X�����������Ȃ邽�߁B
	// �g���g���̃o�O���Ǝv���c�B

	var checked = false;	// �`�F�b�N����Ă��邩�ǂ���
	var oncheck;		// check ���ꂽ���ɌĂ΂�� TJS �֐�
	var checkse;		// check ���ꂽ���ɖ炷��
	var checksebuf = 0;	// �����ꂽ���ɖ炷���̃o�b�t�@
	var checkstorage;	// check ���ꂽ���ɌĂ΂�� KAG �X�g���[�W
	var checktarget;	// check ���ꂽ���ɌĂ΂�� KAG target
	var onuncheck;		// uncheck ���ꂽ���ɌĂ΂�� TJS �֐�
	var uncheckse;		// check ���ꂽ���ɖ炷��
	var unchecksebuf = 0;	// �����ꂽ���ɖ炷���̃o�b�t�@
	var uncheckstorage;	// uncheck �̎��ɌĂ΂�� KAG �X�g���[�W
	var unchecktarget;	// uncheck �̎��ɌĂ΂�� KAG target
	var stateval;		// check��Ԃ�ۑ�����ϐ��𕶎���Ŏw�肷��

	// �R���X�g���N�^
	function KToggleButtonLayer(window, parent, name, elm)
	{
		super.KAnimButtonLayer(window, parent, name);
		setDefaultFont(elm);	// KButtonLayer�̂��Ă�
		setOptions(elm);
	}

	// �f�X�g���N�^
	function finalize()
	{
		super.finalize();
	}

	// ���̃��C�����[�J���̃����o���R�s�[
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

	// ���̃��C���̑S�Ẵ����o���R�s�[
	function copyAllMembers(dst, src)
	{
		super.copyAllMembers(dst, drc);
		.KToggleButtonLayer.copyLocalMembers(dst, drc);
	}

	// �I�v�V�����ݒ�
	function setOptions(elm)
	{
		if (elm === void)
			return;
		var e = %[];
		(Dictionary.assign incontextof e)(elm);
		// exp,storage,target��oncheck�ɑ΂�����̂Ȃ̂Őݒ�
		if (e.exp !== void)
			e.oncheck = e.exp, delete e.exp;
		if (e.storage !== void)
			e.checkstorage = e.storage, delete e.storage;
		if (e.target !== void)
			e.checktarget = e.target, delete e.target;
		var c = e.checked;	// checked�͓��ʈ�������
		delete e.checked;
		if (e.stateval !== void)
			c = eval(e.stateval); // void�`�F�b�N���Ă邯��c�̂���
		super.setOptions(e);
		.KToggleButtonLayer.copyLocalMembers(this, e);

		// �������Ȃ���graphic�ƈꏏ�Ɏw�肵�����ɗ̈�O�G���[�ɂȂ�
		if (c !== void && +c != checked)
			simpleStateChange(+c);
	}

	// �摜�ǂݍ���
	function loadImages(graphic, key)
	{
		if (graphic === void)
			return;
		super.loadImages(...);
	}

	// ��Ԃ�ύX����(�{�^����Ԋm�F�A���Đ��A�X�N���v�g���s�Ȃ�)
	function simpleStateChange(state)
	{
		state = +state;
		checked = state; // �����`�F�b�N���ɂ��ĂԂ̂Ńt���Oon�K�v
		if (stateval !== void)
			eval(stateval + ' = ' + state);
		if (state)
			startAnim(, "*oncheck");
		else
			startAnim(, Butt_mouseOn ? "*onuncheck" : "*onenter");
		drawState();
	}

	// �`�F�b�N���ꂽ���ɌĂ΂��(makeCheck()�����˂�)
	function onCheck()
	{
		if (checked)	// ������Ă����͉������Ȃ�
			return;
		simpleStateChange(true);

		playSound(checkse, checksebuf);
		eval(oncheck);	// void �`�F�b�N�͂��̒���
		jumpSenario(checkstorage, checktarget, countpage);
	}

	// �`�F�b�N���������ꂽ���ɌĂ΂��(makeCheck()�����˂�)
	function onUncheck()
	{
		if (!checked)	// ������ĂȂ��������͉������Ȃ�
			return;
		simpleStateChange(false);

		playSound(uncheckse, unchecksebuf);
		eval(onuncheck);	// void �`�F�b�N�͂��̒���
		jumpSenario(uncheckstorage, unchecktarget, countpage);
	}

	// �}�E�X�������ꂽ��
	function onMouseDown(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		super.onMouseDown(...);
		// �\����Ԃ����ύX���� checked �̃X�N���v�g�͎��s���Ȃ�
	}

	// �}�E�X�������ꂽ��
	function onMouseUp(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		super.onMouseUp(...);
		if (button != mbLeft) // ���N���b�N�ȊO�͖���
			return;
		if (!checked)
			onCheck();	// �`�F�b�N���ꂽ
		else
			onUncheck();// �`�F�b�N�������ꂽ
	}

	// �}�E�X����������
	function onMouseEnter()
	{
		if (checked)
			startAnim(, "*onenter"); // �`�F�b�N���̂�*onenter�J�n
		.KButtonLayer.onMouseEnter(...);
	}

	// �}�E�X���o����
	function onMouseLeave()
	{
		if (checked)
			startAnim(, "*oncheck");// �`�F�b�N���̂�*oncheck�J�n
		.KButtonLayer.onMouseLeave(...);
	}

	// ���݂̏�Ԃɂ��킹�ĕ`����s��(onPaint()����Ă΂��)
	function drawState()
	{
		// check ����Ă�� 1, check�łȂ���� 0
		if(!enabled)
			imageLeft = 0 * width;	// ������Ԃ͊��ɕ`�悳��Ă���
		else if (checked || Butt_mouseDown)
			imageLeft = -1 * width;	// �}�E�X�����ꂽ���
		else if (Butt_mouseOn)
			imageLeft = -2 * width;	// �}�E�X����������
		else 
			imageLeft = 0 * width;	// �}�E�X����Ă��Ȃ����
	}

	// �{�^���̃R�s�[
	function assign(src)
	{
		super.assign(src);
		.KToggleButtonLayer.copyLocalMembers(this, src);
	}

	// �Z�[�u���ɏォ��Ă΂��
	function store()
	{
		var dic = super.store();
		.KToggleButtonLayer.copyLocalMembers(dic, this);
		return dic;
	}

	// ���[�h���ɏォ��Ă΂��
	function restore(dic)
	{
		if (dic === void)
			return;
		.KToggleButtonLayer.setOptions(dic);
//		super.restore(dic);	// ���̒��� setOptions(dic) �����s����
		return dic;
	}
}


// �`�F�b�N�{�b�N�X�̓��ɓ\��togglebutton�A�e�ɃC�x���g�𑗂�悤������Ɖ���
class KCheckBoxTopLayer extends KToggleButtonLayer
{
	var classid = "KCheckBoxTopLayer";

	// �R���X�g���N�^
	function KCheckBoxTopLayer(window, parent, name, elm)
	{
		super.KToggleButtonLayer(window, parent, name);
		focusable = false;	// ����̓t�H�[�J�X����Ȃ�(�e�������)
		setDefaultFont(elm);	// KButtonLayer�̂��Ă�
		setOptions(elm);
	}

	// �f�X�g���N�^
	function finalize()
	{
		super.finalize();
	}

	// �C���[�W�ǂݍ���
	function loadImages()
	{
		super.loadImages(...);
		// �e�̃T�C�Y�������ɍ��킹��
		parent.setSize(width, height);
	}

	// �`�F�b�N���ꂽ���ɌĂ΂��(makeCheck()�����˂�)
	function onCheck()
	{
		super.onCheck(...);
//		parent.onCheck(...);	// �e�ɂ͂��̊֐�����ĂȂ�
	}

	// �`�F�b�N���������ꂽ���ɌĂ΂��(makeCheck()�����˂�)
	function onUncheck()
	{
		super.onUncheck(...);
//		parent.onUncheck(...);	// �e�ɂ͂��̊֐�����ĂȂ�
	}

	// �}�E�X�������ꂽ��
	function onMouseDown(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		super.onMouseDown(...);
		parent.onMouseDown(left+x, top+y, button, shift);// �e���Ă�
	}

	// �}�E�X�������ꂽ��
	function onMouseUp(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		super.onMouseUp(...);
		parent.onMouseUp(left+x, top+y, button, shift);// �e���Ă�
	}

	// �}�E�X����������
	function onMouseEnter()
	{
		super.onMouseEnter(...);
		parent.onMouseEnter(...);	// �e���Ă�
	}

	// �}�E�X���o����
	function onMouseLeave()
	{
		super.onMouseLeave(...);
		parent.onMouseLeave(...);	// �e���Ă�
	}
}		


// �`�F�b�N�{�b�N�X���C���[(���Ԃ�ToggleButton + �w�i)
class KCheckBoxLayer extends KAnimButtonLayer
{
	var classid    = "KCheckBoxLayer";	// �萔
	var toggle;		// �g�O���{�^�����C��

	// �R���X�g���N�^
	function KCheckBoxLayer(window, parent, name, elm)
	{
		super.KAnimButtonLayer(window, parent, name);
		toggle = new KCheckBoxTopLayer(window, this);
		setDefaultFont(elm);	// KButtonLayer�̂��Ă�
		setOptions(elm); // �g�O���Ǝ��g��ݒ肷�邽�߂ɕʂŌĂ�
	}

	// �f�X�g���N�^
	function finalize()
	{
		invalidate toggle;
		super.finalize();
	}

	// ���̃��C���̃��[�J�������o���R�s�[����
	function copyLocalMembers(dst, src)
	{
		if (dst === void || src === void)
			return;
		.KCheckBoxTopLayer.copyLocalMembers(dst.toggle, src.toggle);
	}

	// ���̃��C���ȉ��̑S�Ẵ����o���R�s�[����
	function copyAllMembers(dst, src)
	{
		super.copyAllMembers(dst, src);
		.KCheckBoxLayer.copyLocalMembers(dst, src);
	}

	// �I�v�V�����ݒ�@�����ł͂܂� toggle ����`����Ă��Ȃ����Ƃ�����
	function setOptions(elm)
	{
		if (elm === void)
			return;
		if (elm.toggle !== void) {
			// toggle ���ݒ肳��Ă���Βl��ݒ肷��(restore��)
			super.setOptions(elm);
			toggle.setOptions(elm.toggle) if (toggle !== void);
		} else {
			// �ʏ�� setOptions() ��
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
			delete e.left;	// X/Y���W��0,0�Œ�Ȃ̂ō폜
			delete e.top;
			toggle.setOptions(e) if (toggle !== void);
		}
	}

	// �{�^���������I�ɉ���
	function makeCheck()
	{
		toggle.onCheck();
	}

	// �{�^���������I�ɗ���
	function makeUncheck()
	{
		toggle.onUncheck();
	}

	// �}�E�X�������ꂽ��
	function onMouseDown(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		super.onMouseDown(...);
		if (button != mbLeft) // ���N���b�N�ȊO�͖���
			return;

		// onCheck()�ŃN���b�N�����̂ŁA�}�E�X���o�Ă���off��
		if ((cursorX < 0 || width <= cursorX) ||
		    (cursorY < 0 || height <= cursorY))
			onMouseLeave();
	}

	// update ����Ƃ��ɁAbase/toggle�� update����B
	function update()
	{
		toggle.update();
		super.update();
	}

	// �{�^���̃R�s�[
	function assign(src)
	{
		super.assign(src);
		toggle.assign(src.toggle);
	}

	// �Z�[�u���ɏォ��Ă΂��
	function store()
	{
		var dic = super.store();
		dic.toggle = toggle.store();
		return dic;
	}

	// ���[�h���ɏォ��Ă΂��
	function restore(dic)
	{
		if (dic === void)
			return;
		super.restore(dic); // ���̒��� setOptions(dic) �����s����
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


// �X���C�_�[���C���Ŏg���^�u�{�^�����C���[
// �X���C�_�[�̈ꕔ�Ȃ̂ŁA�e����pos/size���ύX����邱�Ƃɒ���
class KSliderTabLayer extends KAnimButtonLayer
{
	var classid = "KSliderTabLayer";

	var dragging = false;	// �h���b�O���t���O
	var dragbtn;		// �h���b�O���{�^��
	var clickx=0, clicky=0;	// �N���b�N���ꂽ���̍��W�ۑ��p

	// �R���X�g���N�^
	function KSliderTabLayer(window, parent, elm)
	{
		super.KAnimButtonLayer(window, parent);
		setDefaultFont(elm);	// KButtonLayer�̂��Ă�
		setOptions(elm);
	}

	// �f�X�g���N�^
	function finalize()
	{
		super.finalize();
	}

	// �}�E�X�������ꂽ��
	function onMouseDown(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		super.onMouseDown(...);
		if (button != mbLeft) // ���N���b�N�ȊO�͖���
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

	// �}�E�X�������ꂽ��
	function onMouseUp(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		super.onMouseUp(...);
		dragging = false;
	}

	// �}�E�X���������ꂽ��
	function onMouseMove(x, y, shift)
	{
		super.onMouseMove(...);
		if (!dragging)
			return;	// drag���łȂ���ΏI��
		// �X���C�_���h���b�O���ꂽ���͐e��onSliderDragged()���Ă�
		parent.onSliderDragged(x, y, clickx, clicky, dragbtn, shift);
	}

	// �L�[�������ꂽ��
	function onKeyDown(key, shift, process)
	{
		parent.onKeyDown(...);	// �e���Ă�
	}

	// �{�^���̃R�s�[
	function assign(src)
	{
		super.assign(src);
		dragging = src.dragging;
		dragbtn  = src.dragbtn;
		clickx = src.clickx;
		clicky = src.clicky;
	}

	// �Z�[�u���ɏォ��Ă΂��(�X�[�p�[�N���X�Ɠ����Ȃ̂ŕs�v)
//	function store()

	// ���[�h���ɏォ��Ă΂��
	function restore(dic)
	{
		if (dic === void)
			return;
		super.restore(dic);	// ���̒��� setOptions(dic) �����s����
		dragging = false;
		// dragbtn  = 0; ���������Ȃ�
		clickx = clicky = 0;
		return dic;
	}
}


// �X���C�_�[(�c�������Ƃ��h���b�O�\)�AKClickableLayer�̔h���ɂ�����
class KSliderLayer extends KLayer
{
	var classid = "KSliderLayer";	// �萔
	var vval = 0.0;		// �c�̌��ݒl(0�`1.0)
	var hval = 0.0;		// ���̌��ݒl(0�`1.0)

	var vintflg = false;	// ���������͐����l�݂̂Ƃ邩�ǂ���
	var vmin = 0, vmax = 1.0; // ���������̍ŏ��l�E�ő�l
	var vstep = 0;		// �c�̍��ݕ�(0�Ŗ��i�K)

	var hintflg = false;	// ���������͐����l�݂̂Ƃ邩�ǂ���
	var hmin = 0, hmax = 1.0; // ���������̍ŏ��l�E�ő�l
	var hstep = 0;		// ���̍��ݕ�(0�Ŗ��i�K)

	var tab;		// �X���C�_�[�̃^�u�������C��
	var timer;		// �X���C�_�[�^�u�O�����������̃��s�[�g�^�C�}
	var hdst, vdst;		// �^�u�O�N���b�N���̎����ړ����̖ڕW�ꏊ

	var onchange;		// �ύX���ꂽ���Ɏ��s����TJS�X�N���v�g
	var onchangefunc;	// �ύX���ꂽ���Ɏ��s����TJS�X�N���v�g(�֐�)
	var onchangestorage;	// �ύX���ꂽ���Ɏ��s����KAG�X�g���[�W
	var onchangetarget;	// �ύX���ꂽ���Ɏ��s����KAG���x��

	// �R���X�g���N�^
	function KSliderLayer(window, parent, i_name, elm)
	{
		super.KLayer(window, parent, i_name); // �܂�elm�͐ݒ肵�Ȃ�
		var e = (elm !== void && elm.tab !== void) ? elm.tab : %[];
		tab = new KSliderTabLayer(window, this, e);

		hitThreshold = 0;	// ��������

		timer = new Timer(this, "onMouseDownRepeat");
		timer.interval = 100;
		timer.enabled = false;		// �ŏ��� false��

		// �c�����f�� vertical �����o�𗘗p����̂ŕK�{
		e = %[];
		(Dictionary.assign incontextof e)(elm) if (elm !== void);
		e.vertical = +e.vertical;	// ��`����ĂȂ�������false

		setOptions(e);// updateState() �͂��̒��Ŏ��s�����̂ŕs�v
	}

	// �f�X�g���N�^
	function finalize()
	{
		timer.enabled = false;
		invalidate tab;
		invalidate timer;
		super.finalize(...);
	}

	// ���̃��C�����[�J���̃����o���R�s�[
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

		// �{����timer.assing()���������悢���Asrc/dst�Ƃ��������ƕs��
		if (typeof(s.timer) != 'undefined') {
			// Timer�ɂ�assign������
			d.timer = %[] if (typeof(d.timer) == 'undefined');
			d.timer.interval = s.timer.interval;
			d.timer.enabled  = s.timer.enabled;
		}
		// �Ō�� s[tab*]��tab�ɐݒ肷��
		var keyary = keys(s);
		var tabelm = %[];
		for (var i = keyary.count-1; i >= 0; i--)
			if (keyary[i].length > 3 &&
			    keyary[i].substr(0,3) == 'tab')
				tabelm[keyary[i].substr(3)] = s[keyary[i]];
		.KSliderTabLayer.copyLocalMembers(d.tab, tabelm);
	}

	// �I�v�V�����ݒ�
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
		// �ȑO�Ɠ����l��ݒ肷��ꍇ�͖���������BupdateSliderTabPos()
		// ��onchange/onchangefunc�̖������[�v��h������
// �u�ȑO�Ɠ����l�̎��̓X�L�b�v����d�g�݁v�́A�������̂��߂ɂ��K�v�B
// ��ɑS�N���X�ɃC���v�����邱�ƁBsetOptions_sub()�̂悤�Ȋ֐��ɂ��Ă��悢�B
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

	// �\������Ă�����̂�������x�`��
	function redraw()
	{
		super.redraw();	// KLayer��redraw()���Ă�
		if (graphic === void) {
			// �摜���Ȃ����
			drawRuggedness(false); 	// �ւ��܂���
			if (tab !== void && width == tab.width) {
				// �c�X���C�_�[������
				var w = width/2;
				var k = tab.height;
				fillRect(w,   k/2, 1, height-k, 0x80000000);
				fillRect(w+1, k/2, 1, height-k, 0x80ffffff);
			} else if (tab !== void && height == tab.height) {
				// ���X���C�_�[������
				var h = height/2;
				var k = tab.width;
				fillRect(k/2, h,   width-k, 1, 0x80000000);
				fillRect(k/2, h+1, width-k, 1, 0x80ffffff);
			}
		}
		updateSliderTabPos();
	}

	// ��ԍX�V�A���݂̒l�ŃX���C�_�[�ʒu���X�V����B
	function updateSliderTabPos()
	{
		// step ���w�肳��Ă�����l�𐳋K������
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

		// ���݂̒l�ɂ��킹��tab�̈ʒu���ړ�����
		var x = int((width-tab.width)*((hval-hmin)/(hmax-hmin)));
		var y = int((height-tab.height)*(1-((vval-vmin)/(vmax-vmin))));
		// �ȑO�Ɠ����ʒu�Ȃ�A�������Ȃ�
		if (x == tab.left && y == tab.top)
			return;
		tab.setPos(x, y);
		if (onchangefunc !== void)
			// onchangefunc(hval, vval, dragging, true) �����s
			eval(onchangefunc+
			     "(("+hval+"), ("+vval+"), ("+tab.dragging+"))");
		if (onchangestorage !== void || onchangetarget !== void) {
			// tf.xxx��ݒ肵onchnagestorage��onchangetarget���Ă�
			tf.hval = hval, tf.vval = vval;
			tf.dragging = tab.dragging;
			window.process(onchangestorage, onchangetarget,
				       countpage);
		}
	}

	// �X���C�_�[�^�u���h���b�O���ꂽ��(�X���C�_�[�^�u�N���X����Ă΂��)
	function onSliderDragged(x, y, clickx, clicky, dragbtn, shift)
	{
		// ���݂̕\�����ׂ��ʒu�Ɉړ�
		// �X�e�b�v��updateSliderTabPos()�ōl����̂ł����ł͍l���Ȃ�

		// ����if�A�Ȃ���NaN/Infinity�ɂȂ��ăn�}�邽�ߕK�v�B
		if (width-tab.width != 0)
			hval = ((tab.left+(x-clickx))/(width -tab.width))*(hmax-hmin)+hmin;
		if (height-tab.height != 0)
			vval = (1-(tab.top +(y-clicky))/(height-tab.height))*(vmax-vmin)+vmin;
		updateSliderTabPos();
	}

	// �w��J�E���g�������ړ�
	function moveStep(hcount=0, vcount=0)
	{
		// �ړ���(Xstep)�� 0 �̎��́A0.05(=1/20) ���݂ňړ�����
		hval += ((hstep == 0) ? 0.05 : hstep) * hcount;
		vval += ((vstep == 0) ? 0.05 : vstep) * vcount;
		updateSliderTabPos();
	}

	// �X���C�_�������ꂽ���̃��s�[�g�֐�
	function onMouseDownRepeat()
	{
		// ��������tab�̈�ɓ����Ă��Ȃ����tab���ړ�
		if (hdst < tab.left)
			moveStep(-1, 0);
		else if (hdst > tab.left + tab.width)
			moveStep(1, 0);
		// �c������tab�̈�ɓ����Ă��Ȃ����tab���ړ�
		if (vdst < tab.top)
			moveStep(0, 1);
		else if (vdst > tab.top + tab.height)
			moveStep(0, -1);
		// �̈�ɓ������� timer ���~
		if (tab.left <= hdst && hdst <= tab.left + tab.width &&
		    tab.top  <= vdst && vdst <= tab.top  + tab.height)
			timer.enabled = false;
	}

	// �X�N���[���o�[�̃X���C�_�O�����������̃��s�[�g����J�n
	function scrollTo(x, y)
	{
		hdst = x, vdst = y;
		timer.enabled = true;
	}

	// �}�E�X�������ꂽ��(���̎��͕K���X���C�_�[�^�u�O��������Ă���)
	function onMouseDown(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		super.onMouseDown(...);
		if (button != mbLeft) // ���N���b�N�ȊO�͖���
			return;

		scrollTo(x, y);
	}

	// �}�E�X���������ꂽ��
	function onMouseMove(x, y, shift)
	{
		super.onMouseMove(...);
		if (timer.enabled)
			hdst = x, vdst = y;
	}

	// �}�E�X�������ꂽ��
	function onMouseUp(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		super.onMouseUp(...);
		timer.enabled = false;
	}

	// �L�[�������ꂽ��(�L�[�ŃX���C�_�[����͖�����)
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

	// �\�������Ƃ�
	function onPaint()
	{
		if (graphic === void) {
			fillRect(0,0,width,height, color);
			if (tab !== void && width == tab.width) {
				// �c�X���C�_�[������
				var w = width/2;
				var k = tab.height;
				fillRect(w,   k/2, 1, height-k, 0x80000000);
				fillRect(w+1, k/2, 1, height-k, 0x80ffffff);

			} else if (tab !== void && height == tab.height) {
				// ���X���C�_�[������
				var h = height/2;
				var k = tab.width/2;
				fillRect(k/2, h,   width-k, 1, 0x80000000);
				fillRect(k/2, h+1, width-k, 1, 0x80ffffff);
			}
		}
		super.onPaint(...);
	}

	// �{�^���̃R�s�[
	function assign(src)
	{
		super.assign(src);
		.KSliderLayer.copyLocalMembers(this, src);
		tab.assign(src.tab);
	}

	// �Z�[�u���ɏォ��Ă΂��
	function store()
	{
		var dic = super.store();
		.KSliderLayer.copyLocalMembers(dic, this);
		dic.tab = tab.store();	// dic.tab.*�ɃZ�[�u�Adic.tab*�͎g���
		return dic;
	}

	// ���[�h���ɏォ��Ă΂��
	function restore(dic)
	{
		timer.enabled = false;		// �^�C�}���~�߂�
		if (dic === void)
			return;
		super.restore(dic);	// ���̒��� setOptions(dic) �����s����
		tab.restore(dic.tab);
		timer.enabled = false;		// �^�C�}���~�߂�
		return dic;
	}
}


// RadioButton�̈�A�C�e���B��x�������Ă��g�O�����Ȃ��Ƃ��낪�قȂ�B
class KRadioButtonItem extends KToggleButtonLayer
{
	var classid  = 'KRadioButtonItem';

	// �R���X�g���N�^
	function KRadioButtonItem(window, parent, name, elm)
	{
		super.KToggleButtonLayer(...);
	}

	// �f�X�g���N�^
	function finalize()
	{
		super.finalize();
	}

	// �}�E�X�������ꂽ��
	function onMouseDown(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		if (checked && button == mbLeft)
			return;
		super.onMouseDown(left+x, top+y, button, shift);
	}

	// �}�E�X�������ꂽ��
	function onMouseUp(x=cursorX, y=cursorY, button=mbLeft, shift=0)
	{
		.KAnimButtonLayer.onMouseUp(...);	// super�̏���Ă�
		if (button != mbLeft) // ���N���b�N�ȊO�͖���
			return;
		if (!checked)
			parent.onCheck(this);	// �e���Ă�
		// KToggleButtonLayer �ƈႢ�AonUncheck()�͎��s���Ȃ�
	}
}


// KRadioButtonItem �𕡐��z�u���郉�W�I�{�^��
// onCheck()/onUncheck()�́A���̃N���X�̂ł͂Ȃ��Ă��̎q�̂��ĂԂ��ƁB
class KRadioButtonLayer extends KLayer
{
	var classid     = 'KRadioButtonLayer';
	// �{�^���̏c���z�u�� 'vertical' �ŋK�肷��
	var space       = 10;		// �{�^���̊Ԃ̋���
	var buttonleft  = 0;		// ���{�^���̍���X���W
	var buttontop   = 0;		// ���{�^���̍���Y���W
	var pushed      = -1;		// ������Ă���{�^��(������Ԃł�-1)
	var buttons     = [];		// RadioButtonItem(�{�^��)�z��
	var buttonopts  = %[];		// �{�^���̃I�v�V����
	var oncheck;			// �����ꂽ���̓���
	var oncheckfunc;		// �����ꂽ���̓���(�֐�)
	var onuncheck;			// �����ꂽ���̓���
	var onuncheckfunc;		// �����ꂽ���̓���(�֐�)

	// �R���X�g���N�^
	function KRadioButtonLayer(window, parent, i_name, elm=%[])
	{
		super.KLayer(window, parent, i_name);
//		focusable = true;	// ���̃��C���̓t�H�[�J�X�����Ȃ����A
//					// �{�^���̓t�H�[�J�X����̂�true
		if (elm.pushed === void)
			elm.pushed = 0;	// �ŏ��̈��͕K��pushed=0���w��
		setOptions(elm);
	}

	// �f�X�g���N�^
	function finalize()
	{
		for (var i = buttons.count-1; i >= 0; i--)
			invalidate buttons.pop();
		super.finalize();
	}

	// �{�^���ɃI�v�V�����ݒ�
	function setOptions_button(elm=%[]/*���ʃI�v�V����*/, ielm=[]/*��*/)
	{
		// �{�^���I�v�V�������w�肳��Ă�����ݒ�
		for (var i = buttons.count-1; i >= 0; i--) {
			buttons[i].setOptions(elm);
			if (i < ielm.count)
				buttons[i].setOptions(ielm[i]);
		}
	}

	// ���̃��C�����[�J���̃����o���R�s�[
	function copyLocalMembers(d, s)
	{
		d.space        = +s.space        if (s.space         !== void);
		d.buttonleft   = +s.buttonleft   if (s.buttonleft    !== void);
		d.buttontop    = +s.buttontop    if (s.buttontop     !== void);
		d.pushed       = +s.pushed       if (s.pushed        !== void);
			// "buttons"     = [];	// RadioButtonItem(�{�^��)�z��
		d.oncheck      = s.oncheck       if (s.oncheck       !== void);
		d.oncheckfunc  = s.oncheckfunc   if (s.oncheckfunc   !== void);
		d.onuncheck    = s.onuncheck     if (s.onuncheck     !== void);
		d.onuncheckfunc=+s.onuncheckfunc if (s.onuncheckfunc !== void);

		d.buttonopts = %[];	// �{�^���̋��ʃI�v�V����
		if (s.buttonopts !== void)
			(Dictionary.assignStruct incontextof d.buttonopts)(s.buttonopts);
	}

	// �I�v�V�����ݒ�
	function setOptions(elm)
	{
		if (elm === void)
			return;
		var e = %[];
		(Dictionary.assign incontextof e)(elm);
		// �ŏ��� e.pushed ��ۑ�
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
			alignButtons(); // �z�u�ύX
		// e.pushed ���w�肳��Ă�����A�{�^��������
		if (new_pushed !== void)
			makeCheck(new_pushed);
	}

	// �{�^���z�u���X�V����
	function alignButtons()
	{
		if (buttons.count <= 0)
			return;
		var pos = 0, max = 0;
		if (vertical) {
			// �c�z�u����
			for (var i = 0 ; i < buttons.count; i++) {
				buttons[i].setPos(buttonleft, buttontop+pos);
				pos += buttons[i].height + space;
				if (max < buttons[i].width)
					max = buttons[i].width;
			}
			setSize(max, pos-space);
		} else {
			// ���z�u����
			for (var i = 0; i < buttons.count; i++) {
				buttons[i].setPos(buttonleft+pos, buttontop);
				pos += buttons[i].width + space;
				if (max < buttons[i].height)
					max = buttons[i].height;
			}
			setSize(pos-space, max);
		}
	}

	// �{�^������ύX����
	function changeButtonNum(num)
	{
		var b_count = buttons.count;
		if (num == b_count)
			return;
		if (num < b_count) {
			// ������w�肪���Ȃ������炢�����폜
			// �z�񖖔�����폜����
			for (var i = b_count-1; i >= num; i--) {
				invalidate buttons.pop();
			}
		} else {
			// ������w�肪����������ǉ��쐬
			for (var i = b_count; i < num; i++) {
				var btn = new KRadioButtonItem(window, this);
				btn.setOptions(buttonopts);
				buttons.add(btn);
			}
		}
		setFocusOrder();
		alignButtons();
	}

	// �t�H�[�J�X�̏��Ԃ�ݒ�
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

	// �{�^���̂����ꂩ�������ꂽ���̓���(�q���C������Ă΂��)
	function onCheck(btnobj)
	{
		var index = buttons.find(btnobj);
		if (pushed == index)
			return;			// ��x�����Ȃ牽�����Ȃ�
		if (pushed >= 0)
			makeUncheck(pushed);	// �ȑO�̃{�^��������
		makeCheck(index);

		// oncheck �����s
		eval(oncheck);
		// oncheckfunc �Ŏw�肳�ꂽ�֐��� index�������u�����ČĂ�
		if (oncheckfunc !== void)
			eval(oncheckfunc+'('+index+')');
	}

	// �{�^���̂����ꂩ�������ꂽ���̓���(�q���C������Ă΂��)
	function onUncheck(btnobj)
	{
		var index = buttons.find(btnobj);
		// onuncheck �����s
		eval(onuncheck);
		// onuncheckfunc�Ŏw�肳�ꂽ�֐��� btnidx�������u�����ČĂ�
		if (onuncheckfunc !== void)
			eval(onuncheckfunc+'('+index+')');
	}

	// ����{�^��������(�����ł͑��̃{�^���̃g�O������͂��Ȃ����Ƃɒ���)
	// ������Ɖ���� onCheck() �Ńg�O�������̂ŁB
	function makeCheck(index)
	{
		pushed = index;
		buttons[index].onCheck();
	}

	// ����{�^���𗣂�(���̃{�^���̃g�O������͂��Ȃ����Ƃɒ���)
	function makeUncheck(index)
	{
		buttons[index].onUncheck();
	}

	// �{�^���̃R�s�[
	function assign(src)
	{
		super.assign(src);
		.KRadioButtonLayer.copyLocalMembers(this, src);
		(Dictionary.assignStruct incontextof buttonopts)(src.buttonopts);
		changeButtonNum(src.buttons.count);
		for (var i = 0; i < src.buttons.count; i++)
			buttons[i].assign(src.buttons[i]);
	}

	// �Z�[�u���ɏォ��Ă΂��
	function store()
	{
		var dic = super.store();
		.KRadioButtonLayer.copyLocalMembers(dic, this);
		dic.buttons = [];
// ����� restore ���� setOptions �Őݒ肳���̂��l����ƂȂ������悢�H
		for (var i = 0; i < buttons.count; i++)
			dic.buttons[i] = buttons[i].store();
		dic.buttonnum = buttons.count;	// restore()�Ŏg��
		return dic;
	}

	// ���[�h���ɏォ��Ă΂��
	function restore(dic)
	{
		if (dic === void)
			return;
// ���ꂾ�Ɖ�����Ă��{�^�����L�����Z������Ȃ���������Ȃ������
		pushed = -1;		// ��� pushed ��ʃ{�^���ɂ��Ă���
		super.restore(dic);	// ���̒��� setOptions(dic) �����s����
		return dic;
	}

	// �t�H�[�J�X���C�����q�{�^���ɐݒ�
	// �{�^����1�ȏ゠�邱�ƑO��
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


// ���̃��C���ȉ��̎w��̖��O�������C���[��T��(�����)
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
	// ����ʃR�s�[�Ȃ̂Ł�0���s�v�ȂƂ�����
	for (var i = baselayer.children.count-1; i >= startidx; i--) {
		ret = findLayer_sub(name, baselayer.children[i], recursive);
		if (ret !== void)
			return ret;
	}
	return void;
}
// ���̃��C���ȉ��̎w��̖��O�������C���[��T��(�����)
function findLayer(name, baselayer=kag.fore.base, recursive=true)
{
	var startidx = (baselayer != kag.fore.base) ? 0 : 1;
	return findLayer_sub(name, baselayer, recursive, startidx);
}


// ���̃��C���ȉ��̎w��̖��O�������C���[��T��(����)
function findLayers_sub(name, baselayer=kag.fore.base, startidx=0)
{
	var ret = [];
	if (name === void || baselayer.name == name)
		ret.add(baselayer);
	for (var i = baselayer.children.count-1; i >= startidx; i--)
		add_ary(ret, findLayer_sub(name, baselayer.children[i]));
	return ret;
}
// ���̃��C���ȉ��̎w��̖��O�������C���[��T��(�z��ŕԂ�)
function findLayers(name, baselayer=kag.fore.base)
{
	var startidx = (baselayer != kag.fore.base) ? 0 : 1;
	return findLayers_sub(name, baselayer, startidx);
}


// �����z��ɏ]���Ĉ���C���[���쐬����
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


// �����z��̔z��ɏ]���āA�����̃��C������C�ɍ쐬����
function createLayers(ary, parent=kag.fore.base)
{
	var ret = [];
	// �����ɍ쐬����
	for (var i = 0; i < ary.count; i++) {
		var p = ary[i].parent;
		if (p === void || findLayer(p, parent) !== void)
			ret.add(createLayer(ary[i], parent));
		else {
			System.inform('createLayers(): �e���C������');
			dm('createLayers(): �e���C������');
			dm('name = ' + ary[i].name + ', parent = ' + ary[i].parent);
		}
	}
	return ret;
}


// �n���ꂽ�z��̃��C�����~�t�H�[�J�X�ɂ���(focusable���ǂ����͌��Ȃ�)
function configureFocus(ary)
{
	if (ary.count <= 0)
		return;
	// �t�H�[�J�X�̏��Ԃ�ݒ�
	var i;
	for (i = 0; i < ary.count-1; i++)
		ary[i].nextfocus = ary[i+1];
	ary[i].nextfocus = ary[0];

	// ����ȃt�H�[�J�X���K�v��layer(��:KRadioButtonLayer)����
	for (i = 0; i < ary.count; i++)
		if (typeof(ary[i].setFocusOrder) != 'undefined')
			ary[i].setFocusOrder();
}


// ������ނ�KLayers����ʏ�ɔz�u���邱�Ƃ��ł��郉�b�p�[�v���O�C��
// SystemButton��rclick��ʂȂǂŎg�p����B
class KLayersPlugin extends KAGPlugin
{
	var window;		// �e�E�C���h�E
	var name;		// ���O�B�Z�[�u�̎��Ɏg���̂ŕK�{
	var foreparent;		// �\��ʂ̐e
	var backparent;		// ����ʂ̐e
	var foreary = [];	// �\��ʂ̎q�N���X�z��
	var backary = [];	// ����ʂ̎q�N���X�z��

	// �R���X�g���N�^
	function KLayersPlugin(w, i_name, fp=w.fore.base, bp=w.back.base)
	{
		super.KAGPlugin(...);
		window     = w;
		name       = i_name;
		foreparent = fp;
		backparent = bp;
	}

	// �f�X�g���N�^
	function finalize()
	{
		delOnPage('both');
		super.finalize(...);
	}

	// ����y�[�W�̎qLayer��S�č폜
	function delOnPage(page='fore')
	{
		//�t�H�[�J�X�������Ȃ��悤�ɕύX
		window.focusedLayer = null;
		if(page == 'both' || page == 'fore')
			for(var i = foreary.count-1; i >= 0; i--)
				invalidate(foreary.pop());
		if(page == 'both' || page == 'back')
			for(var i = backary.count-1; i >= 0; i--)
				invalidate(backary.pop());
	}

	// �w��name�̎qLayer���폜
	function del(name, page='fore')
	{
		//�t�H�[�J�X�������Ȃ��悤�ɕύX
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

	// �qLayer����ǉ�
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

	// name��page�ɑΉ�����q���C����T��
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

	// name��page�ɑΉ�����q���C����T��(�������)
	function search_one(name, page='fore')
	{
		var retary = search(name, page);
		if (retary.count == 0)
			return void;
		if (retary.count == 1)
			return retary[0];
		em("search_one()�őΏۃ��C����������������܂����B"+
			"�Ƃ肠���� void ��Ԃ��܂��B"+
			"search_one("+name+", "+page+")");
		return void;
	}

	// �I�v�V�����w��
	function setOptions(name, page='fore', elm)
	{
		var focused = -1;
		// ���}�E�X���ړ������Ȃ����߂ɁA�t�H�[�J�X���C�����Ō��
		// �ύX���邽�߂̍׍H
		// ary���Ƀt�H�[�J�X���ꂽ���C�������݂��Ȃ��ꍇ������̂ŁA
		// window.focusedLayer�͎g�p�ł��Ȃ�
		//
		// �c����A0.98b��KLayer��onSearchNextFocusable()�ǉ���������A
		// �K�v�Ȃ��Ȃ����񂶂�Ȃ����낤���c�B
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

	// ���C���̕\�������̏��̃R�s�[
	// backlay �^�O��g�����W�V�����̏I�����ɌĂ΂��
	function onCopyLayer(toback)
	{
		if (toback) {
			// �\����
			delOnPage('back');
			for(var i = foreary.count-1; i >= 0 ; i--) {
				var classobj = global[foreary[i].classid];
				backary[i] = new classobj(window,
					backparent, foreary[i].name);
				backary[i].assign(foreary[i]);
			}
		} else {
			// �����\
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

	// ���ƕ\�̊Ǘ���������
	function onExchangeForeBack()
	{
		// children = true �̃g�����W�V�����ł́A�g�����W�V�����I������
		// �\��ʂƗ���ʂ̃��C���\���������������ւ��̂ŁA
		// ����܂� �\��ʂ��Ǝv���Ă������̂�����ʂɁA����ʂ��Ǝv����
		// �������̂��\��ʂɂȂ��Ă��܂��B�����̃^�C�~���O�ł��̏���
		// ����ւ���΁A�����͐����Ȃ��B
		var tmp = foreary;
		foreary = backary;
		backary = tmp;

		var tmp = foreparent;
		foreparent = backparent;
		backparent = tmp;
		configureFocus(foreary);
	}

	// �Z�[�u
	function onStore(f, elm)
	{
		// �x��ۑ�����Ƃ�
		var dic = f["klayersplugin_" + name] = %[];
		dic.foreary = [];
		dic.backary = [];
		for(var i = 0; i < foreary.count; i++)
			dic.foreary.add(foreary[i].store());
		for(var i = 0; i < backary.count; i++)
			dic.backary.add(backary[i].store());
		return dic;	// �q�N���X�̂��߂ɕԂ�
	}

	// ���[�h
	function onRestore(f, clear, elm)
	{
		// �x��ǂݏo���Ƃ�
		delOnPage('both');
		var dic = f["klayersplugin_" + name];
		if(dic === void)
			return;
		// �ǂݍ��񂾂��̂�߂�
		if (elm !== void && elm.backlay) {
			// [tempload backlay=true]�Ȃ�
			for(var i = 0; i < dic.foreary.count; i++) {
				var classobj = global[dic.foreary[i].classid];
				backary[i] = new classobj(window, backparent);
				backary[i].restore(dic.foreary[i]);
			}
		} else {
			// �ʏ펞�̓ǂݍ���
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
		return dic;	// �q�N���X�̂��߂ɕԂ�
	}
}

/*
// �e���C���������̒��Ɏ����
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

// KLayersPlugin�N���X��������Ƃ����g�������A���b�Z�[�W���C���Ƀ{�^����
// �z�u���邽�߂̃N���X�B
// ���b�Z�[�W�E�B���h�E�ɂ�������visible/unvisible���ݒ肳���
// �悤�ɂ��邽�߁B
class KLayersPluginOnMessage extends KLayersPlugin
{
	var withmessage     = true;	// ���b�Z�[�W��ʂƈꏏ�ɉB�����ǂ���
	var foreary_visible = [];	// �B�������� fore �� layer �̕\�����
	var backary_visible = [];	// �B�������� back �� layer �̕\�����
	var anytimeenabled  = false;	// ���enable���B�ʏ��stable��Ԃł̂�enable

	// �R���X�g���N�^
	function KLayersPluginOnMessage(name, fp, bp, withmessage=true, anytimeenabled=false)
	{
		super.KLayersPlugin(kag, name, fp, bp);
		this.withmessage = withmessage;
		this.anytimeenabled = anytimeenabled;
	}

	// Add �̎��� absolute �� message ���C���̏�ɂ���悤�׍H
	function add(name='noname', classobj, page='fore', elm = %[])
	{
		if (elm.absolute === void)
			elm.absolute = 1100000;	//���b�Z�[�W���C��100���ڂƓ���
		super.add(...);
	}

	// �u����v( s l p �̊e�^�O�Œ�~�� ) ���A
	// �u���s���v ( ����ȊO ) ���̏�Ԃ��ς�����Ƃ��ɌĂ΂��
	function onStableStateChanged(stable)
	{
		if (anytimeenabled)
			return;
		super.onStableStateChanged(...);
		// ���s���̓��C���𖳌��ɂ���
		setOptions(, 'both', %[ enabled: stable ]);
	}

	// ���b�Z�[�W���C�������[�U�̑���ɂ���ĕ\���E��\������鎞
	// �Ă΂��B���b�Z�[�W���C���ƕ\��/��\���𓯊������邽�ߐݒ�
	function onMessageHiddenStateChanged(hidden)
	{
		if (!withmessage)
			return;
		super.onMessageHiddenStateChanged(...);
		if (hidden) {
			// �B���Ƃ��F���݂̏�Ԃ��L������
			foreary_visible = [];
			backary_visible = [];
			for (var i = foreary.count-1; i >= 0; i--)
				foreary_visible[i] = foreary[i].visible;
			for (var i = backary.count-1; i >= 0; i--) 
				backary_visible[i] = backary[i].visible;
			setOptions(, 'both', %[ visible: false ]);
		} else {
			// �\������Ƃ��F���̏�Ԃɖ߂�
			for (var i = foreary.count-1; i >= 0; i--)
				foreary[i].visible = foreary_visible[i];
			for (var i = backary.count-1; i >= 0; i--)
				backary[i].visible = backary_visible[i];
			foreary_visible = [];
			backary_visible = [];
		}
	}

	// ���̂܂܂ł́Ahidden ���ɗv�f�� add/del ���ꂽ�ꍇ���l�����Ă��Ȃ��B
	// �{���́Afore/backary_visible[] �ɒǉ��E����폜���鏈�����K�v�B

	// ���C���̕\�������̏��R�s�[
	function onCopyLayer(toback)
	{
		super.onCopyLayer(toback);
		if (toback)
			backary_visible.assign(foreary_visible); // �\����
		else
			foreary_visible.assign(backary_visible); // �����\
	}

	// ���ƕ\�̊Ǘ���������
	function onExchangeForeBack()
	{
		super.onExchangeForeBack();
		var tmp = [];
		tmp.assign(foreary_visible);
		foreary_visible.assign(backary_visible);
		backary_visible.assign(tmp);
	}

	// �Z�[�u(���b�Z�[�W�������ɃZ�[�u�ł��Ȃ���Εs�v)
	function onStore(f, elm)
	{
		var dic = super.onStore(f, elm);
		dic.withmessage = withmessage;
		dic.foreary_visible = [];
		dic.foreary_visible.assign(foreary_visible);
		dic.backary_visible = [];
		dic.backary_visible.assign(backary_visible);
		dic.anytimeenabled = anytimeenabled;
		return dic;	// �q�N���X�̂��߂ɕԂ�
	}

	// ���[�h(���b�Z�[�W�������ɃZ�[�u�ł��Ȃ���Εs�v)
	function onRestore(f, clear, elm)
	{
		var dic = super.onRestore(f, clear, elm);
		if (dic === void)
			return dic;
		withmessage = dic.withmessage;
		if (elm !== void && elm.backlay) {
			// [tempload backlay=true]�̎�
			backary_visible = [];
			if (dic.foreary_visible !== void)
				backary_visible.assign(dic.foreary_visible);
		} else {
			// �ʏ펞
			foreary_visible = [];
			if (dic.foreary_visible !== void)
				foreary_visible.assign(dic.foreary_visible);
			backary_visible = [];
			if (dic.backary_visible !== void)
				backary_visible.assign(dic.backary_visible);
		}
//		onMessageHiddenStateChanged(0);
//		������͕s�v�Bsuper.onRestore() ���Őݒ肵�Ă��܂����߁B
		anytimeenabled = dic.anytimeenabled;
		return dic;	// �q�N���X�̂��߂ɕԂ�
	}
}


// ���̃t�@�C����ǂݍ��񂾃t���O
global.KLayersLoaded = true;

[endscript]

[return]