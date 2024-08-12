-- Data Cleaning/Specifying
SELECT * FROM pbp2023_staging;


SELECT *, Row_number() OVER(
PARTITION BY GameID, GameDate, Quarter, Minute, Second, OffenseTeam, DefenseTeam, Down, ToGo, YardLine, SeriesFirstdown, NextScore, Description, 
TeamWin, SeasonYear, Yards, Formation, PlayType, IsRush, IsPass, IsIncomplete, IsTouchdown, PassType, IsSack, IsChallenge, IsChallengeReversed, 
Challenger, IsMeasurement, IsInterception, IsFumble, 
IsPenalty, IsTwoPointConversion, IsTwoPointConversionSuccessful, RushDirection, YardLineFixed, 
YardLineDirection, IsPenaltyAccepted, PenaltyTeam, IsNoPlay, PenaltyType, PenaltyYards) 
AS Row_Num
FROM nflpbp.pbp2023_staging;

WITH DUPLICATE_CTE AS 
(
SELECT *, Row_number() OVER(
PARTITION BY GameID, GameDate, Quarter, Minute, Second, OffenseTeam, DefenseTeam, Down, ToGo, YardLine, SeriesFirstdown, NextScore, Description, 
TeamWin, SeasonYear, Yards, Formation, PlayType, IsRush, IsPass, IsIncomplete, IsTouchdown, PassType, IsSack, IsChallenge, IsChallengeReversed, 
Challenger, IsMeasurement, IsInterception, IsFumble, 
IsPenalty, IsTwoPointConversion, IsTwoPointConversionSuccessful, RushDirection, YardLineFixed, 
YardLineDirection, IsPenaltyAccepted, PenaltyTeam, IsNoPlay, PenaltyType, PenaltyYards)
AS Row_NUM
FROM nflpbp.pbp2023_staging
)
SELECT * FROM DUPLICATE_CTE
WHERE Row_Num > 1;


CREATE TABLE `pbp2023_staging2` (
  `GameId` int DEFAULT NULL,
  `GameDate` text,
  `Quarter` int DEFAULT NULL,
  `Minute` int DEFAULT NULL,
  `Second` int DEFAULT NULL,
  `OffenseTeam` text,
  `DefenseTeam` text,
  `Down` int DEFAULT NULL,
  `ToGo` int DEFAULT NULL,
  `YardLine` int DEFAULT NULL,
  `SeriesFirstDown` int DEFAULT NULL,
  `NextScore` int DEFAULT NULL,
  `Description` text,
  `TeamWin` int DEFAULT NULL,
  `SeasonYear` int DEFAULT NULL,
  `Yards` int DEFAULT NULL,
  `Formation` text,
  `PlayType` text,
  `IsRush` int DEFAULT NULL,
  `IsPass` int DEFAULT NULL,
  `IsIncomplete` int DEFAULT NULL,
  `IsTouchdown` int DEFAULT NULL,
  `PassType` text,
  `IsSack` int DEFAULT NULL,
  `IsChallenge` int DEFAULT NULL,
  `IsChallengeReversed` int DEFAULT NULL,
  `Challenger` text,
  `IsMeasurement` int DEFAULT NULL,
  `IsInterception` int DEFAULT NULL,
  `IsFumble` int DEFAULT NULL,
  `IsPenalty` int DEFAULT NULL,
  `IsTwoPointConversion` int DEFAULT NULL,
  `IsTwoPointConversionSuccessful` int DEFAULT NULL,
  `RushDirection` text,
  `YardLineFixed` int DEFAULT NULL,
  `YardLineDirection` text,
  `IsPenaltyAccepted` int DEFAULT NULL,
  `PenaltyTeam` text,
  `IsNoPlay` int DEFAULT NULL,
  `PenaltyType` text,
  `PenaltyYards` int DEFAULT NULL,
  `Row_Num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM pbp2023_staging2;

INSERT INTO pbp2023_staging2
SELECT *, Row_number() OVER(
PARTITION BY GameID, GameDate, Quarter, Minute, Second, OffenseTeam, DefenseTeam, Down, ToGo, YardLine, SeriesFirstdown, NextScore, Description, 
TeamWin, SeasonYear, Yards, Formation, PlayType, IsRush, IsPass, IsIncomplete, IsTouchdown, PassType, IsSack, IsChallenge, IsChallengeReversed, 
Challenger, IsMeasurement, IsInterception, IsFumble, 
IsPenalty, IsTwoPointConversion, IsTwoPointConversionSuccessful, RushDirection, YardLineFixed, 
YardLineDirection, IsPenaltyAccepted, PenaltyTeam, IsNoPlay, PenaltyType, PenaltyYards) 
AS Row_Num
FROM nflpbp.pbp2023_staging;

SELECT * FROM pbp2023_staging2
WHERE ROW_NUM > 1;

DELETE FROM pbp2023_staging2
WHERE ROW_NUM > 1




