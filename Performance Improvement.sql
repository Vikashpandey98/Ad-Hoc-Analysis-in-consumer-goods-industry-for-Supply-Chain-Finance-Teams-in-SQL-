-- creating dim_date and joining with fact_sales_monthly table and avoid using the function 'get_fiscal_year()' to reduce the amount of time taking to run the query
	SELECT 
    	    s.date, 
            s.customer_code,
            s.product_code, 
            p.product, p.variant, 
            s.sold_quantity, 
            g.gross_price as gross_price_per_item,
            ROUND(s.sold_quantity*g.gross_price,2) as gross_price_total,
            pre.pre_invoice_discount_pct
	FROM fact_sales_monthly s
	JOIN dim_date dt
        	ON dt.calendar_date = s.date
	JOIN dim_product p
        	ON s.product_code=p.product_code
	JOIN fact_gross_price g
    		ON g.fiscal_year=dt.fiscal_year
    		AND g.product_code=s.product_code
	JOIN fact_pre_invoice_deductions as pre
        	ON pre.customer_code = s.customer_code AND
    		pre.fiscal_year=dt.fiscal_year
	WHERE 
    		dt.fiscal_year=2021     
	LIMIT 1500000;


-- Added the fiscal year in the fact_sales_monthly table itself
SELECT 
		s.date, 
		s.customer_code,
		s.product_code, 
		p.product, p.variant, 
		s.sold_quantity, 
		g.gross_price as gross_price_per_item,
		ROUND(s.sold_quantity*g.gross_price,2) as gross_price_total,
		pre.pre_invoice_discount_pct
FROM fact_sales_monthly s
JOIN dim_product p
		ON s.product_code=p.product_code
JOIN fact_gross_price g
		ON g.fiscal_year=s.fiscal_year
		AND g.product_code=s.product_code
JOIN fact_pre_invoice_deductions as pre
		ON pre.customer_code = s.customer_code AND
		pre.fiscal_year=s.fiscal_year
WHERE 
		s.fiscal_year=2021     
LIMIT 1500000;