class /EY1/CL_SAV_EFFECTIVE__MPC definition
  public
  inheriting from /IWBEP/CL_MGW_PUSH_ABS_MODEL
  create public .

public section.

  interfaces IF_SADL_GW_MODEL_EXPOSURE_DATA .

  types:
   begin of ts_text_element,
      artifact_name  type c length 40,       " technical name
      artifact_type  type c length 4,
      parent_artifact_name type c length 40, " technical name
      parent_artifact_type type c length 4,
      text_symbol    type textpoolky,
   end of ts_text_element .
  types:
  begin of TS_GLOBALPARAMETER01,
     CONSOLIDATIONUNIT type C length 18,
     FISCALYEAR type C length 4,
     CONSOLIDATIONCHARTOFACCOUNTS type C length 2,
     CONSOLIDATIONGROUP type C length 18,
     INTENTION type C length 30,
     PERIODFROM type C length 3,
     PERIODTO type C length 3,
     LOCALCURRENCY type C length 5,
     LOCALCURRENCYTYPE type C length 5,
     GROUPCURRENCY type C length 5,
     GROUPCURRENCYTYPE type C length 5,
  end of TS_GLOBALPARAMETER01 .
  types:
         tt_text_elements type standard table of ts_text_element with key text_symbol .
  types:
