@AbapCatalog.sqlViewName: '/EY1/ICOMPCURRVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Company Code Currency - Value Help (I View)'
define view /EY1/I_COMPCURR_VH as select 
   bukrs as CompanyCode,
    curr1 as Currency from t882 where prkz = 'X'
    
  union all 
  select bukrs as CompanyCode,
  curr2 as Currency from t882 where prkz = 'X'
  
  union all
  select bukrs as CompanyCode, curr3 as Currency from t882 where prkz = 'X' 
