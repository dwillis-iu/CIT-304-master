SELECT *
  FROM STOCK_ACCOUNT JOIN STOCK_TRX
    ON STOCK_ACCOUNT.ACCOUNT = STOCK_TRX.ACCOUNT
 WHERE QUANTITY='100';