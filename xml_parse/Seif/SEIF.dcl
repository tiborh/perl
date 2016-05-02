<!SGML "ISO 8879:1986"

CHARSET BASESET "ISO 646-1983//CHARSET
                International Reference Version (IRV)//ESC 2/5 4/0"
        DESCSET   0       9       UNUSED
                  9       2       9
                 11       2       UNUSED
                 13       1      13
                 14      18       UNUSED
                 32      95      32
                127       1       UNUSED
                        
CAPACITY -- PUBLIC "ISO 8879:1986//CAPACITY Reference//EN" --
		SGMLREF	TOTALCAP       200000
			ENTCAP          35000
			ENTCHCAP        35000
			ELEMCAP         35000
			GRPCAP         150000
			EXGRPCAP        35000
			EXNMCAP         35000
			ATTCAP          50000
			ATTCHCAP        35000
			AVGRPCAP        35000
			NOTCAP          35000
			NOTCHCAP        35000
			IDCAP           35000
			IDREFCAP        35000
			MAPCAP          35000
			LKSETCAP        35000
			LKNMCAP         35000

SCOPE   DOCUMENT

SYNTAX  -- PUBLIC "ISO 8879-1986//SYNTAX Reference//EN" --

SHUNCHAR CONTROLS 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17
            18 19 20 21 22 23 24 25 26 27 28 29 30 31 127 255
BASESET  "ISO 646-1983//CHARSET
          International Reference Version (IRV)//ESC 2/5 4/0"
DESCSET  0 128 0
FUNCTION RE             13
         RS             10
         SPACE          32
         TAB    SEPCHAR  9
NAMING   LCNMSTRT ""
         UCNMSTRT ""
         LCNMCHAR "-."  -- Lower-case hyphen, period are --
         UCNMCHAR "-."  -- same as upper-case (45 46).   --
         NAMECASE GENERAL YES
                  ENTITY  NO
DELIM    GENERAL  SGMLREF   -- See ReferenceDelimiterSet-General  --
         SHORTREF SGMLREF   -- See ReferenceDelimiterSet-Shortref --
NAMES    SGMLREF            -- See ReservedNames     --
QUANTITY SGMLREF            -- See ReferenceQuantity --
		ATTCNT          100 -- def  40 --
	--	ATTSPLEN        960 --
	--	BSEQLEN         960 --
	--	DTAGLEN          16 --
	--	DTEMPLEN         16 --
	--	ENTLVL           16 --
		GRPCNT          100 -- def  32 --
	--	GRPGTCNT         96 --
	--	GRPLVL           16 --
		LITLEN         1024 -- def 240 --
		NAMELEN          32 -- def   8 --
	--	NORMSEP           2 --
		PILEN          1024 -- def 240 --
	--	TAGLEN          960 --
	--	TAGLVL           24 --


FEATURES
        MINIMIZE DATATAG NO     OMITTAG  YES    RANK     NO     SHORTTAG YES
        LINK     SIMPLE  NO     IMPLICIT NO     EXPLICIT NO
        OTHER    CONCUR  NO     SUBDOC   NO     FORMAL   YES

APPINFO
        NONE

>
