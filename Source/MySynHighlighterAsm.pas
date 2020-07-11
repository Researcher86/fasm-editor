unit MySynHighlighterAsm;
{$I SynEdit.inc}

interface

uses
  Graphics,
  SynEditTypes,
  SynEditHighlighter,
  SynHighlighterHashEntries,
  SynUnicode,
  SysUtils,
  Classes;

const
  SYN_ATTR_DIR = 6;
  SYN_ATTR_OPERFPU = 7;

  SYN_ATTR_JUMP = 8;
  SYN_ATTR_REGISTR = 9;
  SYN_ATTR_RAZ = 10;
  SYN_ATTR_SELWORD = 11;
  SYN_ATTR_UNDERSCOREWORD = 12;

  SYNS_AttrDir = 'Dir';
  SYNS_FriendlyAttrDir = 'Dir';

  SYNS_AttrOperFPU = 'OperFPU';
  SYNS_FriendlyAttrOperFPU = 'OperFPU';

  SYNS_AttrJump = 'Jump';
  SYNS_FriendlyAttrJump = 'Jump';
  SYNS_AttrRegist = 'Regist';
  SYNS_FriendlyAttrRegist = 'Regist';
  SYNS_AttrRaz = 'Raz';
  SYNS_FriendlyAttrRaz = 'Raz';

  Mnemonics: UnicodeString =
    'aaa,aad,aam,adc,add,and,arpl,bound,bsf,bsr,bswap,bt,btc,' +
    'btr,bts,cbw,cdq,clc,cld,cli,clts,cmc,cmp,cmps,cmpsb,cmpsd,cmpsw,' +
    'cmpxchg,cwd,cwde,daa,das,dec,div,emms,enter,hlt,idiv,' +
    'imul,in,inc,ins,insb,insd,insw,int,into,invd,invlpg,iret,iretd,iretw,' +
    'lahf,lar,lds,wait,wbinvd,xadd,xchg,xlat,xlatb,xor,rdtsc,cpuid,' +
    'lea,leave,les,lfs,lgdt,lgs,lidt,lldt,lmsw,lock,lods,lodsb,lodsd,lodsw,' +
    'lsl,lss,ltr,mov,movd,movq, movs,movsb,movups,' +
    'movsd,movsw,movsx,movzx,mul,neg,nop,not,or,out,outs,outsb,outsd,outsw,' +
    'packssdw,packsswb,packuswb,paddb,paddd,paddsb,paddsw,paddusb,paddusw,' +
    'paddw,pand,pandn,pavgusb,pcmpeqb,pcmpeqd,pcmpeqw,pcmpgtb,pcmpgtd,pcmpgtw,'
    + 'pf2id,pfacc,pfadd,pfcmpeq,pfcmpge,pfcmpgt,pfmax,pfmin,pfmul,pfrcp,' +
    'pfrcpit1,pfrcpit2,pfrsqit1,pfrsqrt,pfsub,pfsubr,pi2fd,pmaddwd,pmulhrw,' +
    'pmulhw,pmullw,pop,popa,popad,popaw,popf,popfd,popfw,por,prefetch,prefetchw,'
    + 'pslld,psllq,psllw,psrad,psraw,psrld,psrlq,psrlw,psubb,psubd,psubsb,' +
    'psubsw,psubusb,psubusw,psubw,punpckhbw,punpckhdq,punpckhwd,punpcklbw,' +
    'punpckldq,punpcklwd,push,pusha,pushad,pushaw,pushf,pushfd,pushfw,pxor,' +
    'rcl,rcr,rep,repe,repne,repnz,repz,rol,ror,sahf,sal,sar,sbb,scas,' +
    'scasb,scasd,scasw,seta,setae,setb,setbe,setc,sete,setg,setge,setl,setle,' +
    'setna,setnae,setnb,setnbe,setnc,setne,setng,setnge,setnl,setnle,setno,' +
    'setnp,setns,setnz,seto,setp,setpo,sets,setz,sgdt,shl,shld,shr,shrd,sidt,' +
    'sldt,smsw,stc,std,sti,stos,stosb,stosd,stosw,str,sub,test,verr,verw';

  MnemonicsFPU: UnicodeString =
    'fabs,fadd,fbld,fchs,fcom,fcos,fdiv,feni,fild,fist,fld1,fldz,fmul,fnop,' +
    'fsin,fstp,fsub,ftst,fxam,fxch,f2xm1,faddp,fbstp,fclex,fcomi,fcomp,' +
    'fdisi,fdivp,fdivr,femms,ffree,fiadd,ficom,fidiv,fimul,finit,fistp,' +
    'fisub,fldcw,fldpi,fmulp,fneni,fprem,fptan,fsave,fsqrt,fstcw,' +
    'fstsw,fsubp,fsubr,fucom,fwait,fyl2x,fcmovb,fcmove,fcmovu,fcomip,' +
    'fcompp,fdivrp,ffreep,ficomp,fidivr,fisttp,fisubr,fldenv,fldl2e,fldl2t,' +
    'fldlg2,fldln2,fnclex,fndisi,fninit,fnsave,fnstcw,fnstsw,fpatan,' +
    'fprem1,frstor,frstpm,fsaved,fsavew,fscale,fsetpm,fstenv,fsubrp,fucomi,' +
    'fucomp,fxsave,fcmovbe,fcmovnb,fcmovne,fcmovnu,fdecstp,fincstp,fldenvd,' +
    'fldenvw,fnsaved,fnsavew,fnstenv,frndint,frstord,frstorw,fsincos,fstenvd,' +
    'fstenvw,fucomip,fucompp,fxrstor,fxtract,fyl2xp1,fcmovnbe,fnstenvd,' +
    'fnstenvw,fld,fst';

  MnemonicsJump: UnicodeString =
    'ja,jae,jb,jbe,jc,jcxz,je,jecxz,jg,jge,jl,jle,jmp,jna,jnae,jnb,jnbe,jnc,' +
    'jne,jng,jnge,jnl,jnle,jno,jnp,jns,jnz,jo,jp,jpe,jpo,js,jz,call,ret,' +
    'loop,loope,loopne,loopnz,loopz';

  MnemonicsDir: UnicodeString =
    'model,flat,stdcall,option,casemap,none,const,include,includelib,proto,' +
    'data,code,segment,ends,public,use32,use16,assume,' +
    'byte,word,dword,qword,tword,db,dw,dd,dq,dt,rb,equ,' +
    'macro,vararg,endm,invoke,dup,proc,endp,local,addr,offset,end,mmx,xmm,sizeof,ptr,'
    + 'true,false,format,pe,pe64,console,ms,coff,binary,extrn,as,gui,section,readable,executable,writeable,import,'
    + 'library,entry,resource,directory,interface,struct,union,cominvk,' +
    'virtual,at,export,fixups,discardable,dll,use64,large,' +
    'while,endw,repeat,for,break,if,elseif,else,endif,native,notpageable,uses,align,'
    + 'stack,restore,purge,common,forward,reverse,eq,eqtype,fword,pword,tbyte,dqword,'
    + 'from,shareable,heap,mz,ms64,elf,elf64,du,rw,rd,dp,df,rp,rf,rq,rt,rva,near,far,'
    + 'define,irp,irps,match,rept,restruc,note,dynamic,linkinfo,efiruntime,linkremove,'
    + 'interpreter,static,efiboot,comcall,locals,endl,qqword,xword,yword,ccall,cinvoke,struc,fix,org,'
    + 'file,menu,menuitem,menuseparator,dialog,dialogitem,enddialog,icon,bitmap,cursor,resdata,'
    + 'endres,accelerator,versioninfo,syslibrary,fastcall';

  MnemonicsRegist: UnicodeString =
    'eax,ax,al,ah,ebx,bx,bl,bh,ecx,cx,cl,ch,edx,dx,dl,dh,esi,si,edi,di,ebp,bp,'
    + 'esp,sp,cs,ds,es,ss,gs,fs,mm0,mm1,mm2,mm3,mm4,mm5,mm6,mm7,xmm0,xmm1,xmm2,'
    + 'xmm3,xmm4,xmm5,xmm6,xmm7,xmm8,xmm9,xmm10,xmm11,xmm12,xmm13,xmm14,xmm15,'
    + 'rbx,rsp,rcx,rax,rdx,rbp,rsi,rdi,rip,' +
    'r8,r8d,r9,r9d,r10,r10d,r11,r11d,r12,r12d,r13,r13d,r14,r14d,r15,r15d,' +
    'cr0,cr2,cr3,cr4,dr0,dr1,dr2,dr3,dr6,dr7,st0,st1,st2,st3,st4,st5,st6,st7,' +
    'ymm0,ymm1,ymm2,ymm3,ymm4,ymm5,ymm6,ymm7,ymm8,ymm9,r13w,r14w,r15w,rflags,' +
    'sil,dil,spl,bpl,r8l,r9l,r10l,r11l,r12l,r13l,r14l,r15l,r8w,r9w,r10w,r11w,r12w';

  MnemonicsRaz: UnicodeString = 'start';

