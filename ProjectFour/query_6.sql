SELECT PERSON, ACTION, COUNT(PERSON) AS COUNT,
    CASE ACTION
        WHEN 'BOUGHT' THEN TO_CHAR(SUM(AMOUNT))
        ELSE 'NEVER BOUGHT' END TOT_AMT
FROM LEDGER RIGHT JOIN WORKER
ON LEDGER.PERSON = WORKER.NAME
GROUP BY PERSON, ACTION
ORDER BY PERSON, ACTION;