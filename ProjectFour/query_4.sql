SELECT PERSON, COUNT(*) REPEATING_BUSINESS
FROM LEDGER_SALES
GROUP BY PERSON
HAVING COUNT(*) > 1;