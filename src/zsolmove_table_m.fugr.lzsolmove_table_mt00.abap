*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 03.07.2023 at 14:30:58
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZSOLMOVE_MAPPING................................*
DATA:  BEGIN OF STATUS_ZSOLMOVE_MAPPING              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZSOLMOVE_MAPPING              .
CONTROLS: TCTRL_ZSOLMOVE_MAPPING
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZSOLMOVE_MAPPING              .
TABLES: ZSOLMOVE_MAPPING               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
