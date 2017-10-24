
--COMMENT ON TABLE ACCOUNT_CODES IS 'All information encompassed by the chart of accounts for OMS Trust.';

CREATE TABLE ACCOUNT_CODES 
(	REC_ACCOUNT_CODE INTEGER, 
	ACCOUNT_CODE INTEGER PRIMARY KEY NOT NULL,           -- 'General ledger account code.';
	ACCOUNT_NAME VARCHAR(40) NOT NULL,                   -- 'Account Description';
	POSTING_STATUS_FLAG VARCHAR(1) DEFAULT 'Y' NOT NULL, -- 'Y/N flag indicating if account is a posting account.';
	ACCOUNT_TYPE VARCHAR(12),                            -- 'Reference Code [ACCOUNT_TYPE ]';
	SUB_ACCOUNT_TYPE VARCHAR(12),                        -- 'Reference Code ( SUB_AC_TYPE).';
	TXN_POSTING_TYPE VARCHAR(12),                        -- 'Reference ( AC_TXN_TYPE ) Account Posting Type';
	ALL_CASELOAD_FLAG VARCHAR(1) DEFAULT 'Y' NOT NULL,   -- 'Apply for All Caseload';
	MODIFY_USER_ID VARCHAR(32),                          -- 'The user who modifies the record';
	MODIFY_DATE DATE NOT NULL,                           -- 'Modify Date';
	LIST_SEQ INTEGER DEFAULT 99,                         -- 'The sequence in which the data should be shown';
	CASELOAD_TYPE VARCHAR(12),                           -- 'The Case Load Type';
	PARENT_ACCOUNT_CODE INTEGER,                         -- 'Parent_code to Account_code';
	CREATE_DATETIME TIMESTAMP DEFAULT now() NOT NULL,    -- 'The timestamp when the record is created';
	CREATE_USER_ID VARCHAR(32) DEFAULT USER NOT NULL,    -- 'The user who creates the record';
	MODIFY_DATETIME TIMESTAMP,                           -- 'The timestamp when the record is modified ';
	AUDIT_TIMESTAMP TIMESTAMP, 
	AUDIT_USER_ID VARCHAR(32), 
	AUDIT_MODULE_NAME VARCHAR(65), 
	AUDIT_CLIENT_USER_ID VARCHAR(64), 
	AUDIT_CLIENT_IP_ADDRESS VARCHAR(39), 
	AUDIT_CLIENT_WORKSTATION_NAME VARCHAR(64), 
	AUDIT_ADDITIONAL_INFO VARCHAR(256)
);

CREATE INDEX ACCOUNT_CODES_NI1 ON ACCOUNT_CODES (CASELOAD_TYPE, SUB_ACCOUNT_TYPE);
CREATE INDEX AC_CODE_AC_CODE_F5 ON ACCOUNT_CODES (PARENT_ACCOUNT_CODE);
