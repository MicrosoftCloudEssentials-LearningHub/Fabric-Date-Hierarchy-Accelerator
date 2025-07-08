# Fabric Date Hierarchy Accelerator

Costa Rica

[![GitHub](https://badgen.net/badge/icon/github?icon=github&label)](https://github.com)
[![GitHub](https://img.shields.io/badge/--181717?logo=github&logoColor=ffffff)](https://github.com/)
[brown9804](https://github.com/brown9804)

Last updated: 2025-05-20

----------

> `Power BI currently does not support built-in date hierarchies in DirectQuery or Direct Lake modes1`. This means the usual auto-generated hierarchy (Year > Quarter > Month > Day) won’t appear by default.
> Automating date hierarchies in Power BI and Microsoft Fabric eliminates repetitive manual work, ensures consistency, and accelerates report development. Leveraging Direct Lake improves report performance and enables real-time analytics. This `toolkit` provides scripts, templates, and configuration files to `standardize and automate hierarchy creation`, making it easier for teams to deliver high-quality, performant analytics solutions.

> [!IMPORTANT]
> Please note that `these demos are intended as a guide and are based on my personal experiences. For official guidance, support, or more detailed information, please refer to Microsoft's official documentation or contact Microsoft directly`: [Microsoft Sales and Support](https://support.microsoft.com/contactus?ContactUsExperienceEntryPointAssetId=S.HP.SMC-HOME)

<details>
<summary><b>List of References </b> (Click to expand)</summary>

- [Leveraging pure Direct Lake mode for maximum query performance](https://powerbi.microsoft.com/en-us/blog/leveraging-pure-direct-lake-mode-for-maximum-query-performance/)
- [Dataflow Gen2 data destinations and managed settings](https://learn.microsoft.com/en-us/fabric/data-factory/dataflow-gen2-data-destinations-and-managed-settings)
- [Notebook source control and deployment](https://learn.microsoft.com/en-us/fabric/data-engineering/notebook-source-control-deployment)
  
</details>

<details>
<summary><b>Table of Contents</b> (Click to expand)</summary>

- [Prerequisites](#prerequisites)
- [Automation Walkthrough](#automation-walkthrough)
- [Best Practices](#best-practices) 

</details>

## Prerequisites

> Depending on the approach you take, you may use some, all, or none of these prerequisites.

- [Power BI Desktop](https://powerbi.microsoft.com/)
- [Node.js](https://nodejs.org/) (for running review scripts)
- [Git](https://git-scm.com/) (for cloning the repository)
- Install Chocolatey (One-Time Setup)
  1. **Open PowerShell as Administrator**
  2. Run this command:

     ```powershell
     Set-ExecutionPolicy Bypass -Scope Process -Force; `
     [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
     iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
     ```

  3. After installation, restart your terminal and run:
     ```powershell
     choco install make
     ```

        https://github.com/user-attachments/assets/52536caf-36c2-4b1e-a42b-e64e3d6b403a

## Automation Walkthrough

1. Prepare Your Workspace: Install [prerequisites](#prerequisites), and clone this repository.
2. Ensure you have access to your [Microsoft Fabric workspace](https://app.fabric.microsoft.com/).
3. [Option 1](./Op1-DataflowGen2.md): A parameterized Power Query script that generates a `reusable date table`. It supports fiscal logic, holidays, and time intelligence (YTD, MTD, etc.), and stores the result in a Lakehouse for Direct Lake consumption.
4. Option 2: For those who prefer a code-first approach, this option uses Fabric notebooks to generate the date table and write it to a Lakehouse. It’s ideal for advanced logic and pipeline integration.
5. Option 3: A semantic model template that includes preconfigured hierarchies and measures. This is useful for teams looking to standardize reporting and accelerate development.

### Fabric Notebooks (Option 2)

`PySpark`

1. Create a new notebook in your Fabric workspace (choose PySpark kernel).

    <img width="700" alt="image" src="https://github.com/user-attachments/assets/6d8393c7-b6c3-4ca9-80a0-56f3c7cbae0c">

    <img width="700" alt="image" src="https://github.com/user-attachments/assets/58aa7d27-05ea-4efc-966b-09453f8cd26d">

2. Paste the content of the cells as shown in this notebook, or upload the notebook.

    https://github.com/user-attachments/assets/09336541-224d-49da-b050-2beba2f225a9

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

3. Run all cells to generate and save the date table.

    https://github.com/user-attachments/assets/f9c9fee2-d9fc-492c-97f2-18f46a8b811e

    | Before | After | 
    | ---- | ---- | 
    | <img width="550" alt="image" src="https://github.com/user-attachments/assets/3c4c870e-8257-4d52-975c-7eb4d232bea6"> | <img width="550" alt="image" src="https://github.com/user-attachments/assets/d1ee0e91-87c1-47b9-921e-f2aedf719c7d"> | 

4. Schedule the notebook in a Data Pipeline for automation.
5. Connect your Power BI dataset or other Fabric workloads to the Lakehouse table.

`or T-SQL`

1. Create a new notebook in Fabric (choose T-SQL kernel) or use a T-SQL script activity in a pipeline.
2. Paste and run the script.
3. The table dbo.DateTable will be created in your Lakehouse or Warehouse.
4. Connect Power BI or other Fabric workloads to this table.

### Power BI Semantic Model Template (Option 3) 

`.PBIT`

1. Create the Date Table in Fabric Lakehouse: Use a Fabric Notebook (PySpark or T-SQL, as above) to generate and save the date table in your Lakehouse.
2. Create a Power BI Report Connected to the Lakehouse:
    - Connect to your Fabric Lakehouse (use Direct Lake or DirectQuery mode).
    - Import the date table from the Lakehouse.
    - Load the table into your model.
3. Add Prebuilt Hierarchies and Measures
    - In the Power BI model, create date hierarchies (e.g., Year > Quarter > Month > Day, Fiscal, ISO Week).
    - Add DAX measures for YTD, MTD, QTD, Prior Year, Holidays, etc. (reuse from your advanced-dax-measures.txt).
4. Save as a Power BI Template (.PBIT)
    - Go to File > Export > Power BI template (.pbit).
    - This template will include the model structure, hierarchies, and measures, but not the data.
5. Version Control and CI/CD
    - Store the .pbit file in your GitHub or Azure DevOps repository.
    - Use deployment pipelines in Fabric or Power BI Service to automate deployment of the template to workspaces.
6. Report Creation: Users can create new reports by opening the .pbit template, ensuring all reports use the standardized date table, hierarchies, and measures.

## Best Practices

- Version Control: If you are using a notebook, connect your Fabric workspace to GitHub or Azure DevOps to enable version control for the notebook.
- Schedule/Automate: Use Fabric Data Pipelines to schedule the notebook execution (e.g., daily, weekly).
- Consume in Power BI or Other Fabric Workloads: Use the generated Lakehouse table as a source in Power BI datasets, Data Warehouses, or other Fabric experiences.
- CI/CD Integration: Use Fabric’s Git integration for code review, pull requests, and automated deployment.


<div align="center">
  <h3 style="color: #4CAF50;">Total Visitors</h3>
  <img src="https://profile-counter.glitch.me/brown9804/count.svg" alt="Visitor Count" style="border: 2px solid #4CAF50; border-radius: 5px; padding: 5px;"/>
</div>
