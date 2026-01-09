REPORT Z_ECC_ASSET_REPORT.

SELECT-OPTIONS: s_anln1 FOR anla-anln1, s_bukrs FOR anla-bukrs.

TYPES: BEGIN OF ty_asset, bukrs TYPE anla-bukrs, anln1 TYPE anla-anln1, txt50 TYPE anla-txt50, afabe TYPE anlc-afabe, nafav TYPE anlc-nafav, END OF ty_asset.

DATA: lt_assets TYPE TABLE OF ty_asset, ls_asset TYPE ty_asset.

SELECT a~bukrs, a~anln1, a~txt50, b~afabe, b~nafav INTO TABLE @lt_assets FROM anla AS a INNER JOIN anlc AS b ON a~bukrs = b~bukrs AND a~anln1 = b~anln1 WHERE a~bukrs IN @s_bukrs AND a~anln1 IN @s_anln1.

LOOP AT lt_assets INTO ls_asset.
  WRITE: / ls_asset-bukrs, ls_asset-anln1, ls_asset-txt50, ls_asset-afabe, ls_asset-nafav.
ENDLOOP.