type
  TtkTokenKind = (tkComment, tkIdentifier, tkOper, tkOperFPU, tkNull, tkNumber,
    tkSpace, tkString, tkSymbol, tkDir, tkJump, tkReg, tkRaz, tkSelWord, tkUnderscoreWord,
    tkUnknown);

  TOpt = packed record
    CommentAttri: packed record
      Style: TFontStyles;
      Foreground: TColor;
    end;

    IdentifierAttri: packed record
      Style: TFontStyles;
      Foreground: TColor;
    end;

    OperAttri: packed record
      Style: TFontStyles;
      Foreground: TColor;
    end;

    OperAttriFPU: packed record
      Style: TFontStyles;
      Foreground: TColor;
    end;

    NumberAttri: packed record
      Style: TFontStyles;
      Foreground: TColor;
    end;

    SpaceAttri: packed record
      Style: TFontStyles;
      Foreground: TColor;
    end;

    StringAttri: packed record
      Style: TFontStyles;
      Foreground: TColor;
    end;

    SymbolAttri: packed record
      Style: TFontStyles;
      Foreground: TColor;
    end;

    DirAttri: packed record
      Style: TFontStyles;
      Foreground: TColor;
    end;

    JumpAttri: packed record
      Style: TFontStyles;
      Foreground: TColor;
    end;

    RegAttri: packed record
      Style: TFontStyles;
      Foreground: TColor;
    end;

    RazAttri: packed record
      Style: TFontStyles;
      Foreground: TColor;
    end;
  end;

