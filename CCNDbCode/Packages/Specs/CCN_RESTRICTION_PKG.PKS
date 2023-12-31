create or replace PACKAGE "CCN_RESTRICTION_PKG" AS 
 /******************************************************************************
 This package will contain the core procedures to handle locking/restriction of 
 multiple users accessing same objects at the same time
 
 Created On : 04/15/2014
 Created By : CCN Project Team - jcv517
 ******************************************************************************/
  
    C_RELEASE_TIMED_OUT_MINS CONSTANT NUMBER := 5;

 FUNCTION IS_OBJECT_RESTRICTED(
 /******************************************************************************
 IS_OBJECT_RESTRICTED
 
 This function will check if there is a restriction already placed on passed in object
 Returns USER_ID who is locking the object if restricted
 Returns NULL if NOT restricted
 
 IN_OBJECT_NAME - Name of the Object on which restriction needs to be checked
 
 ******************************************************************************/
 IN_OBJECT_NAME   IN     CCN_RESTRICTION.OBJECT_NAME%TYPE) RETURN BOOLEAN;
 
 PROCEDURE RESTRICT_OBJECT(
 /******************************************************************************
 RESTRICT_OBJECT
 
 This procedure will place restriction on passed object
 
 IN_OBJECT_NAME     - Name of the Object on which restriction needs to be placed
 
 ******************************************************************************/
 IN_OBJECT_NAME     IN       CCN_RESTRICTION.OBJECT_NAME%TYPE);
 
 PROCEDURE RELEASE_OBJECT(
 /******************************************************************************
 RELEASE_OBJECT
 
 This procedure will release the restriction on passed object based on passed 
 restriction ID
 
 IN_RESTRICTION_ID     - Restriction ID that needs to be released
 
 ******************************************************************************/
 IN_OBJECT_NAME     IN       CCN_RESTRICTION.OBJECT_NAME%TYPE);
 
 PROCEDURE RELEASE_TIMED_OUT_OBJECTS(
 /******************************************************************************
 RELEASE_TIMED_OUT_OBJECTS
 
 This procedure will release the restriction on all objects that are timed out
 
 IN_TIME_OUT_MINUTES - passed Number of Minutes which will be used to expire restricted objects
 
 ******************************************************************************/
 IN_TIME_OUT_MINUTES     IN       NUMBER);

 
END CCN_RESTRICTION_PKG;
