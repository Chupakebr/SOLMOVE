class ZCL_SOLMOVE_HELPER definition
  public
  final
  create public .

public section.

  class-methods DOC_CREATE
    importing
      !IV_DOCUMENTPROPS type ZITSM_PROPS_T .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SOLMOVE_HELPER IMPLEMENTATION.


  method doc_create.

    data:
          ls_doc_properties like line of iv_documentprops.

    loop at iv_documentprops into ls_doc_properties.

    endloop.

  endmethod.
ENDCLASS.