type
  TMySynAsmSyn = class(TSynCustomHighlighter)
  private
    fTokenId: TtkTokenKind;
    fCommentAttri: TSynHighlighterAttributes;
    fIdentifierAttri: TSynHighlighterAttributes;
    fOperAttri: TSynHighlighterAttributes;
    fOperAttriFPU: TSynHighlighterAttributes;
    fNumberAttri: TSynHighlighterAttributes;
    fSpaceAttri: TSynHighlighterAttributes;
    fStringAttri: TSynHighlighterAttributes;
    fSymbolAttri: TSynHighlighterAttributes;

    fDirAttri: TSynHighlighterAttributes;
    fJumpAttri: TSynHighlighterAttributes;
    fRegAttri: TSynHighlighterAttributes;
    fRazAttri: TSynHighlighterAttributes;
    fSelectWordAttri: TSynHighlighterAttributes;
    fUnderscoreWordAttri: TSynHighlighterAttributes;

    fKeywordsOper: TSynHashEntryList;
    fSelectWord: string;
    fUnderscoreWord: string;
    function HashKey(Str: PWideChar): Cardinal;
    procedure CommentProc;
    procedure CRProc;
    procedure GreaterProc;
    procedure IdentProc;
    procedure LFProc;
    procedure LowerProc;
    procedure NullProc;
    procedure NumberProc;
    procedure SlashProc;
    procedure SpaceProc;
    procedure StringProc;
    procedure SingleQuoteStringProc;
    procedure SymbolProc;
    procedure UnknownProc;
    procedure DoAddKeywordOper(AKeyword: UnicodeString; AKind: integer);
    function IdentKind(MayBe: PWideChar): TtkTokenKind;
    procedure SetSelectWord(const Value: string);
    procedure SetUnderscoreWord(const Value: string);
  protected
    function GetSampleSource: UnicodeString; override;
    function IsFilterStored: Boolean; override;
  public
    class function GetLanguageName: string; override;
    class function GetFriendlyLanguageName: UnicodeString; override;
  public
    constructor Create(const Comand, ComandFPU, Dir, Jump, Regist, Raz: UnicodeString; var Opt: TOpt);
    destructor Destroy; override;
    function GetDefaultAttribute(Index: integer): TSynHighlighterAttributes; override;
    function GetEol: Boolean; override;
    function GetTokenID: TtkTokenKind;
    function GetTokenAttribute: TSynHighlighterAttributes; override;
    function GetTokenKind: integer; override;
    procedure Next; override;
    function equalsUnderscoreWord(const Value: string): Boolean;
  published
    property CommentAttri: TSynHighlighterAttributes read fCommentAttri write fCommentAttri;
    property IdentifierAttri: TSynHighlighterAttributes read fIdentifierAttri write fIdentifierAttri;
    property OperAttri: TSynHighlighterAttributes read fOperAttri write fOperAttri;
    property OperAttriFPU: TSynHighlighterAttributes read fOperAttriFPU write fOperAttriFPU;
    property NumberAttri: TSynHighlighterAttributes read fNumberAttri write fNumberAttri;
    property SpaceAttri: TSynHighlighterAttributes read fSpaceAttri write fSpaceAttri;
    property StringAttri: TSynHighlighterAttributes read fStringAttri write fStringAttri;
    property SymbolAttri: TSynHighlighterAttributes read fSymbolAttri write fSymbolAttri;
    property DirAttri: TSynHighlighterAttributes read fDirAttri write fDirAttri;
    property JumpAttri: TSynHighlighterAttributes read fJumpAttri write fJumpAttri;
    property RegAttri: TSynHighlighterAttributes read fRegAttri write fRegAttri;
    property RazAttri: TSynHighlighterAttributes read fRazAttri write fRazAttri;
    property SelectWord: string read fSelectWord write SetSelectWord;
    property UnderscoreWord: string read fUnderscoreWord write SetUnderscoreWord;
  end;

