/  ********************************************************************************** 
This script is used to rename table created for SRA11000 parallel process. These tables will be used in the actual process.

Created : 10/03/2018 pxa852 CCN Project Team....
Modified: 
**********************************************************************************/

ALTER TABLE POS_SUMM_EXTRCT_CNTRL_HST_TST RENAME TO POS_SUMMARY_EXTRCT_CNTRL_HST;

ALTER TABLE POS_SUMM_EXTRCT_CNTRL_FL_TST RENAME TO POS_SUMMARY_EXTRCT_CNTRL_FL;