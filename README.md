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
- [Data types in Fabric Data Warehouse](https://learn.microsoft.com/en-us/fabric/data-warehouse/data-types)
  
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
4. [Option 2](./Op2-Notebook-based.md): For those who prefer a code-first approach, this option uses Fabric notebooks to generate the date table and write it to a Lakehouse. It’s ideal for advanced logic and pipeline integration.
5. Option 3: A semantic model template that includes preconfigured hierarchies and measures. This is useful for teams looking to standardize reporting and accelerate development.

### Power BI Semantic Model Template (Option 3) 

`.PBIT`

1. Create the Date Table in Fabric Lakehouse/Warehouse: Leverage [Dataflow Gen2 with Power Query](./Op1-DataflowGen2.md) or use a [Fabric Notebook (PySpark or T-SQL)](./Op2-Notebook-based.md) to generate and save the date table in your Lakehouse.
2. Create a Power BI Report Connected to the Lakehouse:
    - Connect to your Fabric Lakehouse (use Direct Lake or DirectQuery mode).
    - Import the date table from the Lakehouse.
    - Load the table into your model.

        <img width="700" alt="image" src="https://github.com/user-attachments/assets/7f232b39-ce2b-49bf-a62c-a1b76c777de7">

        <img width="700" alt="image" src="https://github.com/user-attachments/assets/f0f9d806-f322-4418-a96c-752891c44ee8">

        <img width="700" alt="image" src="https://github.com/user-attachments/assets/55d71480-a334-43a1-8405-333009862ec8">

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
