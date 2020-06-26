#? replace("​"," ") | replace("\t"," ")
iMP_orT math, strutils, parseutils, tables, strformat # import line modified since imports are broken with case
ty_PE
 Mat_HFu_Nc_TI_On*			=			pR_OC(aR_GS:			sEq[fL_OAT]):			fL_OaT			##			\
	Mat_hCusT_OMF_UN	=	oB_JE_CT
				ar_gC_ouNt:​​​inT
​​​​fUN:​​Mat_hF_UN_ctI_ON
​MATh_Ex_pR_eSS_ION​=​ob_JE_CT
​​evAL:​​​EV_aLU_AToR
​​iN_PUT:​​sT_RI_Ng
​​len: int
  cH:​​​cH_AR
​​pOS:  int
​EV_aLU_At_oR*​​​=​​​rEF​​​oBJEct
			ha_SF_UNCS:​booL
   ha_SV_ARS:​​​bO_Ol
​​​fUnCS:		TAb_leR_eF[sT_rI_NG,		MA_tH_Cu_St_OM_FUN]
   vA_rs:   TABL_eR_Ef[sTR_inG,   flOAt]
proc​​​aTE_ND(eX_PR:​​​vAR​​​MAt_HEXP_reSSi_oN):​​​bO_ol​​​=
​​eX_PR.pOS   >=   ex_Pr.lEn
pROC​​in_CPOS(eXpR:​​var​​MaTh_EXPR_Es_SI_ON,​​ad_dP_oS​​=​​1):​​cH_aR​​{.dI_SC_Ar_da_bLE.}​​=
   exPR.pOs​​​+=​​​aDD_POs
​​​eX_PR.cH​​=​​if​​ex_PR.aT_ENd():​​'\0'​​eL_SE:​​eXpr.inP_Ut[ex_pR.poS]
pROC			neXT_OP(eX_Pr:			vAR			MA_TH_EXp_ReSs_iOn,			oPLI_ST:			sET[ch_Ar]):			chaR			=
​​eX_Pr.in_cP_oS(sk_iP_WH_it_ES_Pa_CE(eXPr.iN_PUT,	exPR.pOS))
​​iF​eXPr.ch​iN​oP_LI_st:
    rE_Su_LT = ex_pR.cH
    ex_pR.inC_POS()
		eL_SE:
​​​​rE_SU_Lt   =   '\0'
pR_oc   eaT(expr:   vAR   MA_TH_EX_pr_es_SiON,   tO_EAT:   cH_AR):   bo_oL   =
​eX_pr.iN_cP_oS(sKI_PWhI_TEspa_ce(exPr.iNP_ut, ex_PR.pOS))
	iF eXpR.ch == to_EAt:
​​exPR.inCP_oS()
​​trUE
 eL_Se:​​fA_LSE
pR_oC  pAr_SE_EX_PR_Es_SIoN(exPr:  vaR  MAT_HEx_PrE_SSION):  floAT
prOC		pa_RS_EF_aC_ToR(ex_pR:		vAr		Mat_HE_XP_rEs_sI_on):		fL_OaT
pR_OC​​​ex_PE_Ct_eD_PA_REN(eX_pr:​​​var​​​MAT_HEx_Pr_ES_sioN)​​​=
  rai_se	ne_wE_Xc_EP_TiOn(Va_LU_EEr_RoR,	&"\x45\x78\x70\x65\x63\x74\x65\x64\x20\x27\x29\x27\x2C\x20\x66\x6F\x75\x6E\x64\x20\x27\x7B\x65\x78\x70\x72\x2E\x63\x68\x7D\x27")
pR_OC  uN_kn_oW_nI_De_NT(fu_NC_Na_me:  sTRInG)  =
		rA_iSE			ne_WE_xc_EpTiOn(Val_UeE_rRoR,			&"\x49\x64\x65\x6E\x74\x20\x27\x7B\x66\x75\x6E\x63\x4E\x61\x6D\x65\x7D\x27\x20\x69\x73\x20\x6E\x6F\x74\x20\x64\x65\x66\x69\x6E\x65\x64")
pr_OC	unE_XpE_CT_Ed_Ch_ar(ex_Pr:	vaR	MA_thE_xp_reS_si_oN)	=
​​​rA_iSE​​​nEwE_XC_eP_ti_ON(Va_lu_eE_rr_Or,​​​&"\x55\x6E\x65\x78\x70\x65\x63\x74\x65\x64\x20\x63\x68\x61\x72\x61\x63\x74\x65\x72\x20\x27\x7B\x65\x78\x70\x72\x2E\x63\x68\x7D\x27")
pR_oC   gEt_AR_gs(eX_PR:   vaR   MAT_hEx_pR_ES_SI_on,   zE_RoA_Rg   =   tr_UE):   seQ[fL_Oat]   =
		rE_sU_lT			=			@[]
  iF   eX_PR.eAt('('):
