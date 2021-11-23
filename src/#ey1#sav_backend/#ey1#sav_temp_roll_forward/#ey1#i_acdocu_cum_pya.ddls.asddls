@AbapCatalog.sqlViewName: '/EY1/IACDOCUPYA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ACDOCU and PYA Union View for GL Master Data'
define view /EY1/I_ACDOCU_CUM_PYA 
with parameters
    p_ryear : gjahr
as select from /EY1/I_TF_GL_MD_TRF(p_ryear: $parameters.p_ryear)
--acdocu   
{
      
      key  racct ,
      key  rbunit,
      rdimen,
      ryear,
      
      ktopl,
      rcongr,
      rhcur,
      rkcur,
      ritclg,
      rldnr,
      rvers,
      rtcur
      
} where ryear = :p_ryear
--union

--select from /ey1/pya_amount{

--      key glaccount as racct,
--      key bunit as rbunit,
--      '' as rdimen,
--      pya_year as ryear,
      
      
--      ktopl,
      
--      '' as rcongr,


      
--      localcurrency as rhcur,      
      
--      groupcurrency as rkcur,
--      ritclg
--} 
-- where pya_year = :p_ryear 