var
  Opt: TOpt;

implementation

uses
  SynEditStrConst;

var
  S: string;

procedure TMySynAsmSyn.DoAddKeywordOper(AKeyword: UnicodeString;
  AKind: integer);
var
  HashValue: Cardinal;
begin
  HashValue := HashKey(PWideChar(AKeyword));
  fKeywordsOper[HashValue] := TSynHashEntry.Create(AKeyword, AKind);
end;

{$Q-}

function TMySynAsmSyn.HashKey(Str: PWideChar): Cardinal;
begin
  Result := 0;
  while IsIdentChar(Str^) do
  begin
    Result := Result * 197 + Ord(Str^) * 14;
    inc(Str);
  end;
  Result := Result mod 4561;
  fStringLen := Str - fToIdent;
end;
{$Q+}

function TMySynAsmSyn.IdentKind(MayBe: PWideChar): TtkTokenKind;
var
  Entry: TSynHashEntry;
begin
  fToIdent := MayBe;

  Entry := fKeywordsOper[HashKey(MayBe)];

  while Assigned(Entry) do
  begin
    if Entry.KeywordLen > fStringLen then
      break
    else if Entry.KeywordLen = fStringLen then
      if IsCurrentToken(Entry.Keyword) then
      begin
        Result := TtkTokenKind(Entry.Kind);
        exit;
      end;
    Entry := Entry.Next;
  end;
  Result := tkIdentifier;
end;

constructor TMySynAsmSyn.Create(const Comand, ComandFPU, Dir, Jump, Regist,
  Raz: UnicodeString; var Opt: TOpt);
