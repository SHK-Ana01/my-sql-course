-- Football Match exercise

/*
The FootballMatch table shows the EPL matches played in 2024/25 season as of 16th March 2025
 
Important Columns
Date - Match Date (dd/mm/yy)
Time - Time of match kick off
HomeTeam- Home Team
AwayTeam - Away Team
FTHG -Full Time Home Team Goals
FTAG - Full Time Away Team Goals
FTR - Full Time Result (H=Home Win, D=Draw, A=Away Win)
 
Full details at https://zomalex.co.uk/datasets/football_match_dataset.html
*/

SELECT
    fm.Date
    
    ,fm.HomeTeam
    
    ,fm.AwayTeam
    
    ,fm.FTHG
    
    ,fm.FTAG
    
    ,fm.FTR
FROM
    FootballMatch fm

/*
How many games have been played?.  
- In total
- By each team
- By Month
*/

SELECT
    COUNT(*) AS NUMBERofMatches
FROM
    FootballMatch


SELECT
    DATENAME(Month,fm.[date]) AS MONTHName
,MONTH(fm.date) AS Monthnumber
,COUNT(*) AS Numberofmatches
FROM
    FootballMatch fm
GROUP BY Month(fm.date),  DATENAME(Month,fm.[date])

SELECT
    MONTH('2025-02-13') AS MONTH


SELECT
DATENAME(Year, fm.date) AS YEARName
    ,DATENAME(MONTH, fm.[Date]) AS MonthName
   
    ,MONTH(fm.Date) AS MonthNumber
    ,COUNT(*) AS  NumberOfMatches
FROM
    FootballMatch fm
GROUP BY
    MONTH(fm.Date)
    ,DATENAME(MONTH, fm.[Date])
, DATENAME(Year, fm.date)
ORDER BY
MonthNumber DESC
,Yearname DESC

SELECT
    fm.Date
    
    ,fm.HomeTeam
    
    ,fm.AwayTeam
    
    ,fm.FTHG
    
    ,fm.FTAG
    
    ,fm.FTR
FROM
    FootballMatch fm

;WITH  cte AS (
SELECT
    fm.HomeTeam AS Team
    , SUM(fm.FTHG) AS TotalGoals
FROM
    FootballMatch fm
group by
    fm.HomeTeam
UNION ALL
SELECT
    fm.AwayTeam
    , SUM(fm.FTAG)
FROM
    FootballMatch fm
group by
    fm.AwayTeam  
)
SELECT cte.Team, SUM(cte.TotalGoals) AS TotalGoals FROM cte GROUP BY cte.Team  ORDER BY sum(cte.TotalGoals) DESC

--temp table approach

DROP TABLE IF EXISTS #LeagueTable;
 
SELECT
    fm.HomeTeam as Team
    , SUM(fm.FTHG) AS GF
INTO #LeagueTable
FROM
    FootballMatch fm
group by fm.HomeTeam
UNION ALL
SELECT
    fm.AwayTeam
    , SUM(fm.FTAG)
FROM
    FootballMatch fm
group by fm.AwayTeam  
 
SELECT * FROM #LeagueTable;
 
SELECT t.Team As Team,
    SUM(T.GF) as GF
FROM #LeagueTable t
    group by t.Team
    order by t.Team
 
   
----------------
----------------

DROP TABLE IF EXISTS #LeagueTable;
 
SELECT
    fm.HomeTeam AS Team
    ,COUNT(*) as Played
    ,CASE fm.FTR WHEN 'H' THEN 1 ELSE 0 END AS Won
    ,SUM(fm.FTHG) AS GF
    ,SUM(fm.FTAG) AS GA
INTO #LeagueTable
    FROM FootballMatch fm
    GROUP BY fm.HomeTeam
UNION ALL
SELECT
        fm.AwayTeam 
       -- ,SUM(CASE fm. FTR WHEN 'A' THEN 1 ELSE 0 END) AS Won   
        ,COUNT(*) as Played
        ,SUM(fm.FTAG)
        ,SUM(fm.FTHG)
FROM  FootballMatch fm
GROUP BY fm.AwayTeam;
 
SELECT
    t.Team AS Team
    ,SUM(t.Played) AS Played
    ,SUM(T.GF) AS GF    
    ,SUM(T.GA) AS GA
FROM
    #LeagueTable t
GROUP BY t.Team
ORDER BY t.Team;
 
 -------------------------------------------------------------------------

 
DROP TABLE IF EXISTS #LeagueTable;
 
SELECT
    fm.HomeTeam AS Team
    ,CASE WHEN fm.FTR = 'H' THEN 1 ELSE 0 END AS Won
    ,CASE fm.FTR WHEN 'D'  THEN 1 ELSE 0 END AS Drawn
    ,fm.FTHG AS GF
    ,fm.FTAG AS GA
INTO #LeagueTable
    FROM FootballMatch fm
UNION ALL
SELECT
    fm.AwayTeam
    ,CASE WHEN fm.FTR = 'A' THEN 1 ELSE 0 END AS Won
    ,CASE fm.FTR WHEN 'D'  THEN 1 ELSE 0 END AS Drawn
    ,fm.FTAG
    ,fm.FTHG
FROM  FootballMatch fm
 
SELECT * FROM #LeagueTable;
 
SELECT
    t.Team AS Team
    ,count(*) AS Played
    ,SUM(t.Won) AS Won
    ,SUM(t.Drawn) AS Drawn
    ,SUM(T.GF) AS GF    
    ,SUM(T.GA) AS GA
FROM
    #LeagueTable t
GROUP BY t.Team
ORDER BY t.Team;
 
 
 



-- How many goals have been scored in total


 
-- How many goals have been scored by each team?
 

 