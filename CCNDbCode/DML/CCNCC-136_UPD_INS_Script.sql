UPDATE ROLE_DETAILS
   SET USER_RULES ='<USER_RULES>
                      <POLLING_WINDOW/>
                    </USER_RULES>',
 USER_RULES_DESCRIPTION ='<USER_RULES_DESCRIPTION>
                            <POLLING_WINDOW>
                              <VALUE>ALL_FIELDS</VALUE>
                            </POLLING_WINDOW>
                          </USER_RULES_DESCRIPTION>'
WHERE role_code ='CCNUS4';

UPDATE ROLE_DETAILS
   SET USER_RULES ='<USER_RULES>
                      <COST_CENTER_WINDOW>
                        <VALUE>BATCH_PROCESS_WINDOW</VALUE>
                      </COST_CENTER_WINDOW>
                    </USER_RULES>',
 USER_RULES_DESCRIPTION ='<USER_RULES_DESCRIPTION>
                            <COST_CENTER_WINDOW>
                               <BATCH_PROCESS_WINDOW>
                                  <VALUE>BULK_HIERARCHY_INSERT_SECTION</VALUE>
                                  <VALUE>PRICE_DISTRICT_FUTURE_REPORT_SECTION</VALUE>
                               </BATCH_PROCESS_WINDOW>
                            </COST_CENTER_WINDOW>
                          </USER_RULES_DESCRIPTION>'
WHERE role_code ='CCNUPB';

commit;