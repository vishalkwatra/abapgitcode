interface /EY1/IF_ACC_DOC_CHANGE
  public .


  interfaces IF_BADI_INTERFACE .

  methods CHANGE_HEADER
    changing
      !CS_HEADER type /EY1/SAV_ADJUST_JOURNL_ENT_HDR .
  methods CHANGE_ITEM
    changing
      !CT_ACCGL type /EY1/SAV_TT_ADJUST_JORNL_GL
      !CT_ACCAP type /EY1/SAV_TT_ADJUST_JORNL_AP
      !CT_ACCAR type /EY1/SAV_TT_ADJUST_JORNL_AR
      !CT_TAX type /EY1/SAV_TT_ADJUST_JORNL_TAX .
endinterface.
