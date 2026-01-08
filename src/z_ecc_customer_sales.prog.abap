REPORT Z_ECC_CUSTOMER_SALES.

SELECT-OPTIONS: s_kunnr FOR kunnr.

SELECT FROM kna1
   INNER JOIN knvv ON kna1~kunnr = knvv~kunnr
   FIELDS kna1~kunnr, kna1~name1, knvv~vkorg, knvv~vtweg, knvv~spart
   WHERE kna1~kunnr IN @s_kunnr
   INTO TABLE @DATA(result).

LOOP AT result INTO DATA(line).
  WRITE: / line-kunnr, line-name1, line-vkorg, line-vtweg, line-spart.
ENDLOOP.