begin
  inherited Create(nil);
  fCaseSensitive := False;
  fKeywordsOper := TSynHashEntryList.Create;

  if (Comand = '') or (ComandFPU = '') or (Dir = '') or (Jump = '') or (Regist = '') or (Raz = '') then
  begin
    fCommentAttri := TSynHighlighterAttributes.Create(SYNS_AttrComment, SYNS_FriendlyAttrComment);
    fCommentAttri.Style := [fsItalic];
    fCommentAttri.Foreground := clGreen;
    AddAttribute(fCommentAttri);

    fIdentifierAttri := TSynHighlighterAttributes.Create(SYNS_AttrIdentifier, SYNS_FriendlyAttrIdentifier);
    AddAttribute(fIdentifierAttri);

    fOperAttri := TSynHighlighterAttributes.Create(SYNS_AttrReservedWord, SYNS_FriendlyAttrReservedWord);
    fOperAttri.Style := [fsBold];
    AddAttribute(fOperAttri);
    /// ////////////////////////
    fOperAttriFPU := TSynHighlighterAttributes.Create(SYNS_AttrOperFPU, SYNS_FriendlyAttrOperFPU);
    fOperAttriFPU.Style := [fsBold];
    fOperAttriFPU.Foreground := clTeal;
    AddAttribute(fOperAttriFPU);
    /// ///////////////////////////////////

    fNumberAttri := TSynHighlighterAttributes.Create(SYNS_AttrNumber, SYNS_FriendlyAttrNumber);
    fNumberAttri.Foreground := clBlue;
    AddAttribute(fNumberAttri);

    fSpaceAttri := TSynHighlighterAttributes.Create(SYNS_AttrSpace, SYNS_FriendlyAttrSpace);
    AddAttribute(fSpaceAttri);

    fStringAttri := TSynHighlighterAttributes.Create(SYNS_AttrString, SYNS_FriendlyAttrString);
    fStringAttri.Foreground := clBlue;
    AddAttribute(fStringAttri);

    fSymbolAttri := TSynHighlighterAttributes.Create(SYNS_AttrSymbol, SYNS_FriendlyAttrSymbol);
    AddAttribute(fSymbolAttri);

    // ================================================================
    fDirAttri := TSynHighlighterAttributes.Create(SYNS_AttrDir, SYNS_FriendlyAttrDir);
    fDirAttri.Style := [fsBold];
    fDirAttri.Foreground := clNavy;
    AddAttribute(fDirAttri);

    fJumpAttri := TSynHighlighterAttributes.Create(SYNS_AttrJump, SYNS_FriendlyAttrJump);
    fJumpAttri.Style := [fsBold];
    fJumpAttri.Foreground := clRed;
    AddAttribute(fJumpAttri);

    fRegAttri := TSynHighlighterAttributes.Create(SYNS_AttrRegist, SYNS_FriendlyAttrRegist);
    fRegAttri.Style := [fsBold];
    fRegAttri.Foreground := clHotLight;
    AddAttribute(fRegAttri);

    fRazAttri := TSynHighlighterAttributes.Create(SYNS_AttrRaz, SYNS_FriendlyAttrRaz);
    fRazAttri.Style := [fsBold];
    fRazAttri.Foreground := clRed;
    AddAttribute(fRazAttri);

    // ================================================================

    EnumerateKeywords(Ord(tkOper), Mnemonics, IsIdentChar, DoAddKeywordOper);
    EnumerateKeywords(Ord(tkOperFPU), MnemonicsFPU, IsIdentChar, DoAddKeywordOper);
    EnumerateKeywords(Ord(tkDir), MnemonicsDir, IsIdentChar, DoAddKeywordOper);
    EnumerateKeywords(Ord(tkJump), MnemonicsJump, IsIdentChar, DoAddKeywordOper);
    EnumerateKeywords(Ord(tkReg), MnemonicsRegist, IsIdentChar, DoAddKeywordOper);
    EnumerateKeywords(Ord(tkRaz), MnemonicsRaz, IsIdentChar, DoAddKeywordOper);
  end
  else
  begin
    fCommentAttri := TSynHighlighterAttributes.Create(SYNS_AttrComment, SYNS_FriendlyAttrComment);
    fCommentAttri.Style := Opt.CommentAttri.Style;
    fCommentAttri.Foreground := Opt.CommentAttri.Foreground;
    AddAttribute(fCommentAttri);

    fIdentifierAttri := TSynHighlighterAttributes.Create(SYNS_AttrIdentifier, SYNS_FriendlyAttrIdentifier);
    AddAttribute(fIdentifierAttri);

    fOperAttri := TSynHighlighterAttributes.Create(SYNS_AttrReservedWord, SYNS_FriendlyAttrReservedWord);
    fOperAttri.Style := Opt.OperAttri.Style;
    fOperAttri.Foreground := Opt.OperAttri.Foreground;
    AddAttribute(fOperAttri);
    /// /////////////////////
    fOperAttriFPU := TSynHighlighterAttributes.Create(SYNS_AttrOperFPU, SYNS_FriendlyAttrOperFPU);
    fOperAttriFPU.Style := Opt.OperAttriFPU.Style;
    fOperAttriFPU.Foreground := Opt.OperAttriFPU.Foreground;
    AddAttribute(fOperAttriFPU);
    /// /////////////////////
    fNumberAttri := TSynHighlighterAttributes.Create(SYNS_AttrNumber, SYNS_FriendlyAttrNumber);
    fNumberAttri.Style := Opt.NumberAttri.Style;
    fNumberAttri.Foreground := Opt.NumberAttri.Foreground;
    AddAttribute(fNumberAttri);

    fSpaceAttri := TSynHighlighterAttributes.Create(SYNS_AttrSpace, SYNS_FriendlyAttrSpace);
    AddAttribute(fSpaceAttri);

    fStringAttri := TSynHighlighterAttributes.Create(SYNS_AttrString, SYNS_FriendlyAttrString);
    fStringAttri.Style := Opt.StringAttri.Style;
    fStringAttri.Foreground := Opt.StringAttri.Foreground;
    AddAttribute(fStringAttri);

    fSymbolAttri := TSynHighlighterAttributes.Create(SYNS_AttrSymbol, SYNS_FriendlyAttrSymbol);
    AddAttribute(fSymbolAttri);

    // ================================================================
    fDirAttri := TSynHighlighterAttributes.Create(SYNS_AttrDir, SYNS_FriendlyAttrDir);
    fDirAttri.Style := Opt.DirAttri.Style;
    fDirAttri.Foreground := Opt.DirAttri.Foreground;
    AddAttribute(fDirAttri);

    fJumpAttri := TSynHighlighterAttributes.Create(SYNS_AttrJump, SYNS_FriendlyAttrJump);
    fJumpAttri.Style := Opt.JumpAttri.Style;
    fJumpAttri.Foreground := Opt.JumpAttri.Foreground;
    AddAttribute(fJumpAttri);

    fRegAttri := TSynHighlighterAttributes.Create(SYNS_AttrRegist, SYNS_FriendlyAttrRegist);
    fRegAttri.Style := Opt.RegAttri.Style;;
    fRegAttri.Foreground := Opt.RegAttri.Foreground;;
    AddAttribute(fRegAttri);

    fRazAttri := TSynHighlighterAttributes.Create(SYNS_AttrRaz, SYNS_FriendlyAttrRaz);
    fRazAttri.Style := Opt.RazAttri.Style;;
    fRazAttri.Foreground := Opt.RazAttri.Foreground;;
    AddAttribute(fRazAttri);

    // ================================================================

    EnumerateKeywords(Ord(tkOper), Comand, IsIdentChar, DoAddKeywordOper);
    EnumerateKeywords(Ord(tkOperFPU), ComandFPU, IsIdentChar, DoAddKeywordOper);
    EnumerateKeywords(Ord(tkDir), Dir, IsIdentChar, DoAddKeywordOper);
    EnumerateKeywords(Ord(tkJump), Jump, IsIdentChar, DoAddKeywordOper);
    EnumerateKeywords(Ord(tkReg), Regist, IsIdentChar, DoAddKeywordOper);
    EnumerateKeywords(Ord(tkRaz), Raz, IsIdentChar, DoAddKeywordOper);
  end;

  fSelectWordAttri := TSynHighlighterAttributes.Create('SelectWord', 'SelectWord');
  fSelectWordAttri.Background := $9BFF9B;
  AddAttribute(fSelectWordAttri);
  EnumerateKeywords(Ord(tkSelWord), '', IsIdentChar, DoAddKeywordOper);

  fUnderscoreWordAttri := TSynHighlighterAttributes.Create('UnderscoreWord', 'UnderscoreWord');
  fUnderscoreWordAttri.Style := [fsUnderline];
  fUnderscoreWordAttri.Foreground := clBlue;
  AddAttribute(fUnderscoreWordAttri);
  EnumerateKeywords(Ord(tkUnderscoreWord), '', IsIdentChar, DoAddKeywordOper);

  SetAttributesOnChange(DefHighlightChange);
  fDefaultFilter := SYNS_FilterX86Assembly;
