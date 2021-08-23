*&---------------------------------------------------------------------*
*& Report /EY1/CX1Q
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT /EY1/CX1Q
       no standard page heading line-size 255.

* Include bdcrecx1_s:
* The call transaction using is called WITH AUTHORITY-CHECK!
* If you have own auth.-checks you can use include bdcrecx1 instead.
include /ey1/bdcrecx1_s.

PARAMETERS: p_congr TYPE fc_congr.
PARAMETERS: p_rldnr TYPE rldnr.

parameters: dataset(132) lower case.
***    DO NOT CHANGE - the generated data section - DO NOT CHANGE    ***
*
*   If it is nessesary to change the data section use the rules:
*   1.) Each definition of a field exists of two lines
*   2.) The first line shows exactly the comment
*       '* data element: ' followed with the data element
*       which describes the field.
*       If you don't have a data element use the
*       comment without a data element name
*   3.) The second line shows the fieldname of the
*       structure, the fieldname must consist of
*       a fieldname and optional the character '_' and
*       three numbers and the field length in brackets
*   4.) Each field must be type C.
*
*** Generated data section with specific formatting - DO NOT CHANGE  ***
data: begin of record,
* data element: FC_CONGR
        CONGR_001(018),
* data element: FC_TXTSH
        TXTSH_002(015),
* data element: FC_TXTMI
        TXTMI_003(030),
* data element: FC_FSCAT
        FSCAT_004(001),
* data element: FC_RLDNR
        RLDNR_005(002),
      end of record.

*** End generated data section ***

start-of-selection.

*perform open_dataset using dataset.
*perform open_group.

*do.

*read dataset dataset into record.
*if sy-subrc <> 0. exit. endif.

perform bdc_dynpro      using 'SAPMF21B' '2000'.
perform bdc_field       using 'BDC_CURSOR'
                              'FC01BASE-CONGR'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'FC01BASE-CONGR'
                               p_congr.
perform bdc_dynpro      using 'SAPMF21B' '2100'.
perform bdc_field       using 'BDC_OKCODE'
                              '=SAVE'.
perform bdc_field       using 'BDC_CURSOR'
                              'FC01BASE-RLDNR'.
*perform bdc_field       using 'FC01BASE-TXTSH'
*                              record-TXTSH_002.
*perform bdc_field       using 'FC01BASE-TXTMI'
*                              record-TXTMI_003.
*perform bdc_field       using 'FC01BASE-FSCAT'
*                              record-FSCAT_004.
perform bdc_field       using 'FC01BASE-RLDNR'
                              p_rldnr.
perform bdc_transaction using 'CX1Q'.

*enddo.

*perform close_group.
*perform close_dataset using dataset.
