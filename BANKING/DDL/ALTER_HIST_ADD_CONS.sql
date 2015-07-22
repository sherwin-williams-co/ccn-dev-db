ALTER TABLE "BANKING"."BANK_ACCOUNT_HIST" MODIFY ("EXPIRATION_DATE" NULL);
ALTER TABLE "BANKING"."BANK_ACCOUNT_HIST" ADD CONSTRAINT "BANK_ACCOUNT_HIST_PK" PRIMARY KEY ("BANK_ACCOUNT_NBR","EFFECTIVE_DATE") ENABLE;
ALTER TABLE "BANKING"."BANK_MICR_FORMAT_HIST" MODIFY ("EXPIRATION_DATE" NULL);
ALTER TABLE "BANKING"."BANK_MICR_FORMAT_HIST" ADD CONSTRAINT "BANK_MICR_FORMAT_HIST_PK" PRIMARY KEY ("BANK_ACCOUNT_NBR","FORMAT_NAME","EFFECTIVE_DATE") ENABLE;
ALTER TABLE "BANKING"."LEAD_BANK_CC_HIST" MODIFY ("EXPIRATION_DATE" NULL);
ALTER TABLE "BANKING"."LEAD_BANK_CC_HIST" ADD CONSTRAINT "LEAD_BANK_CC_HIST_PK" PRIMARY KEY ("LEAD_BANK_ACCOUNT_NBR","LEAD_STORE_NBR","EFFECTIVE_DATE") ENABLE;
ALTER TABLE "BANKING"."MEMBER_BANK_CC_HIST" MODIFY ("EXPIRATION_DATE" NULL);
ALTER TABLE "BANKING"."MEMBER_BANK_CC_HIST" ADD CONSTRAINT "MEMBER_BANK_CC_HIST_PK" PRIMARY KEY ("LEAD_BANK_ACCOUNT_NBR","LEAD_STORE_NBR","MEMBER_STORE_NBR","EFFECTIVE_DATE") ENABLE;


CREATE UNIQUE INDEX "BANKING"."BANK_MICR_FORMAT_HIST_PK" ON "BANKING"."BANK_MICR_FORMAT_HIST" ("BANK_ACCOUNT_NBR","FORMAT_NAME","EFFECTIVE_DATE");