object FormOptions: TFormOptions
  Left = 363
  Top = 325
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 236
  ClientWidth = 460
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001001800680300001600000028000000100000002000
    0000010018000000000000030000000000000000000000000000000000000000
    004A4A6B5A5A6300000000000000000000000000000000000000000000000000
    000000000000000000000000000031399C3142E70818A5212142000000000000
    000000000000000000000000000000ADADAD524A4A848484000000000000525A
    C6ADBDFF425AFF0010BD181842000000000000000000000000000000A5A5A584
    7B7BCEBDBD524A4A7B7B7B0000008484BD9494D6B5C6FF4252F70810BD181842
    0000000000000000009C9C9C8C8484EFDEDEEFDEDED6C6C6635A5A8484840000
    007373AD949CD6BDC6FF4A5AEF0810AD2929420000009C9C9C8C8484EFDEDEEF
    E7E7DED6D6FFF7F7A59C9C847B7B0000000000007B7BB58484CEB5BDFF525AEF
    00088431314294847BEFDEDEEFE7E7F7F7F7FFFFFFB5ADAD7B73730000000000
    00000000000000B5B5D6636BAD9C9CEF5252DE10109C5A529CE7DEDEFFF7F7FF
    FFFFADA5A5847B7B00000000000000000000000000000000000063637342427B
    9CA5EF3131BD5A5AA5F7F7F7FFFFFFA59C9C8484840000000000000000000000
    00A5A5A56B6363948C84A5948C7B73846363B57B7BA5B5B5ADDEDEDE94949494
    9494000000000000000000000000ADADAD948484E7D6D6EFDEDEEFDEDEDECECE
    B5ADBDE7DEDEDED6CE9C9494423939000000000000000000000000000000847B
    7BE7D6DEEFE7E7E7D6D6DED6D6E7DED6EFDED6EFDEDE8C8484948C8C8C848442
    4242000000000000000000000000ADA5A5FFF7F7DED6D67B7373847B7BDECECE
    F7EFEFDED6D64A4A4A000000B5B5B59C9494423939A5A5A5000000000000ADA5
    A5EFE7E77B7373EFEFEF6B6B6BD6CECEFFFFFFE7DEDE524A4A000000000000AD
    ADADADA5A56B63635252520000000000007B7373DEDEDE7B7373BDB5B5FFF7F7
    FFFFFFB5ADAD737373000000000000000000ADADADF7EFEF6B63639494940000
    00000000848484CEC6C6FFFFFFFFFFFFD6CECE63636300000000000000000000
    0000000000ADADAD8C8484A5A5A5000000000000000000B5ADADB5ADAD9C9494
    847B7B0000000000000000000000000000000000000000000000000000009FFF
    00000FE3000007C100000380000081000000C0010000E0030000F0070000800F
    0000001F0000000F0000004300000061000080700000C0F80000E1FF0000}
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 460
    Height = 195
    ActivePage = Prog
    Align = alClient
    Images = ImageList1
    TabOrder = 0
    object Prog: TTabSheet
      Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1072
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 452
        Height = 44
        Align = alTop
        Caption = #1040#1089#1086#1094#1080#1072#1094#1080#1080
        TabOrder = 0
        object CheckBox1: TCheckBox
          Left = 13
          Top = 18
          Width = 121
          Height = 17
          Caption = 'prt - '#1092#1072#1081#1083#1099' '#1087#1088#1086#1077#1082#1090#1072
          TabOrder = 0
          OnClick = CheckBox1Click
        end
        object CheckBox2: TCheckBox
          Left = 172
          Top = 18
          Width = 110
          Height = 17
          Caption = 'asm - '#1092#1072#1081#1083#1099' '#1082#1086#1076#1072
          TabOrder = 1
          OnClick = CheckBox2Click
        end
        object CheckBox3: TCheckBox
          Left = 322
          Top = 18
          Width = 121
          Height = 17
          Caption = 'inc - include-'#1092#1072#1081#1083#1099
          TabOrder = 2
          OnClick = CheckBox3Click
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 44
        Width = 452
        Height = 122
        Align = alClient
        Caption = 'FASM/DBG'
        TabOrder = 1
        object Label1: TLabel
          Left = 13
          Top = 28
          Width = 31
          Height = 13
          Caption = 'FASM:'
        end
        object Label6: TLabel
          Left = 13
          Top = 88
          Width = 24
          Height = 13
          Caption = 'DBG:'
        end
        object Label13: TLabel
          Left = 13
          Top = 58
          Width = 22
          Height = 13
          Caption = 'INC:'
        end
        object EditFASM: TEdit
          Left = 50
          Top = 25
          Width = 362
          Height = 21
          TabOrder = 0
          Text = 'C:\FASM\FASM.EXE'
        end
        object BFasm: TButton
          Left = 422
          Top = 25
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 1
          OnClick = BFasmClick
        end
        object EditDBG: TEdit
          Left = 50
          Top = 85
          Width = 362
          Height = 21
          TabOrder = 2
          Text = 'C:\OLLYDBG\ollydbg.exe'
        end
        object BDBG: TButton
          Left = 422
          Top = 85
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 3
          OnClick = BDBGClick
        end
        object EditINC: TEdit
          Left = 50
          Top = 55
          Width = 362
          Height = 21
          TabOrder = 4
          Text = 'C:\FASM\INCLUDE'
        end
        object BINC: TButton
          Left = 422
          Top = 55
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 5
          OnClick = BINCClick
        end
      end
    end
    object CodeEditor: TTabSheet
      Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1082#1086#1076#1072
      ImageIndex = 1
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 452
        Height = 166
        ActivePage = TabSheet1
        Align = alClient
        TabOrder = 0
        object TabSheet1: TTabSheet
          Caption = #1056#1077#1076#1072#1082#1090#1086#1088
          object Label2: TLabel
            Left = 9
            Top = 12
            Width = 24
            Height = 13
            Caption = #1060#1086#1085':'
          end
          object Label3: TLabel
            Left = 9
            Top = 57
            Width = 40
            Height = 13
            Caption = #1064#1088#1080#1092#1090':'
          end
          object Label4: TLabel
            Left = 9
            Top = 104
            Width = 58
            Height = 13
            Caption = #1058#1072#1073#1091#1083#1103#1094#1080#1103':'
          end
          object ColorEdit: TColorBox
            Left = 80
            Top = 9
            Width = 361
            Height = 22
            Selected = clWindow
            TabOrder = 2
          end
          object SpinEditTab: TSpinEdit
            Left = 80
            Top = 101
            Width = 49
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 1
            Value = 2
          end
          object BFont: TButton
            Left = 420
            Top = 53
            Width = 21
            Height = 21
            Caption = '...'
            TabOrder = 0
            OnClick = BFontClick
          end
          object SynMemoOpt: TSynMemo
            Left = 273
            Top = 83
            Width = 141
            Height = 52
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Courier New'
            Font.Style = []
            TabOrder = 3
            Visible = False
            CodeFolding.GutterShapeSize = 11
            CodeFolding.CollapsedLineColor = clGrayText
            CodeFolding.FolderBarLinesColor = clGrayText
            CodeFolding.IndentGuidesColor = clGray
            CodeFolding.IndentGuides = True
            CodeFolding.ShowCollapsedLine = False
            CodeFolding.ShowHintMark = True
            UseCodeFolding = False
            Gutter.AutoSize = True
            Gutter.Color = clWindow
            Gutter.BorderColor = clSilver
            Gutter.Font.Charset = DEFAULT_CHARSET
            Gutter.Font.Color = clTeal
            Gutter.Font.Height = -11
            Gutter.Font.Name = 'Courier New'
            Gutter.Font.Style = []
            Gutter.LeftOffset = 20
            Gutter.RightOffset = 5
            Gutter.ShowLineNumbers = True
            Gutter.Width = 16
            Gutter.Gradient = True
            Gutter.GradientStartColor = clBtnFace
            Gutter.GradientEndColor = clWindow
            Options = [eoAutoIndent, eoDragDropEditing, eoEnhanceEndKey, eoGroupUndo, eoScrollHintFollows, eoScrollPastEol, eoShowScrollHint, eoSmartTabDelete, eoSmartTabs, eoTabsToSpaces]
            SelectedColor.Background = clHotLight
            TabWidth = 2
            WantTabs = True
            FontSmoothing = fsmNone
          end
          object Panel2: TPanel
            Left = 80
            Top = 52
            Width = 334
            Height = 25
            BevelOuter = bvNone
            TabOrder = 4
            object EditFont: TEdit
              Left = 0
              Top = 0
              Width = 334
              Height = 25
              Align = alClient
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Courier New'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              Text = 'Courier New, 10'
              ExplicitHeight = 24
            end
          end
        end
        object TabSheet2: TTabSheet
          Caption = #1050#1086#1084#1077#1085#1090#1072#1088#1080#1081
          ImageIndex = 1
          object Label5: TLabel
            Left = 9
            Top = 12
            Width = 73
            Height = 13
            Caption = #1062#1074#1077#1090' '#1096#1088#1080#1092#1090#1072':'
          end
          object ColorComent: TColorBox
            Left = 88
            Top = 9
            Width = 353
            Height = 22
            Selected = clGreen
            TabOrder = 0
          end
          object Check1Coment: TCheckBox
            Left = 9
            Top = 44
            Width = 97
            Height = 17
            Caption = #1046#1080#1088#1085#1099#1081
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object Check2Coment: TCheckBox
            Left = 9
            Top = 75
            Width = 97
            Height = 17
            Caption = #1050#1091#1088#1089#1080#1074
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
          object Check3Coment: TCheckBox
            Left = 9
            Top = 106
            Width = 97
            Height = 17
            Caption = #1055#1086#1076#1095#1077#1088#1082#1085#1091#1090#1099#1081
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
        end
        object TabSheet3: TTabSheet
          Caption = #1063#1080#1089#1083#1086
          ImageIndex = 2
          object Label7: TLabel
            Left = 9
            Top = 12
            Width = 73
            Height = 13
            Caption = #1062#1074#1077#1090' '#1096#1088#1080#1092#1090#1072':'
          end
          object Check1Number: TCheckBox
            Left = 9
            Top = 44
            Width = 97
            Height = 17
            Caption = #1046#1080#1088#1085#1099#1081
            TabOrder = 0
          end
          object ColorNumber: TColorBox
            Left = 88
            Top = 9
            Width = 353
            Height = 22
            Selected = clBlue
            TabOrder = 1
          end
          object Check2Number: TCheckBox
            Left = 9
            Top = 75
            Width = 97
            Height = 17
            Caption = #1050#1091#1088#1089#1080#1074
            TabOrder = 2
          end
          object Check3Number: TCheckBox
            Left = 9
            Top = 106
            Width = 97
            Height = 17
            Caption = #1055#1086#1076#1095#1077#1088#1082#1085#1091#1090#1099#1081
            TabOrder = 3
          end
        end
        object TabSheet4: TTabSheet
          Caption = #1057#1090#1088#1086#1082#1072
          ImageIndex = 3
          object Label8: TLabel
            Left = 9
            Top = 12
            Width = 73
            Height = 13
            Caption = #1062#1074#1077#1090' '#1096#1088#1080#1092#1090#1072':'
          end
          object Check1String: TCheckBox
            Left = 9
            Top = 44
            Width = 97
            Height = 17
            Caption = #1046#1080#1088#1085#1099#1081
            TabOrder = 0
          end
          object ColorString: TColorBox
            Left = 88
            Top = 9
            Width = 353
            Height = 22
            Selected = clBlue
            TabOrder = 1
          end
          object Check2String: TCheckBox
            Left = 9
            Top = 75
            Width = 97
            Height = 17
            Caption = #1050#1091#1088#1089#1080#1074
            TabOrder = 2
          end
          object Check3String: TCheckBox
            Left = 9
            Top = 106
            Width = 97
            Height = 17
            Caption = #1055#1086#1076#1095#1077#1088#1082#1085#1091#1090#1099#1081
            TabOrder = 3
          end
        end
        object TabSheet5: TTabSheet
          Caption = #1044#1080#1088#1077#1082#1090#1080#1074#1072
          ImageIndex = 4
          object Label9: TLabel
            Left = 9
            Top = 12
            Width = 73
            Height = 13
            Caption = #1062#1074#1077#1090' '#1096#1088#1080#1092#1090#1072':'
          end
          object MemoDir: TMemo
            Left = 0
            Top = 38
            Width = 444
            Height = 100
            Align = alBottom
            Lines.Strings = (
              
                'model,flat,stdcall,option,casemap,none,const,include,includelib,' +
                'proto,data, '
              
                'code,segment,ends,public,use32,use16,assume,byte,word,dword,qwor' +
                'd,'
              
                'tword,db,dw,dd,dq,dt,rb,equ,macro,vararg,endm,invoke,dup,proc,en' +
                'dp,'
              
                'local,addr,offset,end,mmx,xmm,sizeof,ptr,true,false,format,pe,pe' +
                '64,console,'
              
                'ms,coff,binary,extrn,as,gui,section,readable,executable,writeabl' +
                'e,import,library,'
              
                'entry,resource,directory,interface,struct,union,cominvk,virtual,' +
                'at,export,'
              
                'fixups,discardable,dll,use64,large,while,endw,repeat,for,break,i' +
                'f,elseif,'
              
                'else,endif,native,notpageable,uses,align,stack,restore,purge,com' +
                'mon,'
              
                'forward,reverse,eq,eqtype,fword,pword,tbyte,dqword,from,shareabl' +
                'e,'
              
                'heap,mz,ms64,elf,elf64,du,rw,rd,dp,df,rp,rf,rq,rt,rva,near,far,d' +
                'efine,irp,'
              
                'irps,match,rept,restruc,note,dynamic,linkinfo,efiruntime,linkrem' +
                'ove,'
              
                'interpreter,static,efiboot,comcall,locals,endl,qqword,xword,ywor' +
                'd,,ccall,'
              'cinvoke,struc,fix,org,file,menu,menuitem,menuseparator,dialog,'
              
                'dialogitem,enddialog,icon,bitmap,cursor,resdata,endres,accelerat' +
                'or,'
              'versioninfo,syslibrary,fastcall')
            ScrollBars = ssVertical
            TabOrder = 0
          end
          object Check1Dir: TCheckBox
            Left = 184
            Top = 11
            Width = 65
            Height = 17
            Caption = #1046#1080#1088#1085#1099#1081
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object ColorDir: TColorBox
            Left = 88
            Top = 9
            Width = 81
            Height = 22
            Selected = clNavy
            TabOrder = 2
          end
          object Check2Dir: TCheckBox
            Left = 266
            Top = 11
            Width = 57
            Height = 17
            Caption = #1050#1091#1088#1089#1080#1074
            TabOrder = 3
          end
          object Check3Dir: TCheckBox
            Left = 344
            Top = 11
            Width = 97
            Height = 17
            Caption = #1055#1086#1076#1095#1077#1088#1082#1085#1091#1090#1099#1081
            TabOrder = 4
          end
        end
        object TabSheet6: TTabSheet
          Caption = #1050#1086#1084#1072#1085#1076#1072
          ImageIndex = 5
          object Label10: TLabel
            Left = 9
            Top = 12
            Width = 73
            Height = 13
            Caption = #1062#1074#1077#1090' '#1096#1088#1080#1092#1090#1072':'
          end
          object MemoCommand: TMemo
            Left = 0
            Top = 38
            Width = 444
            Height = 100
            Align = alBottom
            Lines.Strings = (
              
                'aaa,aad,aam,adc,add,and,arpl,bound,bsf,bsr,bswap,bt,btc,btr,bts,' +
                'cbw,cdq,clc,cld,'
              
                'cli,clts,cmc,cmp,cmps,cmpsb,cmpsd,cmpsw,cmpxchg,cwd,cwde,daa,das' +
                ',dec,div,'
              
                'emms,enter,hlt,idiv,imul,in,inc,ins,insb,insd,insw,int,into,invd' +
                ',invlpg,iret,iretd,iretw,'
              
                'lahf,lar,lds,wait,wbinvd,xadd,xchg,xlat,xlatb,xor,rdtsc,cpuid,le' +
                'a,leave,les,lfs,lgdt,'
              
                'lgs,lidt,lldt,lmsw,lock,lods,lodsb,lodsd,lodsw,lsl,lss,ltr,mov,m' +
                'ovd,movq, movs,movsb,'
              
                'movsd,movsw,movsx,movzx,mul,neg,nop,not,or,out,outs,outsb,outsd,' +
                'outsw,'
              
                'packssdw,packsswb,packuswb,paddb,paddd,paddsb,paddsw,paddusb,pad' +
                'dusw,'
              
                'paddw,pand,pandn,pavgusb,pcmpeqb,pcmpeqd,pcmpeqw,pcmpgtb,pcmpgtd' +
                ','
              
                'pcmpgtw,pf2id,pfacc,pfadd,pfcmpeq,pfcmpge,pfcmpgt,pfmax,pfmin,pf' +
                'mul,pfrcp,'
              
                'pfrcpit1,pfrcpit2,pfrsqit1,pfrsqrt,pfsub,pfsubr,pi2fd,pmaddwd,pm' +
                'ulhrw,'
              
                'pmulhw,pmullw,pop,popa,popad,popaw,popf,popfd,popfw,por,prefetch' +
                ',prefetchw,'
              
                'pslld,psllq,psllw,psrad,psraw,psrld,psrlq,psrlw,psubb,psubd,psub' +
                'sb,'
              
                'psubsw,psubusb,psubusw,psubw,punpckhbw,punpckhdq,punpckhwd,punpc' +
                'klbw,'
              
                'punpckldq,punpcklwd,push,pusha,pushad,pushaw,pushf,pushfd,pushfw' +
                ',pxor,'
              
                'rcl,rcr,rep,repe,repne,repnz,repz,rol,ror,sahf,sal,sar,sbb,scas,' +
                'movups,'
              
                'scasb,scasd,scasw,seta,setae,setb,setbe,setc,sete,setg,setge,set' +
                'l,setle,'
              
                'setna,setnae,setnb,setnbe,setnc,setne,setng,setnge,setnl,setnle,' +
                'setno,'
              
                'setnp,setns,setnz,seto,setp,setpo,sets,setz,sgdt,shl,shld,shr,sh' +
                'rd,sidt,'
              
                'sldt,smsw,stc,std,sti,stos,stosb,stosd,stosw,str,sub,test,verr,v' +
                'erw')
            ScrollBars = ssVertical
            TabOrder = 0
          end
          object ColorCommand: TColorBox
            Left = 88
            Top = 9
            Width = 81
            Height = 22
            TabOrder = 1
          end
          object Check1Command: TCheckBox
            Left = 184
            Top = 11
            Width = 65
            Height = 17
            Caption = #1046#1080#1088#1085#1099#1081
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
          object Check2Command: TCheckBox
            Left = 266
            Top = 11
            Width = 57
            Height = 17
            Caption = #1050#1091#1088#1089#1080#1074
            TabOrder = 3
          end
          object Check3Command: TCheckBox
            Left = 344
            Top = 11
            Width = 97
            Height = 17
            Caption = #1055#1086#1076#1095#1077#1088#1082#1085#1091#1090#1099#1081
            TabOrder = 4
          end
        end
        object TabSheet10: TTabSheet
          Caption = #1050#1086#1084#1072#1085#1076#1072' FPU'
          ImageIndex = 9
          object Label15: TLabel
            Left = 9
            Top = 12
            Width = 73
            Height = 13
            Caption = #1062#1074#1077#1090' '#1096#1088#1080#1092#1090#1072':'
          end
          object MemoCommandFPU: TMemo
            Left = 0
            Top = 38
            Width = 444
            Height = 100
            Align = alBottom
            Lines.Strings = (
              
                'fabs,fadd,fbld,fchs,fcom,fcos,fdiv,feni,fild,fist,fld1,fldz,fmul' +
                ',fnop,fsin,fstp,fsub,'
              
                'ftst,fxam,fxch,f2xm1,faddp,fbstp,fclex,fcomi,fcomp,fdisi,fdivp,f' +
                'divr,femms,ffree,'
              
                'fiadd,ficom,fidiv,fimul,finit,fistp,fisub,fldcw,fldpi,fmulp,fnen' +
                'i,fprem,fptan,fsave,'
              
                'fsqrt,fstcw,fstsw,fsubp,fsubr,fucom,fwait,fyl2x,fcmovb,fcmove,fc' +
                'movu,fcomip,'
              
                'fcompp,fdivrp,ffreep,ficomp,fidivr,fisttp,fisubr,fldenv,fldl2e,f' +
                'ldl2t,fldlg2,fldln2,'
              
                'fnclex,fndisi,fninit,fnsave,fnstcw,fnstsw,fpatan,fprem1,frstor,f' +
                'rstpm,fsaved,'
              
                'fsavew,fscale,fsetpm,fstenv,fsubrp,fucomi,fucomp,fxsave,fcmovbe,' +
                'fcmovnb,'
              
                'fcmovne,fcmovnu,fdecstp,fincstp,fldenvd,fldenvw,fnsaved,fnsavew,' +
                'fnstenv,'
              
                'frndint,frstord,frstorw,fsincos,fstenvd,fstenvw,fucomip,fucompp,' +
                'fxrstor,fxtract,'
              'fyl2xp1,fcmovnbe,fnstenvd,fnstenvw,fld,fst')
            ScrollBars = ssVertical
            TabOrder = 0
          end
          object ColorCommandFPU: TColorBox
            Left = 88
            Top = 9
            Width = 81
            Height = 22
            Selected = clTeal
            TabOrder = 1
          end
          object Check1CommandFPU: TCheckBox
            Left = 184
            Top = 11
            Width = 65
            Height = 17
            Caption = #1046#1080#1088#1085#1099#1081
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
          object Check2CommandFPU: TCheckBox
            Left = 266
            Top = 11
            Width = 57
            Height = 17
            Caption = #1050#1091#1088#1089#1080#1074
            TabOrder = 3
          end
          object Check3CommandFPU: TCheckBox
            Left = 344
            Top = 11
            Width = 97
            Height = 17
            Caption = #1055#1086#1076#1095#1077#1088#1082#1085#1091#1090#1099#1081
            TabOrder = 4
          end
        end
        object TabSheet9: TTabSheet
          Caption = #1055#1088#1099#1078#1086#1082
          ImageIndex = 8
          object Label14: TLabel
            Left = 9
            Top = 12
            Width = 73
            Height = 13
            Caption = #1062#1074#1077#1090' '#1096#1088#1080#1092#1090#1072':'
          end
          object MemoJump: TMemo
            Left = 0
            Top = 38
            Width = 444
            Height = 100
            Align = alBottom
            Lines.Strings = (
              
                'ja,jae,jb,jbe,jc,jcxz,je,jecxz,jg,jge,jl,jle,jmp,jna,jnae,jnb,jn' +
                'be,jnc,jne,jng,jnge,jnl,'
              
                'jnle,jno,jnp,jns,jnz,jo,jp,jpe,jpo,js,jz,call,ret,loop,loope,loo' +
                'pne,loopnz,loopz')
            ScrollBars = ssVertical
            TabOrder = 0
          end
          object Check1Jump: TCheckBox
            Left = 184
            Top = 11
            Width = 65
            Height = 17
            Caption = #1046#1080#1088#1085#1099#1081
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object ColorJump: TColorBox
            Left = 88
            Top = 9
            Width = 81
            Height = 22
            Selected = clFuchsia
            TabOrder = 2
          end
          object Check2Jump: TCheckBox
            Left = 266
            Top = 11
            Width = 57
            Height = 17
            Caption = #1050#1091#1088#1089#1080#1074
            TabOrder = 3
          end
          object Check3Jump: TCheckBox
            Left = 344
            Top = 11
            Width = 97
            Height = 17
            Caption = #1055#1086#1076#1095#1077#1088#1082#1085#1091#1090#1099#1081
            TabOrder = 4
          end
        end
        object TabSheet7: TTabSheet
          Caption = #1056#1077#1075#1080#1089#1090#1088
          ImageIndex = 6
          object Label11: TLabel
            Left = 9
            Top = 12
            Width = 73
            Height = 13
            Caption = #1062#1074#1077#1090' '#1096#1088#1080#1092#1090#1072':'
          end
          object MemoReg: TMemo
            Left = 0
            Top = 38
            Width = 444
            Height = 100
            Align = alBottom
            Lines.Strings = (
              
                'eax,ax,al,ah,ebx,bx,bl,bh,ecx,cx,cl,ch,edx,dx,dl,dh,esi,si,edi,d' +
                'i,ebp,bp,'
              'esp,sp,cs,ds,es,ss,gs,fs,mm0,mm1,mm2,mm3,mm4,mm5,mm6,mm7,xmm0,'
              'xmm1,xmm2,xmm3,xmm4,xmm5,xmm6,xmm7,xmm8,xmm9,xmm10,xmm11,'
              
                'xmm12,xmm13,xmm14,xmm15,rbx,rsp,rcx,rax,rdx,rbp,rsi,rdi,rip,r8,r' +
                '8d,'
              
                'r9,r9d,r10,r10d,r11,r11d,r12,r12d,r13,r13d,r14,r14d,r15,r15d,cr0' +
                ',cr2,'
              
                'cr3,cr4,dr0,dr1,dr2,dr3,dr6,dr7,st0,st1,st2,st3,st4,st5,st6,st7,' +
                'ymm0,ymm1,'
              'ymm2,ymm3,ymm4,ymm5,ymm6,ymm7,ymm8,ymm9,r13w,r14w,r15w,rflags,'
              
                'sil,dil,spl,bpl,r8l,r9l,r10l,r11l,r12l,r13l,r14l,r15l,r8w,r9w,r1' +
                '0w,r11w,r12w')
            ScrollBars = ssVertical
            TabOrder = 0
          end
          object ColorReg: TColorBox
            Left = 88
            Top = 9
            Width = 81
            Height = 22
            Selected = clHotLight
            TabOrder = 1
          end
          object Check1Reg: TCheckBox
            Left = 184
            Top = 11
            Width = 65
            Height = 17
            Caption = #1046#1080#1088#1085#1099#1081
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
          object Check2Reg: TCheckBox
            Left = 266
            Top = 11
            Width = 57
            Height = 17
            Caption = #1050#1091#1088#1089#1080#1074
            TabOrder = 3
          end
          object Check3Reg: TCheckBox
            Left = 344
            Top = 11
            Width = 97
            Height = 17
            Caption = #1055#1086#1076#1095#1077#1088#1082#1085#1091#1090#1099#1081
            TabOrder = 4
          end
        end
        object TabSheet8: TTabSheet
          Caption = #1056#1072#1079#1085#1086#1077
          ImageIndex = 7
          object Label12: TLabel
            Left = 9
            Top = 12
            Width = 73
            Height = 13
            Caption = #1062#1074#1077#1090' '#1096#1088#1080#1092#1090#1072':'
          end
          object MemoRaz: TMemo
            Left = 0
            Top = 38
            Width = 444
            Height = 100
            Align = alBottom
            Lines.Strings = (
              'start')
            TabOrder = 0
          end
          object ColorRaz: TColorBox
            Left = 88
            Top = 9
            Width = 81
            Height = 22
            Selected = clRed
            TabOrder = 1
          end
          object Check1Raz: TCheckBox
            Left = 184
            Top = 11
            Width = 65
            Height = 17
            Caption = #1046#1080#1088#1085#1099#1081
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
          object Check2Raz: TCheckBox
            Left = 266
            Top = 11
            Width = 57
            Height = 17
            Caption = #1050#1091#1088#1089#1080#1074
            TabOrder = 3
          end
          object Check3Raz: TCheckBox
            Left = 344
            Top = 11
            Width = 97
            Height = 17
            Caption = #1055#1086#1076#1095#1077#1088#1082#1085#1091#1090#1099#1081
            TabOrder = 4
          end
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 195
    Width = 460
    Height = 41
    Align = alBottom
    TabOrder = 1
    object Button1: TButton
      Left = 207
      Top = 6
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 292
      Top = 6
      Width = 75
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      ModalResult = 11
      TabOrder = 1
    end
    object Button3: TButton
      Left = 377
      Top = 6
      Width = 75
      Height = 25
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = #1048#1089#1087#1086#1083#1085#1103#1077#1084#1099#1081' '#1092#1072#1081#1083' (*.exe)|*.exe'
    Left = 8
    Top = 184
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 112
    Top = 192
  end
  object ImageList1: TImageList
    ColorDepth = cd32Bit
    DrawingStyle = dsTransparent
    Left = 60
    Top = 185
    Bitmap = {
      494C010102000800040010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003738384E474F4F8421212127000000001818181C010101020000
      00000000000000000000000000000000000000000000000000000909090A1717
      171A1717171A1717171A1717171A1717171A1717171A1717171A1717171A1717
      171A1717171A0909090A00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002526
      262E48575E9D467883E652B1BAFF487479E1444849813F3E3E690F0F0F100000
      00000000000000000000000000000000000000000000000000008F8F90DFCBCC
      CDFFCBCCCDFFCBCCCDFFCBCCCDFFCBCCCDFFCBCCCDFFCBCCCDFFCBCCCDFFCBCC
      CDFFCBCCCDFF939494E300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004850
      54815BC6EEFF5EBDDDFF5CB3CEFF59B6D0FF55A9BFFF4A6B75ED474D50AC3A3C
      3D57212121280C0C0C0D00000000000000000000000000000000919192DFCECE
      CFFFCECECFFFCECECFFFCECECFFFCECECFFFCECECFFFCECECFFFCECECFFFCECE
      CFFFCECECFFF949494E300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004B66
      72B25CC2E3FF60B2CAFF5AA8C1FF58B0CBFF62BED7FF5B8AA9FF556E8EFF4487
      9EFF488299EE42677BD6393B3C54000000000000000000000000939394DFE0CE
      BDFFE1CEBCFFE1CEBCFFE1CEBCFFE1CEBCFFE1CEBCFF918880FFD3D3D4FFD4D4
      D5FFD4D4D5FF969797E300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000F0F0F105089
      9ADE60C2DEFF60A6BCFF5EA4BAFF5AA8BFFF56A8BCFF4F87A7FF62709EFF496E
      8DFF5AB4CCFF5DBADFFF4247496B000000000000000000000000949495DFE5CE
      B7FFC0A78EFFBDA48BFFBDA48BFFBDA48BFFBDA48BFFADA297FFD7D7D8FFD7D7
      D8FFD7D7D8FF989999E300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003A3B3C5663B4
      CFFD70C4DCFF68ABC0FF64A9BEFF68AEC3FF5DAABEFF56A1B6FF5777A5FF5966
      99FF5594ADFF5DACC3F827272730000000000000000000000000979797DFE7D0
      B8FFE3CAB1FFE3C9B1FFE3C9B1FFE3C9B1FFE3C9B1FFCDB6A0FFE3C9B1FFE3CA
      B1FFE7CFB8FF9B9B9CE300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000C0C0C0D496970C95EB5
      D2FF64AFC6FF72B1C4FF78B4C7FF77B8CBFF66B1C6FF5EABBEFF578AACFF6472
      AAFF5475A3FF547A87CF08080809000000000000000000000000989899DFE8D1
      B9FFBDA48BFFBAA188FFBAA188FFBAA188FFBAA188FFBAA188FFBAA188FFBCA3
      8BFFE8D0B8FF9C9C9CE300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004044456956ADBCFF63B5
      D0FF5CA9BEFF6AABBEFF72ACBEFF65AABEFF61ADC3FF6BB5C9FF6BA6BCFF6484
      B2FF6B85C0FF495460AC000000000000000000000000000000009B9B9BDFEAD2
      BBFFD1B89FFFCFB69DFFCFB69DFFCFB69DFFCFB69DFFCFB69DFFCFB69DFFE5E0
      DBFFE4E4E5FF9F9FA0E300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001A1A1A1E4D8484DD6AC2D5FF74C2
      D9FF70B4C6FF7BB5C7FF73ACBEFF63A6BAFF62A5B9FF67A5B8FF6BAABCFF578E
      B0FF718FC8FF576691E01E1E1E230000000000000000000000009C9C9CDFEBD3
      BCFFD2B9A0FFD0B79EFFD0B79EFFD0B79EFFD0B79EFFD0B79EFFD0B79EFFE7E2
      DEFFE7E7E8FFA1A1A1E300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003D40405B5DBCC0FF63B7CDFF78C0
      D5FF89C0D2FF90C2D3FF89BFD1FF76B7CAFF80B7CAFF7AB1C2FF63A5B7FF5BA3
      B7FF5A8DB8FF7291D1FF4C515FA50505050600000000000000009E9E9FDFECD5
      BDFFBDA48BFFB9A087FFB9A087FFB9A087FFB9A087FFB9A087FFB9A087FFE9D0
      B7FFECE9E7FFA3A3A4E300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000909090A474F507961B7D0FF72BA
      CFFF8ABFCFFF91C4D4FF88C2D3FF8CC0D1FF8FBECFFF93C1D1FF88BED0FF73C2
      D8FF547E8ED358637AC36A87BFFF38383A500000000000000000A0A0A0DFEDD5
      BEFFE9CFB7FFE8CFB6FFE8CFB6FFE8CFB6FFE8CFB6FFE8CFB6FFE8CFB6FFEDD3
      BBFFEDE7E0FFA4A4A4E300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003D40415B5FBAD5FF65B3
      C7FF83BACCFF8DC1D2FF8AC2D4FF8DC0D1FF95C4D4FF95C6D6FF98C9DAFF8AD3
      EBFF4B5558800F0F0F11576275B9474A4E750000000000000000A2A2A2DFEED7
      BFFFC4AA91FFC0A78EFFC0A78EFFC0A78EFFC0A78EFFC0A78EFFC0A78EFFC3AA
      91FFEED6BEFFA6A6A7E300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004F636AA37CD8F3FF7BC6
      DBFF73B7CAFF81BBCDFF88C0D1FF8ABDCEFF84BACBFF80BECFFF8DCADDFF87CF
      E5FE3334354400000000050505060E0E0E0F0000000000000000A2A3A3DFF0DF
      CDFFF0DECBFFF0DECBFFF0DECBFFF0DECBFFF0DECBFFF0DECBFFF0DECBFFF0DE
      CBFFF0DECDFFA7A7A7E300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000044494B695B7E89BF74A5
      B4E190CDE0FF8CCEE1FF8ACDE0FF9DD2E3FF98CBDCFF83C3D5FF7BD0E6FF5F9B
      ACE3131313150000000000000000000000000000000000000000A4A4A4DFF8F8
      F8FFF8F8F8FFF8F8F8FFF8F8F8FFF8F8F8FFF8F8F8FFF8F8F8FFF8F8F8FFF8F8
      F8FFF8F8F8FFA9A9AAE300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001515
      15182D2D2D38474B4C68637175A4749199CB86B2BFEC8DCEE2FF80D2EBFF536C
      75AE000000000000000000000000000000000000000000000000A5A5A6DFF9F9
      FAFFF9F9FAFFF9F9FAFFF9F9FAFFF9F9FAFFF9F9FAFFF9F9FAFFF9F9FAFFF9F9
      FAFFF9F9FAFFAAAAABE300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000141515173334354454676EA23A3C
      3D51000000000000000000000000000000000000000000000000141414162222
      2228222222282222222822222228222222282222222822222228222222282222
      2228222222281414141600000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00F89FC00300000000E01FC00300000000
      E003C00300000000E001C00300000000C001C00300000000C001C00300000000
      8001C003000000008003C003000000000001C003000000000000C00300000000
      0000C003000000008000C003000000008004C003000000008007C00300000000
      E00FC00300000000FF0FC0030000000000000000000000000000000000000000
      000000000000}
  end
end
