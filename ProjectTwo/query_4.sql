SELECT to_char(CYCLEDATE, 'Month') "Month", (LAST_DAY(CYCLEDATE) - CYCLEDATE) "Days between"
   FROM PAYDAY;
