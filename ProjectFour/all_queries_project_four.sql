-- 1
SELECT DISTINCT ACTION FROM LEDGER;

-- 2
CREATE VIEW LEDGER_SALES AS
SELECT PERSON, ACTIONDATE, SUM(AMOUNT) AS TOT_AMT
FROM LEDGER
WHERE ACTION='BOUGHT'
GROUP BY PERSON, ACTIONDATE;

-- 3
SELECT MIN(LEDGER_SALES.TOT_AMT) AS MINIMUM,
MAX(LEDGER_SALES.TOT_AMT) AS MAXIMUM,
AVG(LEDGER_SALES.TOT_AMT) AS AVERAGE
FROM LEDGER_SALES;

-- 4
SELECT PERSON, COUNT(*) REPEATING_BUSINESS
FROM LEDGER_SALES
GROUP BY PERSON
HAVING COUNT(*) > 1;

-- 5.1
SELECT PERSON, SUM(AMOUNT) AS TOTAL,
COUNT(PERSON) AS COUNT
FROM LEDGER
INNER JOIN WORKER ON
    (LEDGER.PERSON=WORKER.NAME)
WHERE ACTION='BOUGHT'
GROUP BY PERSON
ORDER BY PERSON;

-- 5.2
SELECT PERSON, SUM(AMOUNT) AS TOTAL,
COUNT(PERSON) AS COUNT
FROM LEDGER
WHERE LEDGER.PERSON IN (SELECT NAME FROM WORKER)
      AND ACTION='BOUGHT'
GROUP BY PERSON
ORDER BY PERSON; 

-- 5.3
SELECT PERSON, SUM(AMOUNT) AS TOTAL,
COUNT(PERSON) AS COUNT
FROM LEDGER
WHERE EXISTS (SELECT * FROM WORKER
             WHERE WORKER.NAME = LEDGER.PERSON)
      AND ACTION='BOUGHT'
GROUP BY PERSON
ORDER BY PERSON;

-- 6
SELECT PERSON, ACTION, COUNT(PERSON) AS COUNT,
    CASE ACTION
        WHEN 'BOUGHT' THEN TO_CHAR(SUM(AMOUNT))
        ELSE 'NEVER BOUGHT' END TOT_AMT
FROM LEDGER RIGHT JOIN WORKER
ON LEDGER.PERSON = WORKER.NAME
GROUP BY PERSON, ACTION
ORDER BY PERSON, ACTION;

-- 7.1
SELECT WORKER.NAME, WORKER.AGE, WORKER.LODGING, SKILL, ABILITY
FROM WORKERSKILL
LEFT OUTER JOIN WORKER
ON WORKERSKILL.NAME = WORKER.NAME
WHERE WORKERSKILL.ABILITY NOT IN ('GOOD', 'EXCELLENT', 'AVERAGE')
ORDER BY NAME;

-- 7.2
SELECT WORKER.NAME, WORKER.AGE, WORKER.LODGING, SKILL, ABILITY
FROM WORKERSKILL
LEFT OUTER JOIN WORKER
ON WORKERSKILL.NAME = WORKER.NAME
WHERE WORKERSKILL.ABILITY != 'GOOD'
AND WORKERSKILL.ABILITY != 'AVERAGE'
AND WORKERSKILL.ABILITY != 'EXCELLENT'
ORDER BY NAME;

-- 8
SELECT DECODE(
    GROUPING(PERSON), 1, 'Total', PERSON) AS SUBTOTAL,
TO_CHAR(ACTIONDATE, 'Month') AS MONTH, SUM(QUANTITY*RATE) AS TOT_AMT
FROM LEDGER
WHERE ACTION = 'SOLD'
GROUP BY ROLLUP (PERSON, ACTIONDATE)
ORDER BY PERSON;