end;

destructor TMySynAsmSyn.Destroy;
begin
  fKeywordsOper.Free;
  inherited Destroy;
end;

procedure TMySynAsmSyn.CommentProc;
begin
  S := '';
  fTokenId := tkComment;
  repeat
    inc(Run);
  until IsLineEnd(Run);
end;

procedure TMySynAsmSyn.CRProc;
begin
  fTokenId := tkSpace;
  inc(Run);
  if fLine[Run] = #10 then
    inc(Run);
end;

procedure TMySynAsmSyn.GreaterProc;
begin
  inc(Run);
  fTokenId := tkSymbol;
  if fLine[Run] = '=' then
    inc(Run);
end;

procedure TMySynAsmSyn.IdentProc;
begin
  S := '';
  fTokenId := IdentKind((fLine + Run));
  S := Copy(fLine, Run + 1, fStringLen);

  if (fSelectWord <> '') and (S = fSelectWord) then
  begin
    fSelectWordAttri.Style := GetTokenAttribute.Style;
    fSelectWordAttri.Foreground := GetTokenAttribute.Foreground;
    fTokenId := tkSelWord;
  end;

  if (fUnderscoreWord <> '') and (S = fUnderscoreWord) then
  begin
    case fTokenId of
      tkIdentifier:
        begin
          fTokenId := tkUnderscoreWord;
        end;
    end;
  end;

  inc(Run, fStringLen);

  while IsIdentChar(fLine[Run]) do
    inc(Run);
