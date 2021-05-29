SELECT PERSON, SUM(AMOUNT) AS TOTAL,
COUNT(PERSON) AS COUNT
FROM LEDGER
WHERE LEDGER.PERSON IN (SELECT NAME FROM WORKER)
      AND ACTION='BOUGHT'
GROUP BY PERSON
ORDER BY PERSON; 