TT_GLOBALPARAMETER type standard table of TS_GLOBALPARAMETER01 .
  types:
    begin of TS_XEY1XSAV_C_CNSLDTNJRNLENTRY.
      include type /EY1/SAV_C_CNSLDTNJRNLENTRY.
  types:
      generated_id type string,
      P_CONSOLIDATIONUNITHIERARCHY type FINCS_HRYID,
      P_CONSOLIDATIONPRFTCTRHIER type FINCS_HRYID,
      P_CONSOLIDATIONSEGMENTHIER type FINCS_HRYID,
      P_KEYDATE type SYDATE,
      T_CONSOLIDATIONUNITFORELIM type I_CNSLDTNUNITFORELIMINATIONT-CONSOLIDATIONUNITMDMTEXT,
      T_CONSOLIDATIONPRFTCTRFORELIM type I_CNSLDTNPROFITCENTERFORELIMT-ADDITIONALMASTERDATATEXT,
      T_CONSOLIDATIONSEGMENTFORELIM type I_CNSLDTNSEGMENTFORELIMT-ADDITIONALMASTERDATATEXT,
    end of TS_XEY1XSAV_C_CNSLDTNJRNLENTRY .
  types:
   TT_XEY1XSAV_C_CNSLDTNJRNLENTRY type standard table of TS_XEY1XSAV_C_CNSLDTNJRNLENTRY .
  types:
    begin of TS_XEY1XSAV_C_CNSLDTNJRNLENTR.
      include type /EY1/SAV_C_CNSLDTNJRNLENTRY.
  types:
      generated_id type string,
      P_CONSOLIDATIONUNITHIERARCHY type FINCS_HRYID,
      P_CONSOLIDATIONPRFTCTRHIER type FINCS_HRYID,
      P_CONSOLIDATIONSEGMENTHIER type FINCS_HRYID,
      P_KEYDATE type SYDATE,
      T_CONSOLIDATIONUNITFORELIM type I_CNSLDTNUNITFORELIMINATIONT-CONSOLIDATIONUNITMDMTEXT,
      T_CONSOLIDATIONPRFTCTRFORELIM type I_CNSLDTNPROFITCENTERFORELIMT-ADDITIONALMASTERDATATEXT,
      T_CONSOLIDATIONSEGMENTFORELIM type I_CNSLDTNSEGMENTFORELIMT-ADDITIONALMASTERDATATEXT,
    end of TS_XEY1XSAV_C_CNSLDTNJRNLENTR .
  types:
   TT_XEY1XSAV_C_CNSLDTNJRNLENTR type standard table of TS_XEY1XSAV_C_CNSLDTNJRNLENTR .
  types:
   TS_XEY1XSAV_C_CURRLOCALGROUPVH type /EY1/SAV_C_CURRLOCALGROUPVH .
  types:
   TT_XEY1XSAV_C_CURRLOCALGROUPVH type standard table of TS_XEY1XSAV_C_CURRLOCALGROUPVH .
  types:
    begin of TS_XEY1XSAV_C_ETR_BDTPD_BDNDTO.
      include type /EY1/SAV_C_ETR_BDTPD_BDNDTOTAL.
  types:
      P_FROMPERIOD type POPER,
      P_TOPERIOD type POPER,
      P_RYEAR type GJAHR,
      P_SWITCH type CHAR1,
      P_TAXINTENTION type ZZ1_TAXINTENTION,
      P_RBUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_ETR_BDTPD_BDNDTO .
  types:
   TT_XEY1XSAV_C_ETR_BDTPD_BDNDTO type standard table of TS_XEY1XSAV_C_ETR_BDTPD_BDNDTO .
  types:
    begin of TS_XEY1XSAV_C_ETR_BDTPD_BDNDT.
      include type /EY1/SAV_C_ETR_BDTPD_BDNDTOTAL.
  types:
      P_FROMPERIOD type POPER,
      P_TOPERIOD type POPER,
      P_RYEAR type GJAHR,
      P_SWITCH type CHAR1,
      P_TAXINTENTION type ZZ1_TAXINTENTION,
      P_RBUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_ETR_BDTPD_BDNDT .
  types:
   TT_XEY1XSAV_C_ETR_BDTPD_BDNDT type standard table of TS_XEY1XSAV_C_ETR_BDTPD_BDNDT .
  types:
    begin of TS_XEY1XSAV_C_ETR_BDTPD_BDNDTP.
      include type /EY1/SAV_C_ETR_BDTPD_BDNDTPD.
  types:
      P_FROMPERIOD type POPER,
      P_TOPERIOD type POPER,
      P_RYEAR type GJAHR,
      P_SWITCH type CHAR1,
      P_TAXINTENTION type ZZ1_TAXINTENTION,
      P_RBUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_ETR_BDTPD_BDNDTP .
  types:
   TT_XEY1XSAV_C_ETR_BDTPD_BDNDTP type standard table of TS_XEY1XSAV_C_ETR_BDTPD_BDNDTP .
  types:
    begin of TS_XEY1XSAV_C_ETR_BDTPD_BDND.
      include type /EY1/SAV_C_ETR_BDTPD_BDNDTPD.
  types:
      P_FROMPERIOD type POPER,
      P_TOPERIOD type POPER,
      P_RYEAR type GJAHR,
      P_SWITCH type CHAR1,
      P_TAXINTENTION type ZZ1_TAXINTENTION,
      P_RBUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_ETR_BDTPD_BDND .
  types:
   TT_XEY1XSAV_C_ETR_BDTPD_BDND type standard table of TS_XEY1XSAV_C_ETR_BDTPD_BDND .
  types:
    begin of TS_XEY1XSAV_C_ETR_CTRTDCBPARAM.
      include type /EY1/SAV_C_ETR_CTRTDCB.
  types:
      P_FROMPERIOD type POPER,
      P_TOPERIOD type POPER,
      P_RYEAR type GJAHR,
      P_SWITCH type CHAR1,
      P_TAXINTENTION type ZZ1_TAXINTENTION,
      P_RBUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_ETR_CTRTDCBPARAM .
  types:
   TT_XEY1XSAV_C_ETR_CTRTDCBPARAM type standard table of TS_XEY1XSAV_C_ETR_CTRTDCBPARAM .
  types:
    begin of TS_XEY1XSAV_C_ETR_CTRTDCBTYPE.
      include type /EY1/SAV_C_ETR_CTRTDCB.
  types:
      P_FROMPERIOD type POPER,
      P_TOPERIOD type POPER,
      P_RYEAR type GJAHR,
      P_SWITCH type CHAR1,
      P_TAXINTENTION type ZZ1_TAXINTENTION,
      P_RBUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_ETR_CTRTDCBTYPE .
  types:
   TT_XEY1XSAV_C_ETR_CTRTDCBTYPE type standard table of TS_XEY1XSAV_C_ETR_CTRTDCBTYPE .
  types:
    begin of TS_XEY1XSAV_C_ETR_CTRTDCBTOTAL.
      include type /EY1/SAV_C_ETR_CTRTDCBTOTAL.
  types:
      P_FROMPERIOD type POPER,
      P_TOPERIOD type POPER,
      P_RYEAR type GJAHR,
      P_SWITCH type CHAR1,
      P_TAXINTENTION type ZZ1_TAXINTENTION,
      P_RBUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_ETR_CTRTDCBTOTAL .
  types:
   TT_XEY1XSAV_C_ETR_CTRTDCBTOTAL type standard table of TS_XEY1XSAV_C_ETR_CTRTDCBTOTAL .
  types:
    begin of TS_XEY1XSAV_C_ETR_CTRTDCBTOTA.
      include type /EY1/SAV_C_ETR_CTRTDCBTOTAL.
  types:
      P_FROMPERIOD type POPER,
      P_TOPERIOD type POPER,
      P_RYEAR type GJAHR,
      P_SWITCH type CHAR1,
      P_TAXINTENTION type ZZ1_TAXINTENTION,
      P_RBUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_ETR_CTRTDCBTOTA .
  types:
   TT_XEY1XSAV_C_ETR_CTRTDCBTOTA type standard table of TS_XEY1XSAV_C_ETR_CTRTDCBTOTA .
  types:
    begin of TS_XEY1XSAV_C_ETR_PTA_MVMNTPAR.
      include type /EY1/SAV_C_ETR_PTA_MVMNT.
  types:
      P_FROMPERIOD type POPER,
      P_TOPERIOD type POPER,
      P_RYEAR type GJAHR,
      P_SWITCH type CHAR1,
      P_TAXINTENTION type ZZ1_TAXINTENTION,
      P_RBUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_ETR_PTA_MVMNTPAR .
  types:
   TT_XEY1XSAV_C_ETR_PTA_MVMNTPAR type standard table of TS_XEY1XSAV_C_ETR_PTA_MVMNTPAR .
  types:
    begin of TS_XEY1XSAV_C_ETR_PTA_MVMNTTYP.
      include type /EY1/SAV_C_ETR_PTA_MVMNT.
  types:
      P_FROMPERIOD type POPER,
      P_TOPERIOD type POPER,
      P_RYEAR type GJAHR,
      P_SWITCH type CHAR1,
      P_TAXINTENTION type ZZ1_TAXINTENTION,
      P_RBUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_ETR_PTA_MVMNTTYP .
  types:
   TT_XEY1XSAV_C_ETR_PTA_MVMNTTYP type standard table of TS_XEY1XSAV_C_ETR_PTA_MVMNTTYP .
  types:
    begin of TS_XEY1XSAV_C_ETR_PTA_TOTALPAR.
      include type /EY1/SAV_C_ETR_PTA_TOTAL.
  types:
      P_FROMPERIOD type POPER,
      P_TOPERIOD type POPER,
      P_RYEAR type GJAHR,
      P_SWITCH type CHAR1,
      P_TAXINTENTION type ZZ1_TAXINTENTION,
      P_RBUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_ETR_PTA_TOTALPAR .
  types:
   TT_XEY1XSAV_C_ETR_PTA_TOTALPAR type standard table of TS_XEY1XSAV_C_ETR_PTA_TOTALPAR .
  types:
    begin of TS_XEY1XSAV_C_ETR_PTA_TOTALTYP.
      include type /EY1/SAV_C_ETR_PTA_TOTAL.
  types:
      P_FROMPERIOD type POPER,
      P_TOPERIOD type POPER,
      P_RYEAR type GJAHR,
      P_SWITCH type CHAR1,
      P_TAXINTENTION type ZZ1_TAXINTENTION,
      P_RBUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_ETR_PTA_TOTALTYP .
  types:
   TT_XEY1XSAV_C_ETR_PTA_TOTALTYP type standard table of TS_XEY1XSAV_C_ETR_PTA_TOTALTYP .
  types:
    begin of TS_XEY1XSAV_C_ETR_SUM_DDCTRTDP.
      include type /EY1/SAV_C_ETR_SUM_DDCTRTD.
  types:
      P_FROMPERIOD type POPER,
      P_TOPERIOD type POPER,
      P_RYEAR type GJAHR,
      P_SWITCH type CHAR1,
      P_TAXINTENTION type ZZ1_TAXINTENTION,
      P_RBUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_ETR_SUM_DDCTRTDP .
  types:
   TT_XEY1XSAV_C_ETR_SUM_DDCTRTDP type standard table of TS_XEY1XSAV_C_ETR_SUM_DDCTRTDP .
  types:
    begin of TS_XEY1XSAV_C_ETR_SUM_DDCTRTDT.
      include type /EY1/SAV_C_ETR_SUM_DDCTRTD.
  types:
      P_FROMPERIOD type POPER,
      P_TOPERIOD type POPER,
      P_RYEAR type GJAHR,
      P_SWITCH type CHAR1,
      P_TAXINTENTION type ZZ1_TAXINTENTION,
      P_RBUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_ETR_SUM_DDCTRTDT .
  types:
   TT_XEY1XSAV_C_ETR_SUM_DDCTRTDT type standard table of TS_XEY1XSAV_C_ETR_SUM_DDCTRTDT .
  types:
    begin of TS_XEY1XSAV_C_ETR_SUM_DDCTRTOT.
      include type /EY1/SAV_C_ETR_SUM_DDCTRTOTAL.
  types:
      P_FROMPERIOD type POPER,
      P_TOPERIOD type POPER,
      P_RYEAR type GJAHR,
      P_SWITCH type CHAR1,
      P_TAXINTENTION type ZZ1_TAXINTENTION,
      P_RBUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_ETR_SUM_DDCTRTOT .
  types:
   TT_XEY1XSAV_C_ETR_SUM_DDCTRTOT type standard table of TS_XEY1XSAV_C_ETR_SUM_DDCTRTOT .
  types:
    begin of TS_XEY1XSAV_C_ETR_SUM_DDCTRTO.
      include type /EY1/SAV_C_ETR_SUM_DDCTRTOTAL.
  types:
      P_FROMPERIOD type POPER,
      P_TOPERIOD type POPER,
      P_RYEAR type GJAHR,
      P_SWITCH type CHAR1,
      P_TAXINTENTION type ZZ1_TAXINTENTION,
      P_RBUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_ETR_SUM_DDCTRTO .
  types:
   TT_XEY1XSAV_C_ETR_SUM_DDCTRTO type standard table of TS_XEY1XSAV_C_ETR_SUM_DDCTRTO .
  types:
    begin of TS_XEY1XSAV_C_ETR_SUM_ITDCTRPA.
      include type /EY1/SAV_C_ETR_SUM_ITDCTR.
  types:
      P_RBUNIT type FC_BUNIT,
      P_RYEAR type GJAHR,
      P_FROMPERIOD type POPER,
      P_TOPERIOD type POPER,
      P_SWITCH type CHAR1,
      P_TAXINTENTION type ZZ1_TAXINTENTION,
      P_CURRTYPE type /EY1/SAV_CURRENCY_TYPE,
      P_INTENTION type /EY1/SAV_INTENT,
    end of TS_XEY1XSAV_C_ETR_SUM_ITDCTRPA .
  types:
   TT_XEY1XSAV_C_ETR_SUM_ITDCTRPA type standard table of TS_XEY1XSAV_C_ETR_SUM_ITDCTRPA .
  types:
    begin of TS_XEY1XSAV_C_ETR_SUM_ITDCTRTY.
      include type /EY1/SAV_C_ETR_SUM_ITDCTR.
  types:
      P_RBUNIT type FC_BUNIT,
      P_RYEAR type GJAHR,
      P_FROMPERIOD type POPER,
      P_TOPERIOD type POPER,
      P_SWITCH type CHAR1,
      P_TAXINTENTION type ZZ1_TAXINTENTION,
      P_CURRTYPE type /EY1/SAV_CURRENCY_TYPE,
      P_INTENTION type /EY1/SAV_INTENT,
    end of TS_XEY1XSAV_C_ETR_SUM_ITDCTRTY .
  types:
   TT_XEY1XSAV_C_ETR_SUM_ITDCTRTY type standard table of TS_XEY1XSAV_C_ETR_SUM_ITDCTRTY .
  types:
    begin of TS_XEY1XSAV_C_ETR_SUM_ITDCTRTO.
      include type /EY1/SAV_C_ETR_SUM_ITDCTRTOTAL.
  types:
      P_CNTRY type LAND1,
      P_RYEAR type GJAHR,
      P_INTENTION type /EY1/SAV_INTENT,
    end of TS_XEY1XSAV_C_ETR_SUM_ITDCTRTO .
  types:
   TT_XEY1XSAV_C_ETR_SUM_ITDCTRTO type standard table of TS_XEY1XSAV_C_ETR_SUM_ITDCTRTO .
  types:
    begin of TS_XEY1XSAV_C_ETR_SUM_ITDCTRT.
      include type /EY1/SAV_C_ETR_SUM_ITDCTRTOTAL.
  types:
      P_CNTRY type LAND1,
      P_RYEAR type GJAHR,
      P_INTENTION type /EY1/SAV_INTENT,
    end of TS_XEY1XSAV_C_ETR_SUM_ITDCTRT .
  types:
   TT_XEY1XSAV_C_ETR_SUM_ITDCTRT type standard table of TS_XEY1XSAV_C_ETR_SUM_ITDCTRT .
  types:
    begin of TS_XEY1XSAV_C_ETR_SUM_OVERVIEW.
      include type /EY1/SAV_C_ETR_SUM_OVERVIEW.
  types:
      P_CNTRY type LAND1,
      P_RYEAR type GJAHR,
      P_FROMPERIOD type POPER,
      P_TOPERIOD type POPER,
      P_INTENTION type /EY1/SAV_INTENT,
      P_SWITCH type CHAR1,
      P_TAXINTENTION type ZZ1_TAXINTENTION,
      P_RBUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_ETR_SUM_OVERVIEW .
  types:
   TT_XEY1XSAV_C_ETR_SUM_OVERVIEW type standard table of TS_XEY1XSAV_C_ETR_SUM_OVERVIEW .
  types:
    begin of TS_XEY1XSAV_C_ETR_SUM_OVERVIE.
      include type /EY1/SAV_C_ETR_SUM_OVERVIEW.
  types:
      P_CNTRY type LAND1,
      P_RYEAR type GJAHR,
      P_FROMPERIOD type POPER,
      P_TOPERIOD type POPER,
      P_INTENTION type /EY1/SAV_INTENT,
      P_SWITCH type CHAR1,
      P_TAXINTENTION type ZZ1_TAXINTENTION,
      P_RBUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_ETR_SUM_OVERVIE .
  types:
   TT_XEY1XSAV_C_ETR_SUM_OVERVIE type standard table of TS_XEY1XSAV_C_ETR_SUM_OVERVIE .
  types:
    begin of TS_XEY1XSAV_C_FETCH_TAX_RATESP.
      include type /EY1/SAV_C_FETCH_TAX_RATES.
  types:
      P_TOPERIOD type POPER,
      P_RYEAR type GJAHR,
    end of TS_XEY1XSAV_C_FETCH_TAX_RATESP .
  types:
   TT_XEY1XSAV_C_FETCH_TAX_RATESP type standard table of TS_XEY1XSAV_C_FETCH_TAX_RATESP .
  types:
    begin of TS_XEY1XSAV_C_FETCH_TAX_RATEST.
      include type /EY1/SAV_C_FETCH_TAX_RATES.
  types:
      P_TOPERIOD type POPER,
      P_RYEAR type GJAHR,
    end of TS_XEY1XSAV_C_FETCH_TAX_RATEST .
  types:
   TT_XEY1XSAV_C_FETCH_TAX_RATEST type standard table of TS_XEY1XSAV_C_FETCH_TAX_RATEST .
  types:
    begin of TS_XEY1XSAV_C_GET_TAX_RATEPARA.
      include type /EY1/SAV_C_GET_TAX_RATE.
  types:
      P_TOPERIOD type POPER,
      P_RYEAR type GJAHR,
      P_RBUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_GET_TAX_RATEPARA .
  types:
   TT_XEY1XSAV_C_GET_TAX_RATEPARA type standard table of TS_XEY1XSAV_C_GET_TAX_RATEPARA .
  types:
    begin of TS_XEY1XSAV_C_GET_TAX_RATETYPE.
      include type /EY1/SAV_C_GET_TAX_RATE.
  types:
      P_TOPERIOD type POPER,
      P_RYEAR type GJAHR,
      P_RBUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_GET_TAX_RATETYPE .
  types:
   TT_XEY1XSAV_C_GET_TAX_RATETYPE type standard table of TS_XEY1XSAV_C_GET_TAX_RATETYPE .
  types:
    begin of TS_XEY1XSAV_C_INTENTIONSSTATUS.
      include type /EY1/SAV_C_INTENTIONSSTATUS.
  types:
      P_BUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_INTENTIONSSTATUS .
  types:
   TT_XEY1XSAV_C_INTENTIONSSTATUS type standard table of TS_XEY1XSAV_C_INTENTIONSSTATUS .
  types:
    begin of TS_XEY1XSAV_C_INTENTIONSSTATU.
      include type /EY1/SAV_C_INTENTIONSSTATUS.
  types:
      P_BUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_INTENTIONSSTATU .
  types:
   TT_XEY1XSAV_C_INTENTIONSSTATU type standard table of TS_XEY1XSAV_C_INTENTIONSSTATU .
  types:
   TS_XEY1XSAV_C_READINTENTVHTYPE type /EY1/SAV_C_READINTENTVH .
  types:
   TT_XEY1XSAV_C_READINTENTVHTYPE type standard table of TS_XEY1XSAV_C_READINTENTVHTYPE .
  types:
   TS_XEY1XSAV_C_RECON_LEDGERTYPE type /EY1/SAV_C_RECON_LEDGER .
  types:
   TT_XEY1XSAV_C_RECON_LEDGERTYPE type standard table of TS_XEY1XSAV_C_RECON_LEDGERTYPE .
  types:
   TS_XEY1XSAV_C_TIERSTYPE type /EY1/SAV_C_TIERS .
  types:
   TT_XEY1XSAV_C_TIERSTYPE type standard table of TS_XEY1XSAV_C_TIERSTYPE .
  types:
    begin of TS_XEY1XSAV_I_ETR_BDTPD_BDDTTO.
      include type /EY1/SAV_I_ETR_BDTPD_BDDTTOTAL.
  types:
      P_FROMPERIOD type POPER,
      P_TOPERIOD type POPER,
      P_RYEAR type GJAHR,
      P_SWITCH type CHAR1,
      P_TAXINTENTION type ZZ1_TAXINTENTION,
      P_RBUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_I_ETR_BDTPD_BDDTTO .
  types:
   TT_XEY1XSAV_I_ETR_BDTPD_BDDTTO type standard table of TS_XEY1XSAV_I_ETR_BDTPD_BDDTTO .
  types:
    begin of TS_XEY1XSAV_I_ETR_BDTPD_BDDTT.
      include type /EY1/SAV_I_ETR_BDTPD_BDDTTOTAL.
  types:
      P_FROMPERIOD type POPER,
      P_TOPERIOD type POPER,
      P_RYEAR type GJAHR,
      P_SWITCH type CHAR1,
      P_TAXINTENTION type ZZ1_TAXINTENTION,
      P_RBUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_I_ETR_BDTPD_BDDTT .
  types:
   TT_XEY1XSAV_I_ETR_BDTPD_BDDTT type standard table of TS_XEY1XSAV_I_ETR_BDTPD_BDDTT .
  types:
   TS_CONSOLIDATIONDIMENSIONTYPE type A_CNSLDTNDIMENSION .
  types:
   TT_CONSOLIDATIONDIMENSIONTYPE type standard table of TS_CONSOLIDATIONDIMENSIONTYPE .
  types:
   TS_TRANSACTIONCURRENCYTEXTTYPE type A_CNSLDTNTRANSCURRENCYT .
  types:
   TT_TRANSACTIONCURRENCYTEXTTYPE type standard table of TS_TRANSACTIONCURRENCYTEXTTYPE .
  types:
    begin of TS_CONSOLIDATIONUNITTYPE.
      include type A_CNSLDTNUNIT.
  types:
      T_CONSOLIDATIONUNIT type A_CNSLDTNUNITT-CONSOLIDATIONUNITTEXT,
      T_CONSOLIDATIONUNITLOC_585D1CB type A_CNSLDTNTRANSCURRENCYT-TRANSACTIONCURRENCYTEXT,
    end of TS_CONSOLIDATIONUNITTYPE .
  types:
   TT_CONSOLIDATIONUNITTYPE type standard table of TS_CONSOLIDATIONUNITTYPE .
  types:
    begin of TS_CONSOLIDATIONUNITHIERTYPE.
      include type A_CNSLDTNUNITHIER.
  types:
      T_HIERARCHYNODE type A_CNSLDTNUNITHIERT-HIERARCHYNODETEXT,
      T_CONSOLIDATIONUNIT type A_CNSLDTNUNITT-CONSOLIDATIONUNITTEXT,
    end of TS_CONSOLIDATIONUNITHIERTYPE .
  types:
   TT_CONSOLIDATIONUNITHIERTYPE type standard table of TS_CONSOLIDATIONUNITHIERTYPE .
  types:
   TS_CNSLDTNUNITLATESTLOCALCRCYT type A_CNSLDTNUNITLATESTLOCALCRCY .
  types:
   TT_CNSLDTNUNITLATESTLOCALCRCYT type standard table of TS_CNSLDTNUNITLATESTLOCALCRCYT .
  types:
   TS_CONSOLIDATIONUNITTEXTTYPE type A_CNSLDTNUNITT .
  types:
   TT_CONSOLIDATIONUNITTEXTTYPE type standard table of TS_CONSOLIDATIONUNITTEXTTYPE .
  types:
   TS_C_CNSLDTNCHARTOFACCOUNTSVHT type C_CNSLDTNCHARTOFACCOUNTSVH .
  types:
   TT_C_CNSLDTNCHARTOFACCOUNTSVHT type standard table of TS_C_CNSLDTNCHARTOFACCOUNTSVHT .
  types:
   TS_C_CNSLDTNCTRLGAREAVHTYPE type C_CNSLDTNCTRLGAREAVH .
  types:
   TT_C_CNSLDTNCTRLGAREAVHTYPE type standard table of TS_C_CNSLDTNCTRLGAREAVHTYPE .
  types:
   TS_C_CNSLDTNDOCUMENTTYPEVHTYPE type C_CNSLDTNDOCUMENTTYPEVH .
  types:
   TT_C_CNSLDTNDOCUMENTTYPEVHTYPE type standard table of TS_C_CNSLDTNDOCUMENTTYPEVHTYPE .
  types:
   TS_C_CNSLDTNFINSTMNTITEMVHTYPE type C_CNSLDTNFINSTMNTITEMVH .
  types:
   TT_C_CNSLDTNFINSTMNTITEMVHTYPE type standard table of TS_C_CNSLDTNFINSTMNTITEMVHTYPE .
  types:
   TS_C_CNSLDTNLEDGERVHTYPE type C_CNSLDTNLEDGERVH .
  types:
   TT_C_CNSLDTNLEDGERVHTYPE type standard table of TS_C_CNSLDTNLEDGERVHTYPE .
  types:
   TS_C_CNSLDTNPOSTINGLEVELVHTYPE type C_CNSLDTNPOSTINGLEVELVH .
  types:
   TT_C_CNSLDTNPOSTINGLEVELVHTYPE type standard table of TS_C_CNSLDTNPOSTINGLEVELVHTYPE .
  types:
   TS_C_CNSLDTNPROFITCENTERFORELI type C_CNSLDTNPROFITCENTERFORELIMVH .
  types:
   TT_C_CNSLDTNPROFITCENTERFORELI type standard table of TS_C_CNSLDTNPROFITCENTERFORELI .
  types:
   TS_C_CNSLDTNPROFITCENTERVHTYPE type C_CNSLDTNPROFITCENTERVH .
  types:
   TT_C_CNSLDTNPROFITCENTERVHTYPE type standard table of TS_C_CNSLDTNPROFITCENTERVHTYPE .
  types:
   TS_C_CNSLDTNSEGMENTFORELIMVHTY type C_CNSLDTNSEGMENTFORELIMVH .
  types:
   TT_C_CNSLDTNSEGMENTFORELIMVHTY type standard table of TS_C_CNSLDTNSEGMENTFORELIMVHTY .
  types:
   TS_C_CNSLDTNSEGMENTVHTYPE type C_CNSLDTNSEGMENTVH .
  types:
   TT_C_CNSLDTNSEGMENTVHTYPE type standard table of TS_C_CNSLDTNSEGMENTVHTYPE .
  types:
   TS_C_CNSLDTNUNITFORELIMINATION type C_CNSLDTNUNITFORELIMINATIONVH .
  types:
   TT_C_CNSLDTNUNITFORELIMINATION type standard table of TS_C_CNSLDTNUNITFORELIMINATION .
  types:
   TS_C_CNSLDTNUNITVALUEHELPTYPE type C_CNSLDTNUNITVALUEHELP .
  types:
   TT_C_CNSLDTNUNITVALUEHELPTYPE type standard table of TS_C_CNSLDTNUNITVALUEHELPTYPE .
  types:
   TS_C_CNSLDTNVERSIONVHTYPE type C_CNSLDTNVERSIONVH .
  types:
   TT_C_CNSLDTNVERSIONVHTYPE type standard table of TS_C_CNSLDTNVERSIONVHTYPE .
  types:
    begin of TS_I_CNSLDTNGROUPWITHEMPTYVALU.
      include type I_CNSLDTNGROUPWITHEMPTYVALUE.
  types:
      T_CONSOLIDATIONGROUP type I_CNSLDTNGROUPT-CONSOLIDATIONGROUPTEXT,
    end of TS_I_CNSLDTNGROUPWITHEMPTYVALU .
  types:
   TT_I_CNSLDTNGROUPWITHEMPTYVALU type standard table of TS_I_CNSLDTNGROUPWITHEMPTYVALU .
  types:
    begin of TS_I_CNSLDTNPERIODMODETYPE.
      include type I_CNSLDTNPERIODMODE.
  types:
      T_PERIODMODE type I_CNSLDTNPERIODMODETEXT-PERIODMODETEXT,
    end of TS_I_CNSLDTNPERIODMODETYPE .
  types:
   TT_I_CNSLDTNPERIODMODETYPE type standard table of TS_I_CNSLDTNPERIODMODETYPE .

  constants GC_XEY1XSAV_C_ETR_CTRTDCBPARAM type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ETR_CTRTDCBParameters' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ETR_CTRTDCBTOTA type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ETR_CTRTDCBTotalType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ETR_CTRTDCBTOTAL type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ETR_CTRTDCBTotalParameters' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ETR_CTRTDCBTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ETR_CTRTDCBType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ETR_PTA_MVMNTPAR type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ETR_PTA_MvmntParameters' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ETR_PTA_MVMNTTYP type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ETR_PTA_MvmntType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ETR_PTA_TOTALPAR type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ETR_PTA_TotalParameters' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ETR_PTA_TOTALTYP type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ETR_PTA_TotalType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ETR_SUM_DDCTRTDP type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ETR_SUM_DDCTRTDParameters' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ETR_SUM_DDCTRTDT type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ETR_SUM_DDCTRTDType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ETR_SUM_DDCTRTO type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ETR_SUM_DDCTRTotalType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ETR_SUM_DDCTRTOT type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ETR_SUM_DDCTRTotalParameters' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ETR_SUM_ITDCTRPA type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ETR_SUM_ITDCTRParameters' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ETR_SUM_ITDCTRT type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ETR_SUM_ITDCTRTotalType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ETR_SUM_ITDCTRTO type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ETR_SUM_ITDCTRTotalParameters' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ETR_SUM_ITDCTRTY type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ETR_SUM_ITDCTRType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ETR_SUM_OVERVIE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ETR_SUM_OverviewType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ETR_SUM_OVERVIEW type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ETR_SUM_OverviewParameters' ##NO_TEXT.
  constants GC_XEY1XSAV_C_FETCH_TAX_RATESP type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_Fetch_Tax_RatesParameters' ##NO_TEXT.
  constants GC_XEY1XSAV_C_FETCH_TAX_RATEST type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_Fetch_Tax_RatesType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_GET_TAX_RATEPARA type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_Get_Tax_RateParameters' ##NO_TEXT.
  constants GC_XEY1XSAV_C_GET_TAX_RATETYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_Get_Tax_RateType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_INTENTIONSSTATU type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_IntentionsStatusType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_INTENTIONSSTATUS type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_IntentionsStatusParameters' ##NO_TEXT.
  constants GC_XEY1XSAV_C_READINTENTVHTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ReadIntentVHType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_RECON_LEDGERTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_Recon_LedgerType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_TIERSTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_TIERSType' ##NO_TEXT.
  constants GC_XEY1XSAV_I_ETR_BDTPD_BDDTT type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_I_ETR_BDTPD_BDDTTotalType' ##NO_TEXT.
  constants GC_XEY1XSAV_I_ETR_BDTPD_BDDTTO type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_I_ETR_BDTPD_BDDTTotalParameters' ##NO_TEXT.
  constants GC_CNSLDTNUNITLATESTLOCALCRCYT type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'CnsldtnUnitLatestLocalCrcyType' ##NO_TEXT.
  constants GC_CONSOLIDATIONDIMENSIONTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'ConsolidationDimensionType' ##NO_TEXT.
  constants GC_CONSOLIDATIONUNITHIERTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'ConsolidationUnitHierType' ##NO_TEXT.
  constants GC_CONSOLIDATIONUNITTEXTTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'ConsolidationUnitTextType' ##NO_TEXT.
  constants GC_CONSOLIDATIONUNITTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'ConsolidationUnitType' ##NO_TEXT.
  constants GC_C_CNSLDTNCHARTOFACCOUNTSVHT type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'C_CnsldtnChartOfAccountsVHType' ##NO_TEXT.
  constants GC_C_CNSLDTNCTRLGAREAVHTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'C_CnsldtnCtrlgAreaVHType' ##NO_TEXT.
  constants GC_C_CNSLDTNDOCUMENTTYPEVHTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'C_CnsldtnDocumentTypeVHType' ##NO_TEXT.
  constants GC_C_CNSLDTNFINSTMNTITEMVHTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'C_CnsldtnFinStmntItemVHType' ##NO_TEXT.
  constants GC_C_CNSLDTNLEDGERVHTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'C_CnsldtnLedgerVHType' ##NO_TEXT.
  constants GC_C_CNSLDTNPOSTINGLEVELVHTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'C_CnsldtnPostingLevelVHType' ##NO_TEXT.
  constants GC_C_CNSLDTNPROFITCENTERFORELI type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'C_CnsldtnProfitCenterForElimVHType' ##NO_TEXT.
  constants GC_C_CNSLDTNPROFITCENTERVHTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'C_CnsldtnProfitCenterVHType' ##NO_TEXT.
  constants GC_C_CNSLDTNSEGMENTFORELIMVHTY type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'C_CnsldtnSegmentForElimVHType' ##NO_TEXT.
  constants GC_C_CNSLDTNSEGMENTVHTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'C_CnsldtnSegmentVHType' ##NO_TEXT.
  constants GC_C_CNSLDTNUNITFORELIMINATION type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'C_CnsldtnUnitForEliminationVHType' ##NO_TEXT.
  constants GC_C_CNSLDTNUNITVALUEHELPTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'C_CnsldtnUnitValueHelpType' ##NO_TEXT.
  constants GC_C_CNSLDTNVERSIONVHTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'C_CnsldtnVersionVHType' ##NO_TEXT.
  constants GC_GLOBALPARAMETER type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'GlobalParameter' ##NO_TEXT.
  constants GC_I_CNSLDTNGROUPWITHEMPTYVALU type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'I_CnsldtnGroupWithEmptyValueType' ##NO_TEXT.
  constants GC_I_CNSLDTNPERIODMODETYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'I_CnsldtnPeriodModeType' ##NO_TEXT.
  constants GC_TRANSACTIONCURRENCYTEXTTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'TransactionCurrencyTextType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_CNSLDTNJRNLENTR type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_CnsldtnJrnlEntryResult' ##NO_TEXT.
  constants GC_XEY1XSAV_C_CNSLDTNJRNLENTRY type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_CnsldtnJrnlEntryParameters' ##NO_TEXT.
  constants GC_XEY1XSAV_C_CURRLOCALGROUPVH type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_CurrLocalGroupVHType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ETR_BDTPD_BDND type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ETR_BDTPD_BDNDTPDType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ETR_BDTPD_BDNDT type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ETR_BDTPD_BDNDTotalType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ETR_BDTPD_BDNDTO type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ETR_BDTPD_BDNDTotalParameters' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ETR_BDTPD_BDNDTP type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ETR_BDTPD_BDNDTPDParameters' ##NO_TEXT.

  methods LOAD_TEXT_ELEMENTS
  final
    returning
      value(RT_TEXT_ELEMENTS) type TT_TEXT_ELEMENTS
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .

  methods DEFINE
    redefinition .
  methods GET_LAST_MODIFIED
    redefinition .
protected section.
private section.

  methods DEFINE_GLOBALPARAMETER
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_ACTIONS
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_RDS_4
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods GET_LAST_MODIFIED_RDS_4
    returning
      value(RV_LAST_MODIFIED_RDS) type TIMESTAMP .
ENDCLASS.



CLASS /EY1/CL_SAV_EFFECTIVE__MPC IMPLEMENTATION.


  method DEFINE.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*

model->set_schema_namespace( 'EY1.SAV_EFFECTIVE_TAX_RECON_SRV' ).

define_globalparameter( ).
define_actions( ).
define_rds_4( ).
get_last_modified_rds_4( ).
  endmethod.


  method DEFINE_ACTIONS.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*


data:
lo_action         type ref to /iwbep/if_mgw_odata_action,                 "#EC NEEDED
lo_parameter      type ref to /iwbep/if_mgw_odata_parameter.              "#EC NEEDED

***********************************************************************************************************************************
*   ACTION - GlobalParameter
***********************************************************************************************************************************

lo_action = model->create_action( 'GlobalParameter' ).  "#EC NOTEXT
*Set return entity type
lo_action->set_return_entity_type( 'GlobalParameter' ). "#EC NOTEXT
*Set HTTP method GET or POST
lo_action->set_http_method( 'GET' ). "#EC NOTEXT
* Set return type multiplicity
lo_action->set_return_multiplicity( '1' ). "#EC NOTEXT
  endmethod.


  method DEFINE_GLOBALPARAMETER.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  data:
        lo_annotation     type ref to /iwbep/if_mgw_odata_annotation,                "#EC NEEDED
        lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,                "#EC NEEDED
        lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type,                "#EC NEEDED
        lo_property       type ref to /iwbep/if_mgw_odata_property,                  "#EC NEEDED
        lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set.                "#EC NEEDED