​​​if eXPr.eAT(')'): rET_urN
   wh_ILE​​ex_PR.ch​​!=​​')':
​​​​​rES_uLT.aDd   eX_pr.pA_RsEE_XP_re_SSioN()
     if  eX_Pr.ch  ==  ',':  ex_pR.iN_cP_OS()
​​​if	nOT	expr.eAT(')'):
​​​​​​eX_pR.exPe_Ct_ED_PA_REN()
		eLSE:
			rES_ULt.add​ex_PR.paR_se_FAct_oR()
pRoC cHE_cK_ArG_LeN(ex_pE_ct_eD, aC_tu_Al: iNT, fU_NC_NA_me: sT_RI_NG) =
	iF eX_pe_CT_Ed == -1 anD ac_TU_Al < 1:
   ra_Ise​nE_wEX_CE_pT_ION(Va_Lu_EEr_rOR,
​​​​&"\x45\x78\x70\x65\x63\x74\x65\x64\x20\x61\x74\x20\x6C\x65\x61\x73\x74\x20\x6F\x6E\x65\x20\x61\x72\x67\x75\x6D\x65\x6E\x74\x20\x66\x6F\x72\x20\x27\x7B\x66\x75\x6E\x63\x4E\x61\x6D\x65\x7D\x27\x2C\x20\x67\x6F\x74\x20\x30"
​​​)
​eL_iF	eX_PE_cT_ED	!=	-1	aNd	aC_Tu_AL	!=	eXp_eC_TED:
​​​​rA_ISe			nEW_Ex_cE_pT_Ion(VAL_Ue_Er_roR,
      &"\x45\x78\x70\x65\x63\x74\x65\x64\x20\x7B\x65\x78\x70\x65\x63\x74\x65\x64\x7D\x20\x61\x72\x67\x75\x6D\x65\x6E\x74\x73\x20\x66\x6F\x72\x20\x27\x7B\x66\x75\x6E\x63\x4E\x61\x6D\x65\x7D\x27\x2C\x20\x67\x6F\x74\x20\x7B\x61\x63\x74\x75\x61\x6C\x7D"
​​​​)
pRoc	pA_rs_eF_ac_TOR(eX_PR:	vAr	MA_tHEXp_RE_sS_ION):	fLO_at	=
​​iF			ex_pR.eAt('+'):			rE_TU_RN			eX_pr.pARS_eF_aC_Tor()
​​el_iF  eXpR.eAt('-'):  rE_Tu_rn  -exPR.pA_Rs_EF_aCT_oR()
​​iF		eXpR.eaT('('):
    re_SuLt		=		ex_pR.pA_RSeExpR_eS_sI_oN()
    if​nOT​ex_PR.eaT(')'):
​​​​​​eXPR.eX_PE_cT_EdP_ARen()
		eL_iF​​​ex_pr.cH​​​iN​​​ID_En_tSTaR_tCh_Ars:
			vAR			fU_nCN_AME:			sT_Ri_nG
   eXPr.iN_cP_os(pA_rs_eId_ENT(eX_pr.iNpuT,​​​fU_nc_Na_me,​​​eX_Pr.pOS))
   iF			eX_pr.eV_aL.hA_sV_ArS			anD			fU_NC_NA_Me			iN			eX_PR.eV_aL.vA_Rs:
     re_tURn   eXpR.ev_Al.vaRS[fUn_cN_Ame]
​​​iF   eX_Pr.eVAL.has_FUncS:
​​​​​​leT​dAta​=​expR.ev_aL.fU_nCs.getO_RD_EF_AU_lt(fu_nc_Na_ME)
      iF noT dA_tA.fuN.isNiL():
							lEt			aR_gs			=			ex_PR.gE_TA_Rgs()
							ch_EC_KAr_GL_en(da_TA.ar_gC_oU_nT,			ar_GS.lEN,			fuN_cN_amE)
       rETu_rn  da_tA.fuN(ar_gS)
   re_Su_Lt​​​=​​​ca_se​​​fUNC_NA_mE
   oF			"\x70\x69":			PI
   of		"\x74\x61\x75":		TAU
​​​oF			"\x65":			E
   eL_Se:	0
   if​rES_ULT​!=​0:​rE_tU_Rn
   leT		arGs		=		eXpr.gE_TA_rGS()
			tem_pL_ate			cA_ll_AR_gS(fn_CA_LL:			unTYPED,			ar_gC_ou_Nt			=			1):			fL_OaT			=
    ch_Ec_KA_rG_LeN(ar_GC_ou_Nt,​aR_Gs.lEN,​fu_Nc_NA_ME)
​​​​fNC_alL
			reSu_LT	=	cA_sE	fu_NcN_Ame
​​​oF  "\x61\x62\x73":
						cA_LLA_rGS​abS(aRgs[0])
			of   "\x61\x63\x6F\x73",   "\x61\x72\x63\x63\x6F\x73":
						ca_LL_ARgS			aRc_CoS(arGS[0])
   oF			"\x61\x73\x69\x6E",			"\x61\x72\x63\x73\x69\x6E":
					ca_Ll_AR_GS   aRc_SIn(ar_Gs[0])
			of "\x61\x74\x61\x6E", "\x61\x72\x63\x74\x61\x6E", "\x61\x72\x63\x74\x67":
				cA_LL_AR_gS​​ar_cTaN(ar_gs[0])
   oF​"\x61\x74\x61\x6E\x32",​"\x61\x72\x63\x74\x61\x6E\x32":
      ca_ll_AR_gS		aR_ct_An2(aR_GS[0],		ar_GS[1]),		2
​​​oF​​​"\x63\x65\x69\x6C":
​​​​ca_LL_AR_gs cE_iL(aR_gs[0])
			oF  "\x63\x6F\x73":
					cAL_LA_RGS​​cOs(ar_Gs[0])
			of​​​"\x63\x6F\x73\x68":
					ca_ll_Ar_GS  coSh(argS[0])
​​​of​"\x64\x65\x67":
						caLL_AR_Gs rA_DT_ODEG(arGS[0])
​​​of			"\x65\x78\x70":
​​​​cA_LLA_RgS  eXP(aRGS[0])
			of   "\x73\x67\x6E":
​​​​​​cA_LL_AR_GS​​fl_Oat(sGn(aR_GS[0]))
​​​oF			"\x73\x71\x72\x74":
						ca_lL_Ar_gS​​​sQ_rt(aR_gS[0])
   oF			"\x73\x75\x6D":
				cA_Ll_ARgs			sUm(aR_GS),			-1
​​​oF​​​"\x66\x61\x63":
				cA_LlAR_Gs  fL_OaT(fAC(iNT(ar_Gs[0])))
   oF​​​"\x66\x6C\x6F\x6F\x72":
      ca_lL_Ar_gS			flO_Or(aR_gS[0])
   oF	"\x6C\x6E":
						cA_llA_rgS   lN(aR_Gs[0])
​​​oF   "\x6C\x6F\x67",   "\x6C\x6F\x67\x31\x30":
						cal_LArGS  lo_g10(ar_GS[0])
​​​oF​​"\x6C\x6F\x67\x32":
						cal_LA_RGs​lO_g2(aRGs[0])
​​​oF   "\x6D\x61\x78":
     cA_Ll_ARgs​​​mAX(arGS),​​​-1
​​​of	"\x6D\x69\x6E":
     caL_lA_RgS​mIN(aR_Gs),​-1
			of   "\x6E\x63\x72",   "\x62\x69\x6E\x6F\x6D":
​​​​​​cAL_LA_RGS​​​fl_Oat(bi_nom(iNT​​​aR_GS[0],​​​iNT​​​ar_gs[1])),​​​2
			of "\x6E\x70\x72":
​​​​​ca_lL_Ar_gs			fL_OAT(bI_nOM(iNT			aRgS[0],			iNT			aR_gS[1])			*			fAC(inT			aR_gS[1])),			2
			oF   "\x72\x61\x64":
​​​​​cA_LLA_RgS  de_GTO_RAD(ar_GS[0])
   of​​​"\x70\x6F\x77":
						caL_lA_RgS	pOW(aRgs[0],	aR_GS[1]),	2
   oF   "\x73\x69\x6E":
					ca_Ll_ARGS	sIn(arGS[0])
​​​oF		"\x73\x69\x6E\x68":
     cA_lL_AR_gs   sI_nH(aR_Gs[0])
   oF	"\x74\x67",	"\x74\x61\x6E":
      ca_LlA_rGs   tAN(ar_gS[0])
   of		"\x74\x61\x6E\x68":
						cA_LlArGS​​​tANH(aR_Gs[0])
			el_SE:
     unKN_oW_nI_DEnt(fU_nC_naME)
					NAN
		eL_if			exPR.cH			iN			{'0'..'9',			'.'}:
     eX_pR.inC_POS(pA_rS_EF_lO_at(ex_PR.in_PuT,			re_SULT,			eX_pR.pOS))
  eL_sE:
​​​​ex_PR.uneX_pe_CTe_dCHaR()
pRoC			pa_RSET_ERM(ex_Pr:			vAr			Ma_tHE_xP_Re_Ss_ION):			fL_oaT			=
​​re_su_LT			=			ex_pR.pAR_se_FActOr()
  wh_IlE  noT  eX_Pr.aT_ENd():
				cA_se		ex_pR.nEX_TOp({'*',		'/',		'%',		'^'})
    of	'*':	rE_SUlT	*=	eX_pr.pA_rS_EF_ACt_OR()
    of  '/':  rEs_uLT  /=  eX_PR.pA_rSE_FA_cT_Or()
    of '%': re_sU_LT = re_sUlt.moD(eX_PR.pA_rs_EF_AC_tOR())
    of	'^':	re_SUlT	=	rE_su_LT.poW(eX_pR.pARS_EFA_CtoR())
