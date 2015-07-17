;
; $Workfile:   m_trig.asm  $
; $Revision:   1.6  $
; $Version$
; $Date:   14 Dec 1995 19:00:58  $
; $Log:   R:\darkstar\develop\core\ml\vcs\m_trig.asv  $
;	
;	   Rev 1.6   14 Dec 1995 19:00:58   CAEDMONI
;	converted to fastcall
;	
;	   Rev 1.5   11 Dec 1995 19:01:24   CAEDMONI
;	converted to fastcall
;	
;	   Rev 1.4   22 Nov 1995 17:28:30   CAEDMONI
;	fixed sincos functions for floating point
;	
;	   Rev 1.3   09 Nov 1995 19:37:56   CAEDMONI
;	added m_sincosf(), m_sincosd()
;	
;	   Rev 1.2   05 Apr 1995 11:36:12   RICKO
;	Integrate DarkStar Changes
;	
;	   Rev 1.1   08 Mar 1995 08:44:06   RICKO
;	Now compiles with both TASM and MASM
;	
;	   Rev 1.0   07 Mar 1995 13:16:46   NANCYH
;	Initial revision.
;  

INCLUDE m_trig.inc

.DATA


;
; cos table for a 12-bit angle
; angles range from 0 to 4095
; this table only holds the angles from cos(0) to cos(2048).
;
; This table was partially generated by hand.  If you use a Zortech program
; to generate this table, it will not round properly.  Each angle has also
; been checked to make sure it is correct.  Please do not make any
; modifications unless you know what you are doing.
;
public _costab
_costab label WORD
public costab
costab label WORD
   dw 04000h,04000h,04000h,04000h,04000h,04000h,03fffh,03fffh
   dw 03fffh,03ffeh,03ffeh,03ffeh,03ffdh,03ffdh,03ffch,03ffch
   dw 03ffbh,03ffah,03ffah,03ff9h,03ff8h,03ff7h,03ff7h,03ff6h
   dw 03ff5h,03ff4h,03ff3h,03ff2h,03ff1h,03ff0h,03fefh,03fedh
   dw 03fech,03febh,03feah,03fe8h,03fe7h,03fe6h,03fe4h,03fe3h
   dw 03fe1h,03fe0h,03fdeh,03fdch,03fdbh,03fd9h,03fd7h,03fd5h
   dw 03fd4h,03fd2h,03fd0h,03fceh,03fcch,03fcah,03fc8h,03fc6h
   dw 03fc4h,03fc1h,03fbfh,03fbdh,03fbbh,03fb8h,03fb6h,03fb4h
   dw 03fb1h,03fafh,03fach,03faah,03fa7h,03fa4h,03fa2h,03f9fh
   dw 03f9ch,03f99h,03f97h,03f94h,03f91h,03f8eh,03f8bh,03f88h
   dw 03f85h,03f82h,03f7fh,03f7bh,03f78h,03f75h,03f72h,03f6eh
   dw 03f6bh,03f68h,03f64h,03f61h,03f5dh,03f5ah,03f56h,03f52h
   dw 03f4fh,03f4bh,03f47h,03f43h,03f40h,03f3ch,03f38h,03f34h
   dw 03f30h,03f2ch,03f28h,03f24h,03f20h,03f1ch,03f17h,03f13h
   dw 03f0fh,03f0ah,03f06h,03f02h,03efdh,03ef9h,03ef4h,03ef0h
   dw 03eebh,03ee7h,03ee2h,03eddh,03ed8h,03ed4h,03ecfh,03ecah
   dw 03ec5h,03ec0h,03ebbh,03eb6h,03eb1h,03each,03ea7h,03ea2h
   dw 03e9dh,03e98h,03e92h,03e8dh,03e88h,03e82h,03e7dh,03e77h
   dw 03e72h,03e6ch,03e67h,03e61h,03e5ch,03e56h,03e50h,03e4ah
   dw 03e45h,03e3fh,03e39h,03e33h,03e2dh,03e27h,03e21h,03e1bh
   dw 03e15h,03e0fh,03e09h,03e03h,03dfch,03df6h,03df0h,03de9h
   dw 03de3h,03dddh,03dd6h,03dd0h,03dc9h,03dc2h,03dbch,03db5h
   dw 03dafh,03da8h,03da1h,03d9ah,03d93h,03d8dh,03d86h,03d7fh
   dw 03d78h,03d71h,03d6ah,03d63h,03d5bh,03d54h,03d4dh,03d46h
   dw 03d3fh,03d37h,03d30h,03d28h,03d21h,03d1ah,03d12h,03d0bh
   dw 03d03h,03cfbh,03cf4h,03cech,03ce4h,03cddh,03cd5h,03ccdh
   dw 03cc5h,03cbdh,03cb5h,03cadh,03ca5h,03c9dh,03c95h,03c8dh
   dw 03c85h,03c7dh,03c74h,03c6ch,03c64h,03c5bh,03c53h,03c4bh
   dw 03c42h,03c3ah,03c31h,03c29h,03c20h,03c17h,03c0fh,03c06h
   dw 03bfdh,03bf5h,03bech,03be3h,03bdah,03bd1h,03bc8h,03bbfh
   dw 03bb6h,03badh,03ba4h,03b9bh,03b92h,03b88h,03b7fh,03b76h
   dw 03b6dh,03b63h,03b5ah,03b50h,03b47h,03b3eh,03b34h,03b2ah
   dw 03b21h,03b17h,03b0eh,03b04h,03afah,03af0h,03ae6h,03addh
   dw 03ad3h,03ac9h,03abfh,03ab5h,03aabh,03aa1h,03a97h,03a8dh
   dw 03a82h,03a78h,03a6eh,03a64h,03a59h,03a4fh,03a45h,03a3ah
   dw 03a30h,03a25h,03a1bh,03a10h,03a06h,039fbh,039f0h,039e6h
   dw 039dbh,039d0h,039c5h,039bbh,039b0h,039a5h,0399ah,0398fh
   dw 03984h,03979h,0396eh,03963h,03958h,0394ch,03941h,03936h
   dw 0392bh,0391fh,03914h,03909h,038fdh,038f2h,038e6h,038dbh
   dw 038cfh,038c3h,038b8h,038ach,038a1h,03895h,03889h,0387dh
   dw 03871h,03866h,0385ah,0384eh,03842h,03836h,0382ah,0381eh
   dw 03812h,03805h,037f9h,037edh,037e1h,037d5h,037c8h,037bch
   dw 037b0h,037a3h,03797h,0378ah,0377eh,03771h,03765h,03758h
   dw 0374bh,0373fh,03732h,03725h,03718h,0370ch,036ffh,036f2h
   dw 036e5h,036d8h,036cbh,036beh,036b1h,036a4h,03697h,0368ah
   dw 0367dh,0366fh,03662h,03655h,03648h,0363ah,0362dh,03620h
   dw 03612h,03605h,035f7h,035eah,035dch,035ceh,035c1h,035b3h
   dw 035a5h,03598h,0358ah,0357ch,0356eh,03561h,03553h,03545h
   dw 03537h,03529h,0351bh,0350dh,034ffh,034f1h,034e2h,034d4h
   dw 034c6h,034b8h,034aah,0349bh,0348dh,0347fh,03470h,03462h
   dw 03453h,03445h,03436h,03428h,03419h,0340bh,033fch,033edh
   dw 033dfh,033d0h,033c1h,033b2h,033a3h,03395h,03386h,03377h
   dw 03368h,03359h,0334ah,0333bh,0332ch,0331dh,0330dh,032feh
   dw 032efh,032e0h,032d0h,032c1h,032b2h,032a3h,03293h,03284h
   dw 03274h,03265h,03255h,03246h,03236h,03227h,03217h,03207h
   dw 031f8h,031e8h,031d8h,031c8h,031b9h,031a9h,03199h,03189h
   dw 03179h,03169h,03159h,03149h,03139h,03129h,03119h,03109h
   dw 030f9h,030e8h,030d8h,030c8h,030b8h,030a7h,03097h,03087h
   dw 03076h,03066h,03055h,03045h,03034h,03024h,03013h,03002h
   dw 02ff2h,02fe1h,02fd0h,02fc0h,02fafh,02f9fh,02f8dh,02f7dh
   dw 02f6ch,02f5bh,02f4ah,02f39h,02f28h,02f17h,02f06h,02ef5h
   dw 02ee4h,02ed3h,02ec2h,02eb0h,02e9fh,02e8eh,02e7dh,02e6bh
   dw 02e5ah,02e49h,02e37h,02e26h,02e15h,02e03h,02df2h,02de0h
   dw 02dcfh,02dbdh,02dabh,02d9ah,02d88h,02d76h,02d65h,02d53h
   dw 02d41h,02d2fh,02d1eh,02d0ch,02cfah,02ce8h,02cd6h,02cc4h
   dw 02cb2h,02ca0h,02c8eh,02c7ch,02c6ah,02c58h,02c46h,02c34h
   dw 02c21h,02c0fh,02bfdh,02bebh,02bd8h,02bc6h,02bb4h,02ba1h
   dw 02b8fh,02b7dh,02b6ah,02b58h,02b45h,02b33h,02b20h,02b0dh
   dw 02afbh,02ae8h,02ad6h,02ac3h,02ab0h,02a9dh,02a8bh,02a78h
   dw 02a65h,02a52h,02a3fh,02a2ch,02a1ah,02a07h,029f4h,029e1h
   dw 029ceh,029bbh,029a7h,02994h,02981h,0296eh,0295bh,02948h
   dw 02935h,02921h,0290eh,028fbh,028e7h,028d4h,028c1h,028adh
   dw 0289ah,02886h,02873h,02860h,0284ch,02838h,02825h,02811h
   dw 027feh,027eah,027d6h,027c3h,027afh,0279bh,02788h,02774h
   dw 02760h,0274ch,02738h,02724h,02711h,026fdh,026e9h,026d5h
   dw 026c1h,026adh,02699h,02685h,02671h,0265ch,02648h,02634h
   dw 02620h,0260ch,025f8h,025e3h,025cfh,025bbh,025a6h,02592h
   dw 0257eh,02569h,02555h,02541h,0252ch,02518h,02503h,024efh
   dw 024dah,024c5h,024b1h,0249ch,02488h,02473h,0245eh,0244ah
   dw 02435h,02420h,0240bh,023f7h,023e2h,023cdh,023b8h,023a3h
   dw 0238eh,0237ah,02365h,02350h,0233bh,02326h,02311h,022fch
   dw 022e7h,022d2h,022bch,022a7h,02292h,0227dh,02268h,02253h
   dw 0223eh,02228h,02213h,021feh,021e8h,021d3h,021beh,021a8h
   dw 02193h,0217dh,02168h,02153h,0213dh,02128h,02112h,020fdh
   dw 020e7h,020d1h,020bch,020a6h,02091h,0207bh,02065h,02050h
   dw 0203ah,02024h,0200fh,01ff9h,01fe3h,01fcdh,01fb7h,01fa2h
   dw 01f8ch,01f76h,01f60h,01f4ah,01f34h,01f1eh,01f08h,01ef2h
   dw 01edch,01ec6h,01eb0h,01e9ah,01e84h,01e6eh,01e58h,01e42h
   dw 01e2bh,01e15h,01dffh,01de9h,01dd3h,01dbch,01da6h,01d90h
   dw 01d79h,01d63h,01d4dh,01d36h,01d20h,01d0ah,01cf3h,01cddh
   dw 01cc6h,01cb0h,01c99h,01c83h,01c6ch,01c56h,01c3fh,01c29h
   dw 01c12h,01bfch,01be5h,01bceh,01bb8h,01ba1h,01b8ah,01b74h
   dw 01b5dh,01b46h,01b30h,01b19h,01b02h,01aebh,01ad4h,01abeh
   dw 01aa7h,01a90h,01a79h,01a62h,01a4bh,01a34h,01a1dh,01a06h
   dw 019efh,019d8h,019c1h,019aah,01993h,0197ch,01965h,0194eh
   dw 01937h,01920h,01909h,018f2h,018dbh,018c3h,018ach,01895h
   dw 0187eh,01867h,0184fh,01838h,01821h,0180ah,017f2h,017dbh
   dw 017c4h,017ach,01795h,0177eh,01766h,0174fh,01737h,01720h
   dw 01709h,016f1h,016dah,016c2h,016abh,01693h,0167ch,01664h
   dw 0164ch,01635h,0161dh,01606h,015eeh,015d7h,015bfh,015a7h
   dw 01590h,01578h,01560h,01549h,01531h,01519h,01501h,014eah
   dw 014d2h,014bah,014a2h,0148bh,01473h,0145bh,01443h,0142bh
   dw 01413h,013fbh,013e4h,013cch,013b4h,0139ch,01384h,0136ch
   dw 01354h,0133ch,01324h,0130ch,012f4h,012dch,012c4h,012ach
   dw 01294h,0127ch,01264h,0124ch,01234h,0121ch,01204h,011ebh
   dw 011d3h,011bbh,011a3h,0118bh,01173h,0115ah,01142h,0112ah
   dw 01112h,010fah,010e1h,010c9h,010b1h,01099h,01080h,01068h
   dw 01050h,01037h,0101fh,01007h,00feeh,00fd6h,00fbeh,00fa5h
   dw 00f8dh,00f75h,00f5ch,00f44h,00f2bh,00f13h,00efbh,00ee2h
   dw 00ecah,00eb1h,00e99h,00e80h,00e68h,00e4fh,00e37h,00e1eh
   dw 00e06h,00dedh,00dd5h,00dbch,00da4h,00d8bh,00d73h,00d5ah
   dw 00d41h,00d29h,00d10h,00cf8h,00cdfh,00cc6h,00caeh,00c95h
   dw 00c7ch,00c64h,00c4bh,00c32h,00c1ah,00c01h,00be8h,00bd0h
   dw 00bb7h,00b9eh,00b86h,00b6dh,00b54h,00b3bh,00b23h,00b0ah
   dw 00af1h,00ad8h,00ac0h,00aa7h,00a8eh,00a75h,00a5ch,00a44h
   dw 00a2bh,00a12h,009f9h,009e0h,009c7h,009afh,00996h,0097dh
   dw 00964h,0094bh,00932h,00919h,00901h,008e8h,008cfh,008b6h
   dw 0089dh,00884h,0086bh,00852h,00839h,00820h,00807h,007efh
   dw 007d6h,007bdh,007a4h,0078bh,00772h,00759h,00740h,00727h
   dw 0070eh,006f5h,006dch,006c3h,006aah,00691h,00678h,0065fh
   dw 00646h,0062dh,00614h,005fbh,005e2h,005c9h,005b0h,00597h
   dw 0057eh,00565h,0054ch,00533h,0051ah,00500h,004e7h,004ceh
   dw 004b5h,0049ch,00483h,0046ah,00451h,00438h,0041fh,00406h
   dw 003edh,003d4h,003bbh,003a1h,00388h,0036fh,00356h,0033dh
   dw 00324h,0030bh,002f2h,002d9h,002c0h,002a6h,0028dh,00274h
   dw 0025bh,00242h,00229h,00210h,001f7h,001ddh,001c4h,001abh
   dw 00192h,00179h,00160h,00147h,0012eh,00114h,000fbh,000e2h
   dw 000c9h,000b0h,00097h,0007eh,00065h,0004bh,00032h,00019h
   dw 0h

