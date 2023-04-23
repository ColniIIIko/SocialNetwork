SELECT Users1.name
	,Users2.name as [following]
FROM Users as Users1,
	Follows,
	Users as Users2
WHERE MATCH(Users1-(Follows)-> Users2)
ORDER BY Users1.name

SELECT Users1.name
	,COUNT(Users2.name) as [following count]
FROM Users as Users1,
	Follows,
	Users as Users2
WHERE MATCH(Users1-(Follows)->Users2)
GROUP BY Users1.name
ORDER BY Users1.name

SELECT Users2.name as [following]
	,Bands.name as band
FROM Users as Users1,
	Follows,
	Users as Users2,
	PlaysIn,
	Bands
WHERE MATCH(Users1-(Follows)->Users2-(PlaysIn)->Bands)
	AND Users1.email='jessica.taylor@example.com'


SELECT Users1.name as [user]
	,Bands.name as band
	,Universities.name as university
FROM Users as Users1,
	PlaysIn,
	Bands,
	BasedIn,
	Universities
WHERE MATCH(Users1-(PlaysIn)->Bands-(BasedIn)->Universities)
ORDER BY Users1.name

SELECT Users2.name as [Nirvana followers]
FROM Users as Users1,
	PlaysIn,
	Users as Users2,
	Bands,
	Follows
WHERE MATCH(Bands<-(PlaysIn)-Users1-(Follows)->Users2)
	AND Bands.name = 'Nirvana'


SELECT Users1.name AS name
	,STRING_AGG(Users2.name, '->') WITHIN GROUP (GRAPH PATH) AS following
FROM Users AS Users1,
	Follows FOR PATH AS fo,
	Users FOR PATH AS Users2
WHERE MATCH(SHORTEST_PATH(Users1(-(fo)->Users2)+))
AND Users1.email = 'jessica.taylor@example.com';

SELECT bands1.name AS name
	,STRING_AGG(bands2.name, '->') WITHIN GROUP (GRAPH PATH) AS following
FROM Users  FOR PATH AS Users1,
	PlaysIn FOR PATH AS [pi],
	PLaysIn FOR PATH as [pi2],
	Follows FOR PATH AS fo,
	Bands  AS bands1,
	Bands  FOR PATH AS bands2,
	Users  FOR PATH as Users2
WHERE MATCH(SHORTEST_PATH(bands1(<-([pi])-Users1-(fo)->Users2-([pi2])->bands2){1,10}))
AND bands1.name = 'Nirvana';