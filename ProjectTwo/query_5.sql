SELECT PERSON FROM LEDGER WHERE NOT (PERSON LIKE '%STORE'
OR PERSON LIKE '%OFFICE'
OR PERSON LIKE '%CHURCH'
OR PERSON LIKE '%HARDWARE'
OR PERSON LIKE '%AND%'
OR PERSON LIKE 'BLACKSMITH'
OR PERSON LIKE 'SCHOOL'
OR PERSON LIKE 'LIVERY'
OR PERSON LIKE '%COMPANY'
OR PERSON LIKE 'MILL');