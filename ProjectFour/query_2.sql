CREATE VIEW LEDGER_SALES AS
SELECT PERSON, ACTIONDATE, SUM(AMOUNT) AS TOT_AMT
FROM LEDGER
WHERE ACTION='BOUGHT'
GROUP BY PERSON, ACTIONDATE;