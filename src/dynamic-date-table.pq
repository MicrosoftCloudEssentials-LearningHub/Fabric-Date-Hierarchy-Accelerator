// ---------------------------------------------
// Script Purpose: Generate an advanced dynamic date table in Power Query (M) for Power BI/Fabric models.
// Usage:
//   1. In Power BI, open Power Query Editor.
//   2. Paste or import this script into a new blank query.
//   3. Adjust parameters as needed (supports fiscal, ISO week, holidays).
// Customization:
// - Add/modify fiscal year start month, holiday logic, localization, or custom columns.
// Output:
// - Returns a table with columns for Date, Year, Month, Day, Quarter, FiscalYear, FiscalQuarter, ISOWeek, IsHoliday, etc.
// ---------------------------------------------

let
    // Define the start and end dates for the date table
    StartDate = #date(2015, 1, 1),
    EndDate = #date(2030, 12, 31),

    // Set the fiscal year start month (e.g., July = 7)
    FiscalYearStartMonth = 7,

    // Define a list of holidays (can be expanded or replaced with a parameter/table)
    Holidays = {
        #date(2025, 1, 1),
        #date(2025, 12, 25)
    },

    // Generate a list of dates between StartDate and EndDate
    DateList = List.Dates(StartDate, Duration.Days(EndDate - StartDate) + 1, #duration(1, 0, 0, 0)),

    // Convert the list into a table with a single column named "Date"
    DateTable = Table.FromList(DateList, Splitter.SplitByNothing(), {"Date"}),

    // Add standard calendar columns
    AddYear = Table.AddColumn(DateTable, "Year", each Date.Year([Date])),
    AddMonth = Table.AddColumn(AddYear, "Month", each Date.Month([Date])),
    AddDay = Table.AddColumn(AddMonth, "Day", each Date.Day([Date])),
    AddQuarter = Table.AddColumn(AddDay, "Quarter", each Date.QuarterOfYear([Date])),
    AddISOWeek = Table.AddColumn(AddQuarter, "ISOWeek", each Date.WeekOfYear([Date], Day.Monday)),

    // Add fiscal year column based on fiscal year start month
    AddFiscalYear = Table.AddColumn(AddISOWeek, "FiscalYear", each 
        if Date.Month([Date]) >= FiscalYearStartMonth 
        then Date.Year([Date]) + 1 
        else Date.Year([Date])
    ),

    // Add fiscal quarter using Number.Mod
    AddFiscalQuarter = Table.AddColumn(AddFiscalYear, "FiscalQuarter", each 
        Number.RoundUp((Number.Mod(Date.Month([Date]) - FiscalYearStartMonth + 12, 12) + 1) / 3)
    ),

    // Add fiscal month (1–12 relative to fiscal year start)
    AddFiscalMonth = Table.AddColumn(AddFiscalQuarter, "FiscalMonth", each 
        Number.Mod(Date.Month([Date]) - FiscalYearStartMonth + 12, 12) + 1
    ),

    // Add holiday flag
    AddIsHoliday = Table.AddColumn(AddFiscalMonth, "IsHoliday", each List.Contains(Holidays, [Date])),

    // Add day of week name (e.g., Monday, Tuesday)
    AddDayOfWeek = Table.AddColumn(AddIsHoliday, "DayOfWeek", each Date.DayOfWeekName([Date])),

    // Add weekend flag (Saturday = 6, Sunday = 0 when using Monday as start of week)
    AddIsWeekend = Table.AddColumn(AddDayOfWeek, "IsWeekend", each 
        let d = Date.DayOfWeek([Date], Day.Monday) 
        in d = 5 or d = 6
    ),

    // Explicitly set data types for all columns
    SetDataTypes = Table.TransformColumnTypes(AddIsWeekend, {
        {"Date", type date},
        {"Year", Int64.Type},
        {"Month", Int64.Type},
        {"Day", Int64.Type},
        {"Quarter", Int64.Type},
        {"ISOWeek", Int64.Type},
        {"FiscalYear", Int64.Type},
        {"FiscalQuarter", Int64.Type},
        {"FiscalMonth", Int64.Type},
        {"IsHoliday", type logical},
        {"DayOfWeek", type text},
        {"IsWeekend", type logical}
    })

in
    SetDataTypes
