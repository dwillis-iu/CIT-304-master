SELECT PERSON, SUM(AMOUNT) AS TOTAL,
COUNT(PERSON) AS COUNT
FROM LEDGER
INNER JOIN WORKER ON
    (LEDGER.PERSON=WORKER.NAME)
WHERE ACTION='BOUGHT'
GROUP BY PERSON
ORDER BY PERSON;
