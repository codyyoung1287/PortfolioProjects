-- Exploratory Data Analysis

Select *
FROM pbp2023_staging2;

-- Which teams lead the league in passing yards?

Select OffenseTeam, SUM(Yards)
FROM pbp2023_staging2 
WHERE IsPass = 1
Group By OffenseTeam 
order by 2 DESC;

-- Which teams lead the league in rushing yards
Select OffenseTeam, SUM(Yards)
FROM pbp2023_staging2 
WHERE IsRush = 1
Group By OffenseTeam 
order by 2 DESC;

-- Which team had the most turnovers
SELECT OffenseTeam, sum(IsInterception+IsFumble)
FROM pbp2023_staging2
group by OffenseTeam
Order By 2 DESC;

-- Which team got the most turnovers
SELECT DefenseTeam, sum(IsInterception+IsFumble)
FROM pbp2023_staging2
group by DefenseTeam
Order By 2 DESC;

-- Does scoring go up or down, as the regular season progresses

SELECT MONTH(`GameDate`), sum(IsTouchdown)
FROM pbp2023_staging2
WHERE MONTH(`GameDate`) IN (9, 10, 11, 12)
GROUP BY MONTH(`GameDate`)
ORDER BY 1; 

-- What was the average yards per play for the kansas city chiefs by month

Select MONTH(`GameDate`), avg(yards)
FROM pbp2023_staging2
WHERE OffenseTeam = 'KC'
GROUP BY MONTH(`GameDate`);

-- Rolling Sum of total touchdowns scored league wide increasing by each gameday.

WITH Rolling_Total AS
(
SELECT DISTINCT GameDate AS `GameDays`,
SUM(IsTouchdown) AS Total_Touchdowns
FROM pbp2023_staging2
GROUP BY `GameDays`
ORDER BY 1
)
SELECT `GameDays`, Total_Touchdowns,
SUM(Total_Touchdowns) OVER(ORDER BY `GameDays`) AS TotalTouchdowns
FROM Rolling_Total;




-- Ranking the top 3 offenses in yards by each league month (Steps Explained)

		-- First, Finding total yards per team for the year

SELECT OffenseTeam, SUM(yards)
FROM pbp2023_staging2
GROUP BY OffenseTeam 
ORDER BY 2 DESC; 

		-- Second, Finding total yards for each team per month
        
SELECT OffenseTeam, MONTH(`GameDate`), SUM(yards)
FROM pbp2023_staging2
GROUP BY OffenseTeam, MONTH(`GameDate`)
ORDER BY OffenseTeam ASC; 

		-- Create first CTE to show the total yardage for each team, for each month
WITH YardageRanking (OffenseTeam, month, yards) AS 
(
SELECT OffenseTeam, MONTH(`GameDate`), SUM(yards)
FROM pbp2023_staging2
GROUP BY OffenseTeam, MONTH(`GameDate`)
)
SELECT * FROM YardageRanking;

		-- Create Second CTE to assign a ranking for each team based on their monthly yardage totals, and finally filter for the top 3 teams for each month in terms of total yardage.

WITH YardageRanking (OffenseTeam, month, yards) AS 
(
SELECT OffenseTeam, MONTH(`GameDate`), SUM(yards)
FROM pbp2023_staging2
GROUP BY OffenseTeam, MONTH(`GameDate`)
), OffenseTeamMonthlyYardsRank AS
(SELECT *, DENSE_RANK() OVER(PARTITION BY MONTH ORDER BY Yards DESC) AS Ranking
FROM YardageRanking
)
SELECT * FROM OffenseTeamMonthlyYardsRank
WHERE Ranking <= 3
;





