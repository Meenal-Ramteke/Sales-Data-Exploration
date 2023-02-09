#SALES DATA EXPLORATION

show databases;

use sales_info;
describe sales;
select * from sales;
describe date_info;
select * from date_info;

#Shows total sales by State, Region, Category around United States
	select country, state, region, category, sum(Quantity), sum(Product_sales) as Total_Sales 
		from sales
			group by 2,3,4
				order by 3,4,5;
        
#To see which category and sub_category produces maximum profit
	select Category, Sub_Category, max(Profit) as Highest_Profit
		from sales
			group by sub_category
				order by 3 desc;
                
#To check which category sales are making profit and which are in loss
	select Category, Sub_Category, sum(Quantity), sum(Product_Sales), sum(Profit)
		from sales
			group by 2
				order by 5 desc;

#To check which days does have profitable sales
	select s.`Product Name`,s.Sub_Category, s.Product_Sales, s.Profit, d.O_Dayname
		from sales s
			left join Date_info d
				on s.`Product ID`=d.`Product ID`
					where d.o_dayname is not null
						group by `Product Name`
							order by 4 desc;
                
#how many days it take for shipping according to state, city, region and category
	select s.State, s.City, s.Region, s.Sub_Category,  d.Shipping_Days
		from sales s
			inner join date_info d
				on s.`Product ID`= d.`Product ID`
					group by 2
						order by 5 desc;
                    
#what are the total, average, no. of sales sorted by max total sales
	select City, State, sum(product_sales) as Total_Sales, avg(product_sales) as Average_Sales, Count(`Product ID`) as No_of_Sales 
		from sales
			where profit >= 600
				group by city
					order by total_sales desc;
                
#Sales of customer who's name starts with "M" and "S" , grouped by city and sorted by sales from maximum to minimum              
	select `Customer Name`, City , Product_Sales, char_length(`Customer Name`) as Name_length
		from sales
			where `Customer Name` like 'M%' or `Customer Name` like 'S%'
				group by city
					order by product_sales desc;

#Taking all the values from sales and date_info table using Union all command
	select  s.Sub_category, s.`Product ID`, s.Product_Sales, d.O_Dayname, d.O_year
		from sales s
			left join date_info d
				on s.`Product ID`= d.`Product ID`
					group by 1
	union all   
	select  s.Sub_category, s.`Product ID`, s.Product_Sales, d.O_Dayname, d.O_year
		from sales s
			right join date_info d
				on s.`Product ID`= d.`Product ID`
					group by 1;
            
	select distinct `Product Name` from sales; 

#To check which type of shipping mode takes maximum and minimum time to ship orders
	select s.`Customer Name`, s.Order_date, s.`Ship Date`, s.`Ship Mode` , d.Shipping_Days
		from sales s	
			join  date_info d
				on s.`Product ID`= d.`Product ID`
					order by Shipping_Days desc;

#Which product sub_category is sold most in each month 
	select s.Sub_Category, sum(quantity) as Total_Quantity, max(product_sales) As Total_Sales,  d.O_Month as Month_no
		from sales s
			join date_info d
				on s.`Product ID`= d.`Product ID`
					group by O_Month;
					                   
#Which products in 'Los Angeles', 'Madison', 'Washington', 'Henderson'	are in loss		
	select `Customer Name`, City, Category, Profit
		from Sales
			where City in ('Los Angeles', 'Madison', 'Washington', 'Henderson')
				group by `Customer Name`
					order by profit ;

#Which Products don't give Discount at all			
	select `Product Name`, Sub_Category, Profit, Discount
		from sales
			where Discount= 0 
				order by Profit desc ;
        
        