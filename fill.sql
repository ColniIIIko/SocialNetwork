USE SocialNetwork;
GO

INSERT INTO Users (name, email)
VALUES
   ('Alice', 'alice@example.com'),
   ('Bob', 'bob@example.com'),
   ('Charlie', 'charlie@example.com'),
   ('Dave', 'dave@example.com'),
   ('Eve', 'eve@example.com'),
   ('Frank', 'frank@example.com'),
   ('Grace', 'grace@example.com'),
   ('Hank', 'hank@example.com'),
   ('Ivy', 'ivy@example.com'),
   ('John', 'john.doe@example.com'),
   ('Jane', 'jane.smith@example.com'),
   ('David', 'david.lee@example.com'),
   ('Emily', 'emily.wilson@example.com'),
   ('Mike', 'mike.brown@example.com'),
   ('Jessica', 'jessica.taylor@example.com'),
   ('Alex', 'alex.miller@example.com'),
   ('Megan', 'megan.davis@example.com'),
   ('Eric', 'eric.wilson@example.com'),
   ('Olivia', 'olivia.garcia@example.com'),
   ('Jack', 'jack.brown@example.com'),
   ('Isabella', 'isabella.thompson@example.com')


INSERT INTO Bands (name)
VALUES
   ('The Beatles'),
   ('Led Zeppelin'),
   ('Pink Floyd'),
   ('Queen'),
   ('The Rolling Stones'),
   ('AC/DC'),
   ('Metallica'),
   ('Nirvana'),
   ('Radiohead'),
   ('The Who')


INSERT INTO Universities (name, city)
VALUES
   ('Belarusian State University', 'Minsk'),
   ('Belarusian National Technical University', 'Minsk'),
   ('Belarusian State Medical University', 'Minsk'),
   ('Belarusian State University of Informatics and Radioelectronics', 'Minsk'),
   ('Belarusian State Academy of Arts', 'Minsk'),
   ('Vitebsk State University', 'Vitebsk'),
   ('Brest State Technical University', 'Brest'),
   ('Grodno State Agrarian University', 'Grodno'),
   ('Gomel State Medical University', 'Gomel'),
   ('Mogilev State University', 'Mogilev')



-- FOLOWS
DECLARE @i INT     = 1;
DECLARE @minId INT = 1;
DECLARE @maxId INT = (SELECT COUNT(*) FROM Users);
DECLARE @randId1 INT;
DECLARE @randId2 INT;

WHILE @i <= 50
BEGIN
	SET @randId1 = ROUND(RAND() * (@maxId - @minId), 0) + @minId;
	SET @randId2 = ROUND(RAND() * (@maxId - @minId), 0) + @minId;
	WHILE @randId1 = @randId2
	BEGIN
		SET @randId2 = ROUND(RAND() * (@maxId - @minId), 0) + @minId;
	END
	INSERT INTO Follows($from_id, $to_id)
	VALUES ((SELECT $node_id FROM Users WHERE id = @randId1),
			(SELECT $node_id FROM Users WHERE id = @randId2))
	SET @i += 1;
END

SELECT *
FROM Follows


-- BASED IN
DECLARE @current INT = 1;
DECLARE @start INT	 = 1;
DECLARE @end INT	 = (SELECT COUNT(*) FROM Bands)
DECLARE @min INT     = 1;
DECLARE @max INT     = (SELECT COUNT(*) FROM Universities);
DECLARE @minYear INT = 1990;
DECLARE @maxYear INT = 2005;
DECLARE @randId INT;
DECLARE @randYear INT;

WHILE @current <= @end
BEGIN
	SET @randId = ROUND(RAND() * (@max - @min), 0) + @min;
	SET @randYear = ROUND(RAND() * (@maxYear - @minYear), 0) + @minYear;
	INSERT INTO BasedIn($from_id, $to_id, year)
	VALUES ((SELECT $node_id FROM Bands WHERE id = @current),
			(SELECT $node_id FROM Universities WHERE id = @randId),
			@randYear)
	SET @current += 1;
END

-- PLAYS IN
DECLARE @current INT = 1;
DECLARE @start INT	 = 1;
DECLARE @end INT	 = (SELECT COUNT(*) FROM Users)
DECLARE @min INT     = 1;
DECLARE @max INT     = (SELECT COUNT(*) FROM Bands);
DECLARE @minYear INT = 1990;
DECLARE @maxYear INT = 2005;
DECLARE @randId INT;
DECLARE @randYear INT;

WHILE @current <= @end
BEGIN
	SET @randId = ROUND(RAND() * (@max - @min), 0) + @min;
	INSERT INTO PlaysIn($from_id, $to_id)
	VALUES ((SELECT $node_id FROM Users WHERE id = @current),
			(SELECT $node_id FROM Bands WHERE id = @randId))
	SET @current += 1;
END

TRUNCATE TABLE PlaysIn

SELECT *
FROM Bands


SELECT @@SERVERNAME