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
    StartDate = #date(2015, 1, 1),
    EndDate = #date(2030, 12, 31),
    FiscalYearStartMonth = 7, // July (change as needed)
    Holidays = {
        #date(2025, 1, 1),
        #date(2025, 12, 25)
    },
    DateList = List.Dates(StartDate, Duration.Days(EndDate - StartDate) + 1, #duration(1,0,0,0)),
    DateTable = Table.FromList(DateList, Splitter.SplitByNothing(), {"Date"}),
    AddYear = Table.AddColumn(DateTable, "Year", each Date.Year([Date])),
    AddMonth = Table.AddColumn(AddYear, "Month", each Date.Month([Date])),
    AddDay = Table.AddColumn(AddMonth, "Day", each Date.Day([Date])),
    AddQuarter = Table.AddColumn(AddDay, "Quarter", each Date.QuarterOfYear([Date])),
    AddISOWeek = Table.AddColumn(AddQuarter, "ISOWeek", each Date.WeekOfYear([Date], Day.Monday)),
    AddFiscalYear = Table.AddColumn(AddISOWeek, "FiscalYear", each if Date.Month([Date]) >= FiscalYearStartMonth then Date.Year([Date]) + 1 else Date.Year([Date])),
    AddFiscalQuarter = Table.AddColumn(AddFiscalYear, "FiscalQuarter", each Number.RoundUp(((Date.Month([Date]) - FiscalYearStartMonth + 12) mod 12 + 1) / 3)),
    AddFiscalMonth = Table.AddColumn(AddFiscalQuarter, "FiscalMonth", each ((Date.Month([Date]) - FiscalYearStartMonth + 12) mod 12) + 1),
    AddIsHoliday = Table.AddColumn(AddFiscalMonth, "IsHoliday", each List.Contains(Holidays, [Date])),
    AddDayOfWeek = Table.AddColumn(AddIsHoliday, "DayOfWeek", each Date.DayOfWeekName([Date])),
    AddIsWeekend = Table.AddColumn(AddDayOfWeek, "IsWeekend", each let d = Date.DayOfWeek([Date], Day.Monday) in d = 5 or d = 6)
in
    AddIsWeekend