.CODE

;----------------------------------------------------------------------------
;	
; AngleX m_AngleX_cos( const AngleX );
;	
;
; src: ( angle )
;
; return = cos of angle
;----------------------------------------------------------------------------
BeginFastCallProc       m_AngleX_cos, angle
	m_cos	angle		; macro defined in m_trig.inc
EndFastCallProc


;----------------------------------------------------------------------------
;	
; AngleX m_AngleX_sin( const AngleX );
;	
;
; src: ( angle )
;
; return = sin of angle
;----------------------------------------------------------------------------
BeginFastCallProc       m_AngleX_sin, angle
        m_sin   angle           ; macro defined in m_trig.inc
EndFastCallProc

;----------------------------------------------------------------------------
;	
; AngleF m_AngleF_sincos( const AngleF &, AngleF *psin, AngleF *pcos );
;	
;
; src: ( angle )
;
; return = sin and cos of angle
;----------------------------------------------------------------------------
BeginFastCallProc       m_AngleF_sincos, angle, psin, pcos
        fld     dword ptr [angle]       ; angle
        fsincos
        fstp    dword ptr [pcos]
        fstp    dword ptr [psin]
EndFastCallProc

;----------------------------------------------------------------------------
;	
; AngleD m_AngleD_sincos( const AngleD &, AngleD *psin, AngleD *pcos );
;	
;
; src: ( angle )
;
; return = sin and cos of angle
;----------------------------------------------------------------------------
BeginFastCallProc       m_AngleD_sincos, angle, psin, pcos
        fld     qword ptr [angle]       ; angle
        fsincos
        fstp    qword ptr [pcos]
        fstp    qword ptr [psin]
EndFastCallProc

;----------------------------------------------------------------------------
;	
; AngleF m_AngleF_reduce( const AngleF & );
;	
;
; src: ( angle )
;
; return = angle reduced to 0..2pi
;----------------------------------------------------------------------------
BeginFastCallProc m_AngleF_reduce, ang
        fld     _RealF_2Pi
        fld     dword ptr [angle]
        fprem
        ffree   st(1)
EndFastCallProc

;----------------------------------------------------------------------------
;	
; AngleD m_AngleD_reduce( const AngleD & );
;	
;
; src: ( a )
;
; return = angle reduced to 0..2pi
;----------------------------------------------------------------------------
BeginFastCallProc m_AngleD_reduce, angle
        fld     _RealF_2Pi
        fld     qword ptr [angle]
        fprem
        ffree   st(1)
EndFastCallProc

END
