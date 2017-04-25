--script to create PCI_TERMINAL_MAIL table

CREATE TABLE PCI_TERMINAL_MAIL 
   (	
   /*****************************************************************************
   Created: 04/24/2012 pxb712 CCN Project.... 
   This table is used to store all the records regarding PCI till 6.30PM batch email sent..
   **************************************************************************/
    COST_CENTER_CODE VARCHAR2(6), 
	TERMINAL_NUMBER VARCHAR2(5), 
	ENTRY_DATE DATE, 
	PCI_TERMINAL_ID VARCHAR2(50),
	CONSTRAINT PCI_TERMINAL_PK PRIMARY KEY (ENTRY_DATE, TERMINAL_NUMBER, COST_CENTER_CODE)
   );

   
    