***********************************************************************************************************************************
*   ENTITY - GlobalParameter
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'GlobalParameter' iv_def_entity_set = abap_false ). "#EC NOTEXT

***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'ConsolidationUnit' iv_abap_fieldname = 'CONSOLIDATIONUNIT' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 18 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'FiscalYear' iv_abap_fieldname = 'FISCALYEAR' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 4 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'ConsolidationChartofAccounts' iv_abap_fieldname = 'CONSOLIDATIONCHARTOFACCOUNTS' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 2 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'ConsolidationGroup' iv_abap_fieldname = 'CONSOLIDATIONGROUP' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 18 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Intention' iv_abap_fieldname = 'INTENTION' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 30 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'PeriodFrom' iv_abap_fieldname = 'PERIODFROM' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 3 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'PeriodTo' iv_abap_fieldname = 'PERIODTO' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 3 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'LocalCurrency' iv_abap_fieldname = 'LOCALCURRENCY' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 5 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'LocalCurrencyType' iv_abap_fieldname = 'LOCALCURRENCYTYPE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 5 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'GroupCurrency' iv_abap_fieldname = 'GROUPCURRENCY' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 5 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'GroupCurrencyType' iv_abap_fieldname = 'GROUPCURRENCYTYPE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 5 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).

lo_entity_type->bind_structure( iv_structure_name  = '/EY1/CL_SAV_EFFECTIVE__MPC=>TS_GLOBALPARAMETER01' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'GlobalParameterSet' ). "#EC NOTEXT

