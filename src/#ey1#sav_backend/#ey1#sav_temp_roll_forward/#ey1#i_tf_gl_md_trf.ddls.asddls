@EndUserText.label: 'TRF: GL Master Data'
define table function /EY1/I_TF_GL_MD_TRF
with parameters p_ryear : gjahr
returns {
  key  mandt  : abap.clnt;
  key  racct  : racct;
  key  rbunit : fc_bunit;
       rdimen : fc_dimen;
       ryear  : ryear;
       ktopl  : ktopl;
       rcongr : fc_congr;
       rhcur  : lcurr;
       rkcur  : gcurr;
       ritclg : fc_itclg;
       rldnr  : rldnr;
       rvers  : fc_rvers;
       rtcur  : rtcur;
}
implemented by method /ey1/cl_tf_gl_md_trf=>get_data;