end;

procedure TMySynAsmSyn.LFProc;
begin
  fTokenId := tkSpace;
  inc(Run);
end;

procedure TMySynAsmSyn.LowerProc;
begin
  inc(Run);
  fTokenId := tkSymbol;
  if CharInSet(fLine[Run], ['=', '>']) then
    inc(Run);
end;

procedure TMySynAsmSyn.NullProc;
begin
  fTokenId := tkNull;
  inc(Run);
end;

procedure TMySynAsmSyn.NumberProc;

  function IsNumberChar: Boolean;
  begin
    case fLine[Run] of
      '0' .. '9', '.', 'a' .. 'f', 'h', 'A' .. 'F', 'H':
        Result := True;
    else
      Result := False;
    end;
  end;

begin
  S := '';
  S := S + fLine[Run];

  inc(Run);
  fTokenId := tkNumber;
  while IsNumberChar do
  begin
    S := S + fLine[Run];
    inc(Run);
  end;

  if (fSelectWord <> '') and (S = fSelectWord) then
  begin
    fSelectWordAttri.Style := fNumberAttri.Style;
    fSelectWordAttri.Foreground := fNumberAttri.Foreground;
    fTokenId := tkSelWord;
  end;

end;

procedure TMySynAsmSyn.SlashProc;
begin
  inc(Run);
  fTokenId := tkSymbol;
end;