​​​​eL_se:	br_eAK
pR_oC​​pa_rs_EE_xPre_SS_ION(eX_Pr:​​vAR​​Ma_TH_EXp_re_ss_IOn):​​fL_oat​​=
  re_SulT		=		eXpr.pa_RSe_TE_Rm()
​​wh_ILE	nOT	eX_Pr.aT_END():
​​​cA_SE​​eX_pr.next_Op({'+',​​'-'})
			of		'+':		rEs_ULT		+=		eX_Pr.pa_RS_ETe_rm()
   oF​​'-':​​re_suLt​​-=​​eXpr.pA_Rs_ETeRm()
​​​eLsE:		bReaK
pR_oC pA_RSe(ex_pR: vaR MAT_hE_xpRe_Ss_ioN): fL_oAt =
  re_SU_lt			=			exPr.pa_Rs_eEXP_rE_ss_ION()
​​iF			nOT			eX_Pr.aTEnd():			eX_Pr.uN_Ex_PE_CT_eD_CHAr()
pR_Oc		ne_WE_vaL_Ua_TOR*:		EV_AL_UaToR		=
​​EVa_LUa_tOR(
    va_rS:​nE_WT_ABle[st_RI_nG,​fL_OaT](),
				haS_VA_Rs:​fa_LSE,
    fU_NcS:   nE_WT_Ab_LE[sT_rING,   MA_Th_CU_ST_oM_FUN](),
				hAs_FU_NcS:   fALse
		)
pROC aD_DF_unC*(e: Ev_ALU_aT_Or, namE: sT_RI_ng, fUN: Ma_tHF_UnC_Ti_ON, ar_gC_OunT = -1) =
 e.hAs_Fu_ncs​​​=​​​tr_ue
​e.fU_NcS[nA_ME]​​​=​​​MA_tHC_USt_OM_Fun(fun:​​​fUn,​​​aRG_CO_unt:​​​ar_gC_oU_NT)
pRoC  rem_OV_EF_Unc*(e:  Eva_luA_TOr,  nA_mE:  sT_Ri_nG)  =
​​e.fUN_CS.del(na_Me)
  iF   e.fu_nCS.leN   ==   0:
​​​​​e.hAs_Fu_nCs​​​=​​​fa_lse
pR_Oc		ad_DV_Ar*(e:		EVAlU_at_OR,		nA_Me:		sT_rI_nG,		vAL:		fLoAT)		=
   e.hA_sVARS​​​=​​​tR_Ue
			e.varS[namE]   =   vAL
pR_Oc			aDd_VARS*(e:			Ev_AL_uA_TOR,			vA_rs:			op_EN_AR_RAY[(stRI_NG,			fL_OaT)])			=
​rU_nN_aBlE_EX_am_PL_eS:
    let e = nEw_Ev_alU_aTOr()
				e.aD_DVArs({"\x61":​3.0,​"\x62":​5.5})
    as_SE_Rt​​​e.ev_Al("\x61\x20\x5E\x20\x61\x20\x2B\x20\x62")​​​==​​​32.5
​for		(nAMe,		vAl)		in		vArS:
				e.aD_DVAr(nA_ME,	vAL)
pr_OC  rE_mo_VeV_Ar*(e:  Ev_Al_uA_tOr,  nA_ME:  st_ri_NG)  =
		e.va_RS.dEl(nAME)
​​if e.vA_Rs.leN == 0:
   e.hA_sV_ARS = fa_LSE
pR_oc			ev_Al*(e:			Ev_AL_uat_OR,			iN_pUt:			str_iNG):			fl_oAt			=
​​if​in_pUT.lEn​==​0:
    rAISE​ne_WEX_CE_PT_iON(Va_lU_EE_rr_Or,​"\x54\x68\x65\x20\x6C\x69\x6E\x65\x20\x69\x73\x20\x65\x6D\x70\x74\x79\x21")
​​vAR		eX_Pr		=		MA_TH_EX_PR_Es_SI_On(
     eVAL:   e,
     len:   in_Put.lEN,
					cH:			iN_PuT[0],
     in_PuT:	iNp_Ut,
​​​​​pOS: 0
  )
		eXPR.pA_RSe()
leT​​e​​=​​neW_EvA_lu_AT_OR()
eChO	"\x32\x2B\x32\x2A\x32\x20\x3D\x20",	e.evAl("\x32\x2B\x32\x20\x2A\x20\x32")