lo_entity_set->set_creatable( abap_false ).
lo_entity_set->set_updatable( abap_false ).
lo_entity_set->set_deletable( abap_false ).

lo_entity_set->set_pageable( abap_false ).
lo_entity_set->set_addressable( abap_false ).
lo_entity_set->set_has_ftxt_search( abap_false ).
lo_entity_set->set_subscribable( abap_false ).
lo_entity_set->set_filter_required( abap_false ).
  endmethod.


  method DEFINE_RDS_4.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*
*   This code is generated for Reference Data Source
*   4
*&---------------------------------------------------------------------*
    TRY.
        if_sadl_gw_model_exposure_data~get_model_exposure( )->expose( model )->expose_vocabulary( vocab_anno_model ).
      CATCH cx_sadl_exposure_error INTO DATA(lx_sadl_exposure_error).
        RAISE EXCEPTION TYPE /iwbep/cx_mgw_med_exception
          EXPORTING
            previous = lx_sadl_exposure_error.
    ENDTRY.
  endmethod.


  method GET_LAST_MODIFIED.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  CONSTANTS: lc_gen_date_time TYPE timestamp VALUE '20210811075913'.                  "#EC NOTEXT
 DATA: lv_rds_last_modified TYPE timestamp .
  rv_last_modified = super->get_last_modified( ).
  IF rv_last_modified LT lc_gen_date_time.
    rv_last_modified = lc_gen_date_time.
  ENDIF.
 lv_rds_last_modified =  GET_LAST_MODIFIED_RDS_4( ).
 IF rv_last_modified LT lv_rds_last_modified.
 rv_last_modified  = lv_rds_last_modified .
 ENDIF .
  endmethod.


  method GET_LAST_MODIFIED_RDS_4.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*
