create or replace PACKAGE CCN_SPREADSHEET_PKG
IS
/**********************************************************
	CCN_SPREADSHEET_PKG
The package takes the query as input and builds the XML clob 
to save as .xlsx file .This package follow Word 2007 
XML Format. 
created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/

  TYPE TP_ALIGNMENT IS RECORD (
     VERTICAL VARCHAR2(11)
   , HORIZONTAL VARCHAR2(16)
   , WRAPTEXT BOOLEAN );

PROCEDURE CLEAR_WORKBOOK
/**********************************************************
	CLEAR_WORKBOOK

The process after building teh Xml clob. In order to clear the 
formating styles that was build for current xml clob.

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
;

PROCEDURE NEW_SHEET( 
/**********************************************************
	NEW_SHEET
  
The process  writes the name for the sheet that was generated
with font style as 'Calibri' and color as 'gray125'

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
   IN_SHEETNAME   IN    VARCHAR2 := NULL);
   
FUNCTION ORAFMT2EXCEL( 
/**********************************************************
	ORAFMT2EXCEL

The process will change the formats of date,time and day representation
based on the specific format.

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
   IN_FORMAT    IN     VARCHAR2 := NULL )
RETURN VARCHAR2;
   
FUNCTION GET_NUMFMT(
/**********************************************************
	GET_NUMFMT

The function will fetch the Number Format Id for the particulae 
format.And assigns the format value and count to
the numFmtId,numFmtIndexes fileds .

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
    IN_FORMAT   IN   VARCHAR2 := NULL )
  RETURN PLS_INTEGER;

FUNCTION GET_FONT (
/**********************************************************
	GET_FONT

The process will assigns the font values like fontsize,theme,italic,bold
with the input values .

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
    IN_NAME      IN    VARCHAR2
  , IN_FAMILY    IN    PLS_INTEGER := 2
  , IN_FONTSIZE  IN    NUMBER      := 11
  , IN_THEME     IN    PLS_INTEGER := 1
  , IN_UNDERLINE IN    BOOLEAN     := FALSE
  , IN_ITALIC    IN    BOOLEAN     := FALSE
  , IN_BOLD      IN    BOOLEAN     := FALSE
  , IN_RGB       IN    VARCHAR2    := NULL) -- this is a hex ALPHA Red Green Blue value
  RETURN PLS_INTEGER;

FUNCTION GET_FILL (
/**********************************************************
	GET_FILL

The process determines the fill formatting properties for the 
shape or chart for the given patterntype.

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
    IN_PATTERNTYPE   IN    VARCHAR2
  , IN_FGRGB         IN    VARCHAR2 := NULL)
  RETURN PLS_INTEGER;

FUNCTION GET_BORDER (
/**********************************************************
	GET_BORDER

This process sets the border for the spreadsheet that is built.

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
    IN_TOP      IN   VARCHAR2 := 'thin'
  , IN_BOTTOM   IN   VARCHAR2 := 'thin'
  , IN_LEFT     IN   VARCHAR2 := 'thin'
  , IN_RIGHT    IN   VARCHAR2 := 'thin' )
 RETURN PLS_INTEGER;

FUNCTION GET_ALIGNMENT (
/**********************************************************
	GET_ALIGNMENT

While writing the xml clob data into the excel sheet this function will 
sets vertical and horizontal alignment in the excel.

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
    IN_VERTICAL     IN   VARCHAR2 := NULL
  , IN_HORIZONTAL   IN   VARCHAR2 := NULL
  , IN_WRAPTEXT     IN   BOOLEAN := NULL )
  RETURN TP_ALIGNMENT;

PROCEDURE CELL(
/**********************************************************
	CELL

This procedure will writes the data into the worksheet
for each row and column  for p_value as NUMBER

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
    IN_COL         IN    PLS_INTEGER
  , IN_ROW         IN    PLS_INTEGER
  , IN_VALUE       IN    NUMBER
  , IN_NUMFMTID    IN    PLS_INTEGER  := NULL
  , IN_FONTID      IN    PLS_INTEGER  := NULL
  , IN_FILLID      IN    PLS_INTEGER  := NULL
  , IN_BORDERID    IN    PLS_INTEGER  := NULL
  , IN_ALIGNMENT   IN    TP_ALIGNMENT := NULL
  , IN_SHEET       IN    PLS_INTEGER  := NULL);
    
PROCEDURE CELL (
/**********************************************************
	CELL

This procedure will writes the data into the worksheet
for each row and column for P_value as DATE

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
    IN_COL       IN  PLS_INTEGER
  , IN_ROW       IN  PLS_INTEGER
  , IN_VALUE     IN  DATE
  , IN_NUMFMTID  IN  PLS_INTEGER  := NULL
  , IN_FONTID    IN  PLS_INTEGER  := NULL
  , IN_FILLID    IN  PLS_INTEGER  := NULL
  , IN_BORDERID  IN  PLS_INTEGER  := NULL
  , IN_ALIGNMENT IN  TP_ALIGNMENT := NULL
  , IN_SHEET     IN  PLS_INTEGER  := NULL);
  
PROCEDURE CELL (
/**********************************************************
	CELL

This procedure will writes the data into the worksheet
for each row and column for p_value as varchar2

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
    IN_COL       IN  PLS_INTEGER
  , IN_ROW       IN  PLS_INTEGER
  , IN_VALUE     IN  VARCHAR2
  , IN_NUMFMTID  IN  PLS_INTEGER  := NULL
  , IN_FONTID    IN  PLS_INTEGER  := NULL
  , IN_FILLID    IN  PLS_INTEGER  := NULL
  , IN_BORDERID  IN  PLS_INTEGER  := NULL
  , IN_ALIGNMENT IN  TP_ALIGNMENT := NULL
  , IN_SHEET     IN  PLS_INTEGER  := NULL);

PROCEDURE HYPERLINK(
/**********************************************************
	HYPERLINK
creates the hyper link for the URL that is passed.

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
    IN_COL    IN   PLS_INTEGER
  , IN_ROW    IN   PLS_INTEGER
  , IN_URL    IN   VARCHAR2
  , IN_VALUE  IN   VARCHAR2    := NULL
  , IN_SHEET  IN   PLS_INTEGER := NULL);

/*PROCEDURE COMMENT (
/**********************************************************
	RETURN_BANK_CARD_HIST

	This PROCEDURE will return a ref cursor with data  
	from BANK_CARD table based on COST_CENTER_CODE

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
/*    IN_COL     IN   PLS_INTEGER
  , IN_ROW     IN   PLS_INTEGER
  , IN_TEXT    IN   VARCHAR2
  , IN_AUTHOR  IN   VARCHAR2    := NULL
  , IN_WIDTH   IN   PLS_INTEGER := 150
  , IN_HEIGHT  IN   PLS_INTEGER := 100
  , IN_SHEET   IN   PLS_INTEGER := NULL );
    
PROCEDURE MERGECELLS(
/**********************************************************
	MERGECELLS

This process merges any two cells with given input of
rows and columns in  a sheet.

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
/*    IN_TL_COL  IN  PLS_INTEGER -- top left
  , IN_TL_ROW  IN  PLS_INTEGER
  , IN_BR_COL  IN  PLS_INTEGER -- bottom right
  , IN_BR_ROW  IN  PLS_INTEGER
  , IN_SHEET   IN  PLS_INTEGER := NULL );

PROCEDURE LIST_VALIDATION (
/**********************************************************
	LIST_VALIDATION

The proces invokes the Add_validation method based on teh input.

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
/*    IN_SQREF_COL    IN    PLS_INTEGER
  , IN_SQREF_ROW    IN    PLS_INTEGER
  , IN_TL_COL       IN    PLS_INTEGER -- top left
  , IN_TL_ROW       IN    PLS_INTEGER
  , IN_BR_COL       IN    PLS_INTEGER -- bottom right
  , IN_BR_ROW       IN    PLS_INTEGER
  , IN_STYLE        IN    VARCHAR2    := 'stop' -- stop, warning, information
  , IN_TITLE        IN    VARCHAR2    := NULL
  , IN_PROMPT       IN    VARCHAR     := NULL
  , IN_SHOW_ERROR   IN    BOOLEAN     := FALSE
  , IN_ERROR_TITLE  IN    VARCHAR2    := NULL
  , IN_ERROR_TXT    IN    VARCHAR2    := NULL
  , IN_SHEET        IN    PLS_INTEGER := NULL);
  
PROCEDURE LIST_VALIDATION(
/**********************************************************
	LIST_VALIDATION

The proces invokes the Add_validation method based on teh input.

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
/*      IN_SQREF_COL      IN   PLS_INTEGER
    , IN_SQREF_ROW      IN   PLS_INTEGER
    , IN_DEFINED_NAME   IN   VARCHAR2
    , IN_STYLE          IN   VARCHAR2    := 'stop' -- STOP, WARNING, INFORMATION
    , IN_TITLE          IN   VARCHAR2    := NULL
    , IN_PROMPT         IN   VARCHAR     := NULL
    , IN_SHOW_ERROR     IN   BOOLEAN     := FALSE
    , IN_ERROR_TITLE    IN   VARCHAR2    := NULL
    , IN_ERROR_TXT      IN   VARCHAR2    := NULL
    , IN_SHEET          IN   PLS_INTEGER := NULL);*/
