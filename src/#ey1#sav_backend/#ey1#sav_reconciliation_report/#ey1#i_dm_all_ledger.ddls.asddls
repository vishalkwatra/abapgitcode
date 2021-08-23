@AbapCatalog.sqlViewName: '/EY1/IDM_ALL_LED'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Returns All Ledgers For Data Monitor'

define view /EY1/I_DM_ALL_LEDGER 
  with parameters 
   p_bunit: fc_bunit
  as select key gaap as rldnr, bunit from /ey1/reconledger
      where bunit = $parameters.p_bunit
  union all
  select key stat as rldnr, bunit from /ey1/reconledger
      where bunit = $parameters.p_bunit
  union all 
    select key g2s as rldnr, bunit from /ey1/reconledger
      where bunit = $parameters.p_bunit
  union all
    select key s2t as rldnr, bunit from /ey1/reconledger
      where bunit = $parameters.p_bunit
  union all
    select key tax as rldnr, bunit from /ey1/reconledger
      where bunit = $parameters.p_bunit ;
