CREATE VIEW v_region_sales_summary AS
SELECT
  Region,
  COUNT(*) AS Sales_Count,
  SUM(
    COALESCE(CAST(Unit_Price AS REAL), 0)
    * COALESCE(CAST(Quantity_Sold AS REAL), 0)
    * (1 - COALESCE(CAST(Discount AS REAL), 0))
  ) AS Total_Revenue
FROM sales
GROUP BY Region
ORDER BY Total_Revenue DESC;