--
PROCEDURE DEFINED_NAME(
/**********************************************************
	DEFINED_NAME

The process is used to write the header column in the spreadsheet. 

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
    IN_TL_COL      IN    PLS_INTEGER -- Top Left
  , IN_TL_ROW      IN    PLS_INTEGER
  , IN_BR_COL      IN    PLS_INTEGER -- Bottom Right
  , IN_BR_ROW      IN    PLS_INTEGER
  , IN_NAME        IN    VARCHAR2
  , IN_SHEET       IN    PLS_INTEGER := NULL
  , IN_LOCALSHEET  IN    PLS_INTEGER := NULL );


PROCEDURE SET_COLUMN_WIDTH(
/**********************************************************
	SET_COLUMN_WIDTH

The process sets the width of the for each column

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
    IN_COL       IN      PLS_INTEGER
  , IN_WIDTH     IN      NUMBER
  , IN_SHEET     IN      PLS_INTEGER := NULL);
  
PROCEDURE SET_COLUMN(
/**********************************************************
	SET_COLUMN

The process assigns the values for the each column values
like numFmtId,fontId,fillId and borderId. These properties will define the column
format.

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
    IN_COL             IN      PLS_INTEGER
  , IN_NUMFMTID        IN      PLS_INTEGER := NULL
  , IN_FONTID          IN       PLS_INTEGER := NULL
  , IN_FILLID          IN      PLS_INTEGER := NULL
  , IN_BORDERID        IN      PLS_INTEGER := NULL
  , IN_ALIGNMENT               TP_ALIGNMENT := NULL
  , IN_SHEET           IN      PLS_INTEGER := NULL );

PROCEDURE SET_ROW (
/**********************************************************
	SET_ROW

The process assigns the values for the each row values
like numFmtId,fontId,fillId and borderId. These properties will define the row
format.
created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
    IN_ROW           IN      PLS_INTEGER
  , IN_NUMFMTID      IN      PLS_INTEGER := NULL
  , IN_FONTID        IN      PLS_INTEGER := NULL
  , IN_FILLID        IN      PLS_INTEGER := NULL
  , IN_BORDERID      IN      PLS_INTEGER := NULL
  , IN_ALIGNMENT             TP_ALIGNMENT := NULL
  , IN_SHEET         IN      PLS_INTEGER := NULL );

/*PROCEDURE FREEZE_ROWS(
/**********************************************************
	FREEZE_ROWS

	This PROCEDURE will return a ref cursor with data  
	from BANK_CARD table based on COST_CENTER_CODE

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
/*    IN_NR_ROWS   IN  PLS_INTEGER := 1
  , IN_SHEET     IN  PLS_INTEGER := NULL );

PROCEDURE FREEZE_COLS(
/**********************************************************
	FREEZE_COLS

	This PROCEDURE will return a ref cursor with data  
	from BANK_CARD table based on COST_CENTER_CODE

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
 /*    IN_NR_COLS   IN  PLS_INTEGER := 1
   , IN_SHEET     IN  PLS_INTEGER := NULL );
   
PROCEDURE FREEZE_PANE(
/**********************************************************
	FREEZE_PANE

	This PROCEDURE will return a ref cursor with data  
	from BANK_CARD table based on COST_CENTER_CODE

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
 /*   IN_COL      IN    PLS_INTEGER
  , IN_ROW      IN    PLS_INTEGER
  , IN_SHEET    IN    PLS_INTEGER := NULL );*/

PROCEDURE SET_AUTOFILTER (
/**********************************************************
	SET_AUTOFILTER

This Process will indicates the start and end of the column and 
based on the start and end position the column header is build.

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
    IN_COLUMN_START      IN      PLS_INTEGER := NULL
  , IN_COLUMN_END        IN      PLS_INTEGER := NULL
  , IN_ROW_START         IN      PLS_INTEGER := NULL
  , IN_ROW_END           IN      PLS_INTEGER := NULL
  , IN_SHEET             IN      PLS_INTEGER := NULL );

FUNCTION FINISH 
/**********************************************************
	FINISH

This process will build the separate XML clob for 
Style definitions,The main document body,List definitions etc.
Types of xml clobs as per 2007 word format.The Word represents each 
of these document parts with an individual file within the package.
1. [Content_Types].xml :Describes the content type for each part that appears in the file.
2. _rels folder. Stores the relationship part for any given part.
3 .rels file. Describes the relationships that begin the document structure. Called a relationship part.
4. docProps folder. Contains the application's properties parts.
5. xl/workbook.xml contains the styling and formating properties ..

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
RETURN BLOB;

PROCEDURE SAVE (
/**********************************************************
	SAVE
The process will take the directory name and filename 
and converts the BLOB data to File.

created : 01/24/2018 bxa919 CCN Project Team...
**********************************************************/
    IN_DIRECTORY   IN   VARCHAR2
  , IN_FILENAME    IN   VARCHAR2);

PROCEDURE  QUERY2SHEET(
/**********************************************************
    GENERATE_SPREADSHEET
    This Procedure will take the input as SQL query statement
    and build the header and column data by invoking "cell"
    PROCEDURE.DBMS_SQL package have internal FUNCTION which will be 
    used to open work on teh input sql statement 
    
    OPEN_CURSOR       : Opens the cursor and fetches the data from
                           the SQL statement passed with the cursor id.
    PARSE             : The statement will  parses the resulting string.
    DESCRIBE_COLUMNS2 : Describe table to fill in with the description of 
                        each of the columns of the query.
   DEFINE_ARRAY       : used to store the values in an array
 **********************************************************/
    IN_SQL               IN    VARCHAR2
  , IN_COLUMN_HEADERS    IN    BOOLEAN     := TRUE
  , IN_DIRECTORY         IN    VARCHAR2    := NULL
  , IN_FILENAME          IN    VARCHAR2    := NULL
  , IN_SHEET             IN    PLS_INTEGER := NULL
  , IN_SHEETNAME         IN    VARCHAR2
  , IN_DATE_FORMAT       IN    VARCHAR2    := 'd-mmm-yy');

END CCN_SPREADSHEET_PKG;