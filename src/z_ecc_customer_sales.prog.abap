*&---------------------------------------------------------------------*
*& Report Z_ECC_CUSTOMER_SALES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_ECC_CUSTOMER_SALES.


TABLES: kna1, knvv.

SELECT-OPTIONS: s_kunnr FOR kna1-kunnr.

SELECT kna1~kunnr
       kna1~name1
       knvv~vkorg
       knvv~vtweg
       knvv~spart
  INTO (kna1-kunnr,
        kna1-name1,
        knvv-vkorg,
        knvv-vtweg,
        knvv-spart)
  FROM kna1
  INNER JOIN knvv
    ON kna1~kunnr = knvv~kunnr
  WHERE kna1~kunnr IN s_kunnr.

  WRITE: / kna1-kunnr,
           kna1-name1,
           knvv-vkorg,
           knvv-vtweg,
           knvv-spart.
ENDSELECT.