*   This code is generated for Reference Data Source
*   4
*&---------------------------------------------------------------------*
*    @@TYPE_SWITCH:
    CONSTANTS: co_gen_date_time TYPE timestamp VALUE '20210811095914'.
    TRY.
        rv_last_modified_rds = CAST cl_sadl_gw_model_exposure( if_sadl_gw_model_exposure_data~get_model_exposure( ) )->get_last_modified( ).
      CATCH cx_root ##CATCH_ALL.
        rv_last_modified_rds = co_gen_date_time.
    ENDTRY.
    IF rv_last_modified_rds < co_gen_date_time.
      rv_last_modified_rds = co_gen_date_time.
    ENDIF.
  endmethod.


  method IF_SADL_GW_MODEL_EXPOSURE_DATA~GET_MODEL_EXPOSURE.
    CONSTANTS: co_gen_timestamp TYPE timestamp VALUE '20210811095914'.
    DATA(lv_sadl_xml) =
               |<?xml version="1.0" encoding="utf-16"?>|  &
               |<sadl:definition xmlns:sadl="http://sap.com/sap.nw.f.sadl" syntaxVersion="V2" >|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_CNSLDTNJRNLENTRY" binding="/EY1/SAV_C_CNSLDTNJRNLENTRY" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_CURRLOCALGROUPVH" binding="/EY1/SAV_C_CURRLOCALGROUPVH" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_ETR_BDTPD_BDNDTOTAL" binding="/EY1/SAV_C_ETR_BDTPD_BDNDTOTAL" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_ETR_BDTPD_BDNDTPD" binding="/EY1/SAV_C_ETR_BDTPD_BDNDTPD" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_ETR_CTRTDCB" binding="/EY1/SAV_C_ETR_CTRTDCB" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_ETR_CTRTDCBTOTAL" binding="/EY1/SAV_C_ETR_CTRTDCBTOTAL" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_ETR_PTA_MVMNT" binding="/EY1/SAV_C_ETR_PTA_MVMNT" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_ETR_PTA_TOTAL" binding="/EY1/SAV_C_ETR_PTA_TOTAL" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_ETR_SUM_DDCTRTD" binding="/EY1/SAV_C_ETR_SUM_DDCTRTD" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_ETR_SUM_DDCTRTOTAL" binding="/EY1/SAV_C_ETR_SUM_DDCTRTOTAL" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_ETR_SUM_ITDCTR" binding="/EY1/SAV_C_ETR_SUM_ITDCTR" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_ETR_SUM_ITDCTRTOTAL" binding="/EY1/SAV_C_ETR_SUM_ITDCTRTOTAL" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_ETR_SUM_OVERVIEW" binding="/EY1/SAV_C_ETR_SUM_OVERVIEW" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_FETCH_TAX_RATES" binding="/EY1/SAV_C_FETCH_TAX_RATES" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_GET_TAX_RATE" binding="/EY1/SAV_C_GET_TAX_RATE" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_INTENTIONSSTATUS" binding="/EY1/SAV_C_INTENTIONSSTATUS" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_READINTENTVH" binding="/EY1/SAV_C_READINTENTVH" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_RECON_LEDGER" binding="/EY1/SAV_C_RECON_LEDGER" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_TIERS" binding="/EY1/SAV_C_TIERS" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_I_ETR_BDTPD_BDDTTOTAL" binding="/EY1/SAV_I_ETR_BDTPD_BDDTTOTAL" />|  &
               | <sadl:dataSource type="CDS" name="A_CNSLDTNDIMENSION" binding="A_CNSLDTNDIMENSION" />|  &
               | <sadl:dataSource type="CDS" name="A_CNSLDTNTRANSCURRENCYT" binding="A_CNSLDTNTRANSCURRENCYT" />|  &
               | <sadl:dataSource type="CDS" name="A_CNSLDTNUNIT" binding="A_CNSLDTNUNIT" />|  &
               | <sadl:dataSource type="CDS" name="A_CNSLDTNUNITHIER" binding="A_CNSLDTNUNITHIER" />|  &
               | <sadl:dataSource type="CDS" name="A_CNSLDTNUNITLATESTLOCALCRCY" binding="A_CNSLDTNUNITLATESTLOCALCRCY" />|  &
               | <sadl:dataSource type="CDS" name="A_CNSLDTNUNITT" binding="A_CNSLDTNUNITT" />|  &
               | <sadl:dataSource type="CDS" name="C_CNSLDTNCHARTOFACCOUNTSVH" binding="C_CNSLDTNCHARTOFACCOUNTSVH" />|  &
               | <sadl:dataSource type="CDS" name="C_CNSLDTNCTRLGAREAVH" binding="C_CNSLDTNCTRLGAREAVH" />|  &
               | <sadl:dataSource type="CDS" name="C_CNSLDTNDOCUMENTTYPEVH" binding="C_CNSLDTNDOCUMENTTYPEVH" />|  &
               | <sadl:dataSource type="CDS" name="C_CNSLDTNFINSTMNTITEMVH" binding="C_CNSLDTNFINSTMNTITEMVH" />|  &
               | <sadl:dataSource type="CDS" name="C_CNSLDTNLEDGERVH" binding="C_CNSLDTNLEDGERVH" />|  &
               | <sadl:dataSource type="CDS" name="C_CNSLDTNPOSTINGLEVELVH" binding="C_CNSLDTNPOSTINGLEVELVH" />|  &
               | <sadl:dataSource type="CDS" name="C_CNSLDTNPROFITCENTERFORELIMVH" binding="C_CNSLDTNPROFITCENTERFORELIMVH" />|  &
               | <sadl:dataSource type="CDS" name="C_CNSLDTNPROFITCENTERVH" binding="C_CNSLDTNPROFITCENTERVH" />|  &
               | <sadl:dataSource type="CDS" name="C_CNSLDTNSEGMENTFORELIMVH" binding="C_CNSLDTNSEGMENTFORELIMVH" />|  &
               | <sadl:dataSource type="CDS" name="C_CNSLDTNSEGMENTVH" binding="C_CNSLDTNSEGMENTVH" />|  &
               | <sadl:dataSource type="CDS" name="C_CNSLDTNUNITFORELIMINATIONVH" binding="C_CNSLDTNUNITFORELIMINATIONVH" />|  &
               | <sadl:dataSource type="CDS" name="C_CNSLDTNUNITVALUEHELP" binding="C_CNSLDTNUNITVALUEHELP" />|  &
               | <sadl:dataSource type="CDS" name="C_CNSLDTNVERSIONVH" binding="C_CNSLDTNVERSIONVH" />|  &
               | <sadl:dataSource type="CDS" name="I_CNSLDTNGROUPWITHEMPTYVALUE" binding="I_CNSLDTNGROUPWITHEMPTYVALUE" />|  &
               | <sadl:dataSource type="CDS" name="I_CNSLDTNPERIODMODE" binding="I_CNSLDTNPERIODMODE" />|  &
               |<sadl:resultSet>|  &
               |<sadl:structure name="xEY1xSAV_C_CnsldtnJrnlEntryResults" dataSource="/EY1/SAV_C_CNSLDTNJRNLENTRY" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_CurrLocalGroupVH" dataSource="/EY1/SAV_C_CURRLOCALGROUPVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">| .
      lv_sadl_xml = |{ lv_sadl_xml }| &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_ETR_BDTPD_BDNDTotalSet" dataSource="/EY1/SAV_C_ETR_BDTPD_BDNDTOTAL" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_ETR_BDTPD_BDNDTPDSet" dataSource="/EY1/SAV_C_ETR_BDTPD_BDNDTPD" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_ETR_CTRTDCBSet" dataSource="/EY1/SAV_C_ETR_CTRTDCB" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_ETR_CTRTDCBTotalSet" dataSource="/EY1/SAV_C_ETR_CTRTDCBTOTAL" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_ETR_PTA_MvmntSet" dataSource="/EY1/SAV_C_ETR_PTA_MVMNT" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_ETR_PTA_TotalSet" dataSource="/EY1/SAV_C_ETR_PTA_TOTAL" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_ETR_SUM_DDCTRTDSet" dataSource="/EY1/SAV_C_ETR_SUM_DDCTRTD" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_ETR_SUM_DDCTRTotalSet" dataSource="/EY1/SAV_C_ETR_SUM_DDCTRTOTAL" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_ETR_SUM_ITDCTRSet" dataSource="/EY1/SAV_C_ETR_SUM_ITDCTR" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_ETR_SUM_ITDCTRTotalSet" dataSource="/EY1/SAV_C_ETR_SUM_ITDCTRTOTAL" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_ETR_SUM_OverviewSet" dataSource="/EY1/SAV_C_ETR_SUM_OVERVIEW" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_Fetch_Tax_RatesSet" dataSource="/EY1/SAV_C_FETCH_TAX_RATES" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>| .
      lv_sadl_xml = |{ lv_sadl_xml }| &
               |<sadl:structure name="xEY1xSAV_C_Get_Tax_RateSet" dataSource="/EY1/SAV_C_GET_TAX_RATE" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_IntentionsStatusSet" dataSource="/EY1/SAV_C_INTENTIONSSTATUS" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_ReadIntentVH" dataSource="/EY1/SAV_C_READINTENTVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_Recon_Ledger" dataSource="/EY1/SAV_C_RECON_LEDGER" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_TIERS" dataSource="/EY1/SAV_C_TIERS" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_I_ETR_BDTPD_BDDTTotalSet" dataSource="/EY1/SAV_I_ETR_BDTPD_BDDTTOTAL" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="ConsolidationDimension" dataSource="A_CNSLDTNDIMENSION" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="TransactionCurrencyText" dataSource="A_CNSLDTNTRANSCURRENCYT" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="ConsolidationUnit" dataSource="A_CNSLDTNUNIT" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               | <sadl:association name="TO_CNSLDTNDIMENSION" binding="_CNSLDTNDIMENSION" target="ConsolidationDimension" cardinality="zeroToOne" />|  &
               | <sadl:association name="TO_CNSLDTNTRANSCURRENCYT" binding="_CNSLDTNTRANSCURRENCYT" target="TransactionCurrencyText" cardinality="zeroToMany" />|  &
               | <sadl:association name="TO_CNSLDTNUNITHIER" binding="_CNSLDTNUNITHIER" target="ConsolidationUnitHier" cardinality="zeroToMany" />|  &
               | <sadl:association name="TO_CNSLDTNUNITLATESTLOCALCRCY" binding="_CNSLDTNUNITLATESTLOCALCRCY" target="CnsldtnUnitLatestLocalCrcy" cardinality="zeroToOne" />|  &
               | <sadl:association name="TO_CNSLDTNUNITT" binding="_CNSLDTNUNITT" target="ConsolidationUnitText" cardinality="zeroToMany" />|  &
               |</sadl:structure>|  &
               |<sadl:structure name="ConsolidationUnitHier" dataSource="A_CNSLDTNUNITHIER" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="CnsldtnUnitLatestLocalCrcy" dataSource="A_CNSLDTNUNITLATESTLOCALCRCY" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="ConsolidationUnitText" dataSource="A_CNSLDTNUNITT" maxEditMode="RO" exposure="TRUE" >| .
      lv_sadl_xml = |{ lv_sadl_xml }| &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="C_CnsldtnChartOfAccountsVH" dataSource="C_CNSLDTNCHARTOFACCOUNTSVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="C_CnsldtnCtrlgAreaVH" dataSource="C_CNSLDTNCTRLGAREAVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="C_CnsldtnDocumentTypeVH" dataSource="C_CNSLDTNDOCUMENTTYPEVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="C_CnsldtnFinStmntItemVH" dataSource="C_CNSLDTNFINSTMNTITEMVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="C_CnsldtnLedgerVH" dataSource="C_CNSLDTNLEDGERVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="C_CnsldtnPostingLevelVH" dataSource="C_CNSLDTNPOSTINGLEVELVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="C_CnsldtnProfitCenterForElimVH" dataSource="C_CNSLDTNPROFITCENTERFORELIMVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="C_CnsldtnProfitCenterVH" dataSource="C_CNSLDTNPROFITCENTERVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="C_CnsldtnSegmentForElimVH" dataSource="C_CNSLDTNSEGMENTFORELIMVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="C_CnsldtnSegmentVH" dataSource="C_CNSLDTNSEGMENTVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="C_CnsldtnUnitForEliminationVH" dataSource="C_CNSLDTNUNITFORELIMINATIONVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="C_CnsldtnUnitValueHelp" dataSource="C_CNSLDTNUNITVALUEHELP" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>| .
      lv_sadl_xml = |{ lv_sadl_xml }| &
               |</sadl:structure>|  &
               |<sadl:structure name="C_CnsldtnVersionVH" dataSource="C_CNSLDTNVERSIONVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="I_CnsldtnGroupWithEmptyValue" dataSource="I_CNSLDTNGROUPWITHEMPTYVALUE" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="I_CnsldtnPeriodMode" dataSource="I_CNSLDTNPERIODMODE" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |</sadl:resultSet>|  &
               |</sadl:definition>| .

   ro_model_exposure = cl_sadl_gw_model_exposure=>get_exposure_xml( iv_uuid      = CONV #( '/EY1/SAV_EFFECTIVE_TAX_RECON' )
                                                                    iv_timestamp = co_gen_timestamp
                                                                    iv_sadl_xml  = lv_sadl_xml ).
  endmethod.


  method LOAD_TEXT_ELEMENTS.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*


DATA:
     ls_text_element TYPE ts_text_element.                                 "#EC NEEDED
CLEAR ls_text_element.
  endmethod.
ENDCLASS.
