-- Standardizing Data

SELECT `GameDate`, 
STR_To_Date(`GameDate`, '%Y-%m-%d')
FROM pbp2023_staging2;


UPDATE pbp2023_staging2
SET `GameDate` = STR_To_Date(`GameDate`, '%Y-%m-%d');

ALTER TABLE pbp2023_staging2
MODIFY `GameDate` DATE;

-- Address Null/Blank Values

SELECT * 
FROM pbp2023_staging2
WHERE PlayType = '';

UPDATE pbp2023_staging2
SET PlayType = NULL
WHERE PlayType = '';

INSERT INTO pbp2023_staging2 (PlayType) 
VALUES ('OfficialTimeout');

INSERT INTO pbp2023_staging2 (PlayType) 
VALUES ('EndOfQuarter');

INSERT INTO pbp2023_staging2 (PlayType) 
VALUES ('TwoMinuteWarning');

INSERT INTO pbp2023_staging2 (PlayType) 
VALUES ('ENDGAME');

INSERT INTO pbp2023_staging2 (PlayType) 
VALUES ('DirectSnap');

SELECT * 
FROM pbp2023_staging2
WHERE PlayType IS NULL;

UPDATE pbp2023_staging2
SET PlayType = 'EndOfQuarter'
WHERE PlayType IS NULL
AND DESCRIPTION LIKE '%End Quarter%';

UPDATE pbp2023_staging2
SET PlayType = 'OfficialTimeout'
WHERE PlayType IS NULL
AND DESCRIPTION LIKE '%TIMEOUT AT%';

UPDATE pbp2023_staging2
SET PlayType = 'TwoMinuteWarning'
WHERE PlayType IS NULL
AND DESCRIPTION LIKE '%TWO-MINUTE WARNING%';

UPDATE pbp2023_staging2
SET PlayType = 'ENDGAME'
WHERE PlayType IS NULL
AND DESCRIPTION LIKE '%END GAME%';

UPDATE pbp2023_staging2
SET PlayType = 'DirectSnap'
WHERE PlayType IS NULL
AND DESCRIPTION LIKE '%DIRECT SNAP%';

UPDATE pbp2023_staging2
SET PlayType = 'TIMEOUT'
WHERE PlayType IS NULL
AND DESCRIPTION = 'TIMEOUT.';

UPDATE pbp2023_staging2
SET Description = 'TIMEOUT'
WHERE DESCRIPTION = 'TIMEOUT.';

SELECT Formation, PlayType, Description
FROM pbp2023_staging2
WHERE Formation = '';

SELECT DISTINCT PlayType
FROM pbp2023_staging2
WHERE Formation = '';

SELECT *
FROM pbp2023_staging2
WHERE Formation = '';

INSERT INTO pbp2023_staging2 (Formation) 
VALUES ('NOPLAY');

UPDATE pbp2023_staging2
SET Formation = 'NOPLAY'
WHERE PlayType = 'EndOfQuarter';

UPDATE pbp2023_staging2
SET Formation = 'NOPLAY'
WHERE Formation = '';

SELECT * FROM pbp2023_staging2 
WHERE GameId IS NULL;

-- Remove Unneccesary Columns

DELETE
FROM pbp2023_staging2
WHERE GameId IS NULL;

ALTER TABLE pbp2023_staging2
DROP COLUMN Row_Num




