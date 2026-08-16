# My Data Notes 📝

Prior to the analysis, data cleaning and validation was performed to ensure consistency of data used for analysis. Please refer to the documentation below for detail on this step.

## 1. Creating the Dataset
ChatGPT was used to apply parameters for synthetic sales datasets that attempt to closely mirror what is observed in the HDD industry (e.g., Seagate Technologies, WD, etc). There were multiple iterations of the data files in order to customize the results and ensure specific columns were included for analysis. With consideration to all parameters requested, ChatGPT provided a Python code that was used to generate each of the CSV files.
- ```HDD_Orders:``` Record of 5,000 sales transactions with data include but are not limited to customer ID, product price, product ID, quantity, and transaction date
- ```Customer_Data:``` Record of 4,868 customers who have purchased HDD products including customer ID, customer segment, and street address
- ```HDD_Products:``` Record of 20 items used as an index for product information such as product ID, product name, product category,and color

## 2. Data Cleaning & Validation
Although ChatGPT was utilized to create the dataset, each dataset required additional cleaning and analysis in Excel to ensure consistency across all datasets. Refer to the [hdd_sales.xlsx](hdd_sales.xlsx) file to review the work performed.

- **Row count and reconciliation to MySQL import:** This step helped ensured completeness of the data during and after importing.
    - validation occurred in all tabs:*hdd_orders*, *customer_table*, *hdd_products* (refer to the bottom right corner of each tab for the reconciliation performed)

- **Customer Check:** *= XLOOKUP* used to ensure the information reported in columns ‘customer_id’ and ‘customer_segment*’* in the *hdd_orders* tab matches the data in *customer_table.* As a note, the information recorded in the *customer_table* tab was created as the source of truth.
    - validation occurred in *hdd_orders* tab, column Q-T

- **Price Validation:** *= INDEX(MATCH())* used to ensure the correct ‘unit_price’ was recorded in the *hdd_orders* tab and matched the *hdd_products* tab.
    - validation occurred in *hdd_orders* tab, column U-V

- **Final Sales Recorded:** *= price * quantity* used to ensure the multiplication was performed correctly, and ‘total_price’ column was recorded correctly in *hdd_orders* tab.
    - validation occurred in *hdd_orders* tab, column W-X

- **Customer Order Count:** *= COUNTA* & Pivot Table function to count how many times a customer made an order in FY24.
    - validation occurred in *customer_table* tab, columns D and F-G

- **Products Purchased:** *= XLOOKUP* used to search which products were purchased by customers and recorded in *hdd_orders.* As a note, the information recorded in the *hdd_products* tab was created as the source of truth.
    - validation occurred in *hdd_products* tab, column I

## 3. Import Data to MySQL Workbench
Each tab in the hdd_sales.xlsx file was saved as separate CSV files. In MySQL Workbench, the database and tables were created to import the respective CSV files. Refer to the code retained at [hdd_sales_data_MySQLCode.sql](hdd_sales_data_MySQLCode.sql).
- **Row Count:** This function is used to count the number of rows that were imported and manually reconciled to the raw data in Excel: 
  - *SELECT COUNT(*) AS total_rows FROM hdd_sales_data.customer_data;* 
  - *SELECT COUNT(*) AS total_rows FROM hdd_sales_data.hdd_orders;*
  - *SELECT COUNT(*) AS total_rows FROM hdd_sales_data.hdd_products;*
      
- **ER Diagram:** Created relationships between each table to show the connection, verify the correct data type classification is used for the respective columns, and determine the primary/foreign keys for each table prior to import to Tableau:

<br>

![image alt](https://github.com/vivianpham14/HDD-Sales-Trend-Projects/blob/04b45aa536b860baf62ca39ed099e5b053b122be/data%20files/ER_Diagram.png)

## 4. Analytics and Visualizations
A connection between MySQL Workbench and Tableau was needed to utilize Tableau for visualizations. Once installed, another step is performed to ensure each column has the right data type classification. The classification needs to be streamlined in every table in order to properly connect with at least one other table. 

<br>

![image alt](https://github.com/vivianpham14/HDD-Sales-Trend-Projects/blob/04b45aa536b860baf62ca39ed099e5b053b122be/data%20files/tableau_connection.png)
