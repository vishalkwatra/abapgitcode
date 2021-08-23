class /EY1/CL_SAV_RECON_GAAP_MPC_EXT definition
  public
  inheriting from /EY1/CL_SAV_RECON_GAAP_MPC
  create public .

public section.

  methods DEFINE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS /EY1/CL_SAV_RECON_GAAP_MPC_EXT IMPLEMENTATION.


  METHOD define.

*
*    DATA: lo_ann_target  TYPE REF TO /iwbep/if_mgw_vocan_ann_target.   " Vocabulary Annotation Target
*    DATA: lo_ann_target2 TYPE REF TO /iwbep/if_mgw_vocan_ann_target.   " Vocabulary Annotation Target
*    DATA: lo_annotation  TYPE REF TO /iwbep/if_mgw_vocan_annotation.   " Vocabulary Annotation
*    DATA: lo_collection  TYPE REF TO /iwbep/if_mgw_vocan_collection.   " Vocabulary Annotation Collection
*    DATA: lo_function    TYPE REF TO /iwbep/if_mgw_vocan_function.     " Vocabulary Annotation Function
*    DATA: lo_fun_param   TYPE REF TO /iwbep/if_mgw_vocan_fun_param.    " Vocabulary Annotation Function Parameter
*    DATA: lo_property    TYPE REF TO /iwbep/if_mgw_vocan_property.     " Vocabulary Annotation Property
*    DATA: lo_record      TYPE REF TO /iwbep/if_mgw_vocan_record.       " Vocabulary Annotation Record
*    DATA: lo_simp_value  TYPE REF TO /iwbep/if_mgw_vocan_simple_val.   " Vocabulary Annotation Simple Value
*    DATA: lo_url         TYPE REF TO /iwbep/if_mgw_vocan_url.          " Vocabulary Annotation URL
*    DATA: lo_label_elem  TYPE REF TO /iwbep/if_mgw_vocan_label_elem.   " Vocabulary Annotation Labeled Element
*    DATA: lo_reference   TYPE REF TO /iwbep/if_mgw_vocan_reference.    " Vocabulary Annotation Reference


*    DATA: lr_entity   TYPE REF TO /iwbep/if_mgw_odata_entity_typ.

    super->define( ).

*   lo_reference = vocab_anno_model->create_vocabulary_reference( iv_vocab_id = '/IWBEP/VOC_COMMON' iv_vocab_version = '0001').
*   lo_reference->create_include( iv_namespace = 'com.sap.vocabularies.Common.v1' iv_alias = 'Common' ).
*
*
*   lo_ann_target = vocab_anno_model->create_annotations_target( 'xEY1xSAV_C_ReconciliationResults/FinancialStatementItem' ).
*   lo_ann_target->set_namespace_qualifier( 'EY1.SAV_RECON_GAAP_STAT_TAX_SRV' ).
*
*   "Mapping
*   lo_annotation = lo_ann_target->create_annotation( iv_term = 'Common.Text' ).
*   lo_simp_value = lo_annotation->create_simple_value( ).
*   lo_simp_value->set_path( 'FinancialStatementItemMdmText' ).



*    DATA(lr_entityset) = model->get_entity_set( 'Z_C_ACDOCU_GAAP_STAT' ).
**    DATA(lr_anno) = lr_entityset->create_annotation( 'sap' ).
**    IF lr_anno IS BOUND.
**      lr_anno->add( iv_key = 'updatable-path' iv_value = 'true' ).
**    ENDIF.
*    lr_entityset->set_updatable(
*        iv_updatable = abap_true
*    ).
*
*
*    DATA(lr_entity) = model->get_entity_type( iv_entity_name = 'Z_C_ACDOCU_GAAP_STATType' ).
*    DATA(lr_property) = lr_entity->get_property( iv_property_name = 'G2sPl' ).
*    lr_property->set_updatable(
*        iv_updatable = abap_true
*    ).
*
*
*    lr_property = lr_entity->get_property( iv_property_name = 'G2sPermanent' ).
*    lr_property->set_updatable(
*        iv_updatable = abap_true
*    ).
*
*
*    lr_property = lr_entity->get_property( iv_property_name = 'G2sEq' ).
*    lr_property->set_updatable(
*        iv_updatable = abap_true
*    ).
*
*
*    lr_property = lr_entity->get_property( iv_property_name = 'G2sOtherPl' ).
*    lr_property->set_updatable(
*        iv_updatable = abap_true
*    ).
*
*
*    lr_property = lr_entity->get_property( iv_property_name = 'G2s_Other_Permanent' ).
*    lr_property->set_updatable(
*        iv_updatable = abap_true
*    ).
*
*    lr_property = lr_entity->get_property( iv_property_name = 'G2sOtherEq' ).
*    lr_property->set_updatable(
*        iv_updatable = abap_true
*    ).
*
*    DATA(lt_properties) = lr_entity->get_properties( ).
*    LOOP AT lt_properties ASSIGNING FIELD-SYMBOL(<fs_property>).
*      IF <fs_property>-name NE 'G2SPL' AND <fs_property>-name NE 'G2SPERMANENT' AND
*        <fs_property>-name NE 'G2SEQ' AND <fs_property>-name NE 'G2SOTHERPL' AND
*        <fs_property>-name NE 'G2S_OTHER_PERMANENT' AND <fs_property>-name NE 'G2SOTHEREQ'.
*        <fs_property>-property->set_updatable(
*            iv_updatable = abap_false
*        ).
*      ENDIF.
*    ENDLOOP.
*
**    CATCH /iwbep/cx_mgw_med_exception. " Meta data exception
**    CATCH /iwbep/cx_mgw_med_exception. " Meta data exception

  ENDMETHOD.
ENDCLASS.
