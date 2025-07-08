# Fabric Notebooks (Option 2)

Costa Rica

[![GitHub](https://badgen.net/badge/icon/github?icon=github&label)](https://github.com)
[![GitHub](https://img.shields.io/badge/--181717?logo=github&logoColor=ffffff)](https://github.com/)
[brown9804](https://github.com/brown9804)

Last updated: 2025-05-20

----------

> [!NOTE]
> Ensure that you have a warehouse or lakehouse available to store the data. If you have the necessary permissions, you can create one. Below is an example of how to create a lakehouse.

   https://github.com/user-attachments/assets/527c071a-2561-40b9-941e-3ca90ee8b9bd

> [!IMPORTANT]
> Currently, you cannot attach a Lakehouse to a Fabric notebook via code, it must be done manually through the Fabric UI. Microsoft Fabric requires a Lakehouse
> to be explicitly attached to the notebook session so that Spark knows where to read/write tables. This attachment is handled through the notebook interface,
> not through PySpark code or a Spark config. <br/>
> - Open your notebook in Fabric. <br/>
> - In the left-panel, click `Add data item`, and choose from the dropdown. <br/>
> - Select the Lakehouse you want to use (e.g., the one with your workspace ID). 

<img width="700" alt="image" src="https://github.com/user-attachments/assets/84172e09-3f10-44f9-a373-90ce2fa43f1d">

https://github.com/user-attachments/assets/5cf3883c-3785-473d-b9e9-c7378d1587a5

## PySpark approach 

1. Create a new notebook in your Fabric workspace (choose PySpark kernel).

    <img width="700" alt="image" src="https://github.com/user-attachments/assets/6d8393c7-b6c3-4ca9-80a0-56f3c7cbae0c">

    <img width="700" alt="image" src="https://github.com/user-attachments/assets/58aa7d27-05ea-4efc-966b-09453f8cd26d">

2. Paste the content of the cells as shown in this notebook, or [upload the notebook](./src/notebook-date-hierarchy-pyspark.ipynb)

    https://github.com/user-attachments/assets/09336541-224d-49da-b050-2beba2f225a9

3. Run all cells to generate and save the date table.

    https://github.com/user-attachments/assets/f9c9fee2-d9fc-492c-97f2-18f46a8b811e

    | Before | After | 
    | ---- | ---- | 
    | <img width="550" alt="image" src="https://github.com/user-attachments/assets/3c4c870e-8257-4d52-975c-7eb4d232bea6"> | <img width="550" alt="image" src="https://github.com/user-attachments/assets/d1ee0e91-87c1-47b9-921e-f2aedf719c7d"> | 

4. Schedule the notebook in a Data Pipeline for automation.
5. Connect your Power BI dataset or other Fabric workloads to the Lakehouse table.

## T-SQL approach 

1. Create a new notebook in Fabric (choose T-SQL kernel) or use a T-SQL script activity in a pipeline.
2. Paste, or [upload the notebook](./src/notebook-date-hierarchy-tsql.ipynb) and run the script
3. The table dbo.DateTable will be created in your Lakehouse or Warehouse.
4. Connect Power BI or other Fabric workloads to this table.


<div align="center">
  <h3 style="color: #4CAF50;">Total Visitors</h3>
  <img src="https://profile-counter.glitch.me/brown9804/count.svg" alt="Visitor Count" style="border: 2px solid #4CAF50; border-radius: 5px; padding: 5px;"/>
</div>
