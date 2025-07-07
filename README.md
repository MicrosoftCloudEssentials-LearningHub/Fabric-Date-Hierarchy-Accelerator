# Fabric Date Hierarchy Accelerator

Costa Rica

[![GitHub](https://badgen.net/badge/icon/github?icon=github&label)](https://github.com)
[![GitHub](https://img.shields.io/badge/--181717?logo=github&logoColor=ffffff)](https://github.com/)
[brown9804](https://github.com/brown9804)

Last updated: 2025-05-20

----------

> `Power BI does not support built-in date hierarchies in DirectQuery or Direct Lake modes1`. This means the usual auto-generated hierarchy (Year > Quarter > Month > Day) won’t appear by default.
> Automating date hierarchies in Power BI and Microsoft Fabric eliminates repetitive manual work, ensures consistency, and accelerates report development. Leveraging Direct Lake improves report performance and enables real-time analytics. This `toolkit` provides scripts, templates, and configuration files to `standardize and automate hierarchy creation`, making it easier for teams to deliver high-quality, performant analytics solutions.

> [!IMPORTANT]
> Please note that `these demos are intended as a guide and are based on my personal experiences. For official guidance, support, or more detailed information, please refer to Microsoft's official documentation or contact Microsoft directly`: [Microsoft Sales and Support](https://support.microsoft.com/contactus?ContactUsExperienceEntryPointAssetId=S.HP.SMC-HOME)


<details>
<summary><b>List of References </b> (Click to expand)</summary>

- [Leveraging pure Direct Lake mode for maximum query performance](https://powerbi.microsoft.com/en-us/blog/leveraging-pure-direct-lake-mode-for-maximum-query-performance/)

</details>

<details>
<summary><b>Table of Contents</b> (Click to expand)</summary>

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



Option 1:
3. Generate a Dynamic Date Table: we can create a flexible, reusable date table in your Microsoft Fabric workspace that supports time intelligence in Power BI reports (like YTD, MTD, fiscal periods, etc.).


### Generate a Dynamic Date Table

> [!NOTE]
> The script is parameterized, meaning you can customize. You’ll usually see these as variables at the top of the script. Modify them as needed for your organization. <br/>
> - Start Date (e.g., 2020-01-01) <br/>
> - End Date (e.g., 2030-12-31) <br/>
> - Fiscal Year Start Month (e.g., 7 for July) <br/>
> - Holiday Table (optional: pass a list of dates to mark holidays)


1. Go to your workspace, or create a new workspace if needed.

    <img width="700" alt="image" src="https://github.com/user-attachments/assets/9bd461f2-b79a-4f50-af41-1a68adf57fa3">


2. Create a Dataflow Gen2: click `New` → `Dataflow Gen2`.

    <img width="700" alt="image" src="https://github.com/user-attachments/assets/9b6affbd-e25e-4326-805c-8666345de379"> 

3. Name the query (e.g., DateTable).

    <img width="700" alt="image" src="https://github.com/user-attachments/assets/69f3c18c-0aac-44f8-b66b-7ebeff62e8df">

4. Choose `Get data` → `Blank query`:

    <img width="700" alt="image" src="https://github.com/user-attachments/assets/b6a4b30b-c31d-4024-9f7c-cfcef31fba54">

5. Now you are able to see the Advanced Editor, paste the contents of [dynamic-date-table.pq](./src/dynamic-date-table.pq) into the editor, once the query is pasted, click `Next`.

    <img width="700" alt="image" src="https://github.com/user-attachments/assets/2868093b-bd54-4953-a28c-7c8f023e1a91">

    <img width="700" alt="image" src="https://github.com/user-attachments/assets/ec4cb48e-3eea-4ffc-bd47-a6e9995b689d">

6. Rename the query as desired, e.g something like DateTableQuery (use `right-click`).

    https://github.com/user-attachments/assets/111512e1-0c6c-493b-a9ad-205788a72146

> [!NOTE]
> Ensure that you have a warehouse or lakehouse available to store the data. If you have the necessary permissions, you can create one. Below is an example of how to create a lakehouse.

  https://github.com/user-attachments/assets/527c071a-2561-40b9-941e-3ca90ee8b9bd
  
7. Load it into, this makes the date table available for modeling and DAX calculations.
    - A Lakehouse (if using Data Engineering),
    - A Warehouse, or
    - A Power BI dataset (if using Power BI experience).

        <img width="700" alt="image" src="https://github.com/user-attachments/assets/a783661f-3cc1-4582-b211-27b14f1f3a96">


<div align="center">
  <h3 style="color: #4CAF50;">Total Visitors</h3>
  <img src="https://profile-counter.glitch.me/brown9804/count.svg" alt="Visitor Count" style="border: 2px solid #4CAF50; border-radius: 5px; padding: 5px;"/>
</div>
