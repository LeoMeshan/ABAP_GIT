*&---------------------------------------------------------------------*
*& Report ZSRPRACTICE1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsrpractice1.

TABLES: mara, vbak, vbap.


* types declaration:
TYPES: BEGIN OF ty_final,
         vbeln TYPE vbak-vbeln,
         posnr TYPE vbap-posnr,
         erdat TYPE vbap-erdat,
         ernam TYPE vbak-ernam,
         mtart TYPE mara-mtart,
       END OF ty_final.

* Data declaration:
DATA: gt_final TYPE STANDARD TABLE OF vbak,
      ls_final TYPE ty_final.

* Selection screen :
SELECT-OPTIONS: s_vbeln FOR vbak-vbeln.

* initialization :


INITIALIZATION.
  LOOP AT SCREEN.
    CASE screen-group1.
      WHEN 'GRP1'.
        screen-input = 1. " Enable field1
      WHEN 'GRP2'.
        screen-input = 0. " Disable field2
    ENDCASE.
  ENDLOOP.
select * from vbak INTO TABLE gt_final.
##Testing 
