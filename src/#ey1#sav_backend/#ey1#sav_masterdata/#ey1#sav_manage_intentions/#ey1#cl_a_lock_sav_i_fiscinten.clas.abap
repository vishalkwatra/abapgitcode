class /EY1/CL_A_LOCK_SAV_I_FISCINTEN definition
  public
  inheriting from /BOBF/CL_LIB_A_LOCK_ACTIVE_SK
  final
  create public .

public section.
protected section.

  methods LOCK_ACTIVE_INSTANCES
    redefinition .
private section.
ENDCLASS.



CLASS /EY1/CL_A_LOCK_SAV_I_FISCINTEN IMPLEMENTATION.


  method LOCK_ACTIVE_INSTANCES.
  endmethod.
ENDCLASS.