procedure TMySynAsmSyn.SpaceProc;
begin
  fTokenId := tkSpace;
  repeat
    inc(Run);
  until (fLine[Run] > #32) or IsLineEnd(Run);
end;

procedure TMySynAsmSyn.StringProc;
begin
  fTokenId := tkString;
  if (fLine[Run + 1] = #34) and (fLine[Run + 2] = #34) then
    inc(Run, 2);
  repeat
    case fLine[Run] of
      #0, #10, #13:
        break;
    end;
    inc(Run);
  until fLine[Run] = #34;
  if fLine[Run] <> #0 then
    inc(Run);
end;

procedure TMySynAsmSyn.SetSelectWord(const Value: string);
begin
  fSelectWord := LowerCase(Value);
end;

procedure TMySynAsmSyn.SetUnderscoreWord(const Value: string);
begin
  fUnderscoreWord := LowerCase(Value);
end;

function TMySynAsmSyn.equalsUnderscoreWord(const Value: string): Boolean;
begin
  Result := (fUnderscoreWord = LowerCase(Value))
end;

procedure TMySynAsmSyn.SingleQuoteStringProc;
begin
  fTokenId := tkString;
  if (fLine[Run + 1] = #39) and (fLine[Run + 2] = #39) then
    inc(Run, 2);
  repeat
    case fLine[Run] of
      #0, #10, #13:
        break;
    end;
    inc(Run);
  until fLine[Run] = #39;
  if fLine[Run] <> #0 then
    inc(Run);
end;

procedure TMySynAsmSyn.SymbolProc;
begin
  inc(Run);
  fTokenId := tkSymbol;
end;

procedure TMySynAsmSyn.UnknownProc;
begin
  inc(Run);
  fTokenId := tkIdentifier;
end;

procedure TMySynAsmSyn.Next;
var
  S: string;
begin
  fTokenPos := Run;
  case fLine[Run] of
    #0:
      NullProc;
    #10:
      LFProc;
    #13:
      CRProc;
    #34:
      StringProc;
    #39:
      SingleQuoteStringProc;
    '>':
      GreaterProc;
    '<':
      LowerProc;
    '/':
      SlashProc;
    'A' .. 'Z', 'a' .. 'z', '_':
      IdentProc;
    '0' .. '9':
      NumberProc;
    #1 .. #9, #11, #12, #14 .. #32:
      SpaceProc;
    ';':
      CommentProc;
    '.', '?', ':', '&', '{', '}', '=', '^', '-', '+', '(', ')', '*':
      SymbolProc;
  else
    UnknownProc;
  end;
  inherited;
end;

function TMySynAsmSyn.GetDefaultAttribute(Index: integer)
  : TSynHighlighterAttributes;
begin
  case Index of
    SYN_ATTR_COMMENT:
      Result := fCommentAttri;
    SYN_ATTR_IDENTIFIER:
      Result := fIdentifierAttri;
    SYN_ATTR_KEYWORD:
      Result := fOperAttri;
    SYN_ATTR_OPERFPU:
      Result := fOperAttriFPU;
    SYN_ATTR_STRING:
      Result := fStringAttri;
    SYN_ATTR_WHITESPACE:
      Result := fSpaceAttri;
    SYN_ATTR_SYMBOL:
      Result := fSymbolAttri;
    SYN_ATTR_DIR:
      Result := fDirAttri;
    SYN_ATTR_JUMP:
      Result := fJumpAttri;
    SYN_ATTR_REGISTR:
      Result := fRegAttri;
    SYN_ATTR_RAZ:
      Result := fRazAttri;
    SYN_ATTR_SELWORD:
      Result := fSelectWordAttri;
    SYN_ATTR_UNDERSCOREWORD:
      Result := fUnderscoreWordAttri;
  else
    Result := nil;
  end;
end;

function TMySynAsmSyn.GetEol: Boolean;
begin
  Result := Run = fLineLen + 1;
end;

function TMySynAsmSyn.GetTokenAttribute: TSynHighlighterAttributes;
begin
  case fTokenId of
    tkComment:
      Result := fCommentAttri;
    tkIdentifier:
      Result := fIdentifierAttri;
    tkOper:
      Result := fOperAttri;
    tkOperFPU:
      Result := fOperAttriFPU;
    tkNumber:
      Result := fNumberAttri;
    tkSpace:
      Result := fSpaceAttri;
    tkString:
      Result := fStringAttri;
    tkSymbol:
      Result := fSymbolAttri;
    tkDir:
      Result := fDirAttri;
    tkJump:
      Result := fJumpAttri;
    tkReg:
      Result := fRegAttri;
    tkRaz:
      Result := fRazAttri;
    tkSelWord:
      Result := fSelectWordAttri;
    tkUnderscoreWord:
      Result := fUnderscoreWordAttri;
    tkUnknown:
      Result := fIdentifierAttri;
  else
    Result := nil;
  end;
end;

function TMySynAsmSyn.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

function TMySynAsmSyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

class function TMySynAsmSyn.GetLanguageName: string;
begin
  Result := SYNS_LangX86Asm;
end;

function TMySynAsmSyn.IsFilterStored: Boolean;
begin
  Result := fDefaultFilter <> SYNS_FilterX86Assembly;
end;

function TMySynAsmSyn.GetSampleSource: UnicodeString;
begin
  Result := '; x86 assembly sample source'#13#10 +
    '  CODE	SEGMENT	BYTE PUBLIC'#13#10 + '    ASSUME	CS:CODE'#13#10 + #13#10 +
    '    PUSH SS'#13#10 + '    POP DS'#13#10 + '    MOV AX, AABBh'#13#10 +
    '    MOV	BYTE PTR ES:[DI], 255'#13#10 + '    JMP SHORT AsmEnd'#13#10 +
    #13#10 + '  welcomeMsg DB ''Hello World'', 0'#13#10 + #13#10 +
    '  AsmEnd:'#13#10 + '    MOV AX, 0'#13#10 + #13#10 +
    '  CODE	ENDS'#13#10 + 'END';
end;

class function TMySynAsmSyn.GetFriendlyLanguageName: UnicodeString;
begin
  Result := SYNS_FriendlyLangX86Asm;
end;

end.
