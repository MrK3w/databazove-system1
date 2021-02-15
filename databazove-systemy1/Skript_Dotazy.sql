--SKUPINA 1
/*1;1;31;
Výpis všech záznamù tabulky Person seøazených podle Nicknamu.*/
SELECT *
FROM Person
ORDER BY Nickname

/*1;2;16;
Vypis vsech zaznamu tabulky splnenych achievmentu podle data*/
SELECT * 
FROM Completed_Achievments
ORDER BY DAY(Finished_Date) DESC
/*1;3;1;
Vypíše prùmìrny pocet achievmentu.*/
SELECT AVG(Amount_Of_Rewards) [Average of Achievments]
FROM Game

/*1;4;1;
Vypíše hru s nejmensim poctem achievmentu*/
SELECT MIN(Amount_Of_Rewards) [Lowest_Achievments]
FROM Game

--SKUPINA 2
/*2;1;3;
Vypis konzoli ktere jsou drazsi nez 500 a levnejsi nez 700, nebo byly vydane v roce 2020*/
SELECT Console,Price,Release_Year
FROM console
WHERE (price > 500 AND price < 700) OR Release_Year = 2020

/*2;2;6;
Vypis uzivatelu, kteri maji level vyssi nez 50 a zaroven se nejedna o zakladni uzivatele.*/
SELECT Nickname, Languages, Level, Type_Of_User
FROM person
WHERE level > 50 AND Type_Of_user NOT IN('User')

/*2;3;5;
Výpis hracu jejich login zacina na M*/
SELECT DISTINCT Login, Nickname, Languages, Level, Type_Of_User
FROM person
WHERE login LIKE 'M%'

/*2;4;3; 
Vypise RPG hry a jejich celkovy pocet bodu*/
SELECT Game.Name, sum(Amount_Of_Points) AS Total_Number_Of_Points
FROM Achievments
LEFT JOIN Game ON Achievments.Game_Game_ID = Game.Game_ID
Where Genre = 'RPG'
GROUP BY Game.Name

--SKUPINA 3
/*3;1;1;
Vypis vsech her ktere nemaji oceneni*/
select game_ID
FROM game
EXCEPT (SELECT Game_Game_ID from achievments)

/*3;2;1;
Vypis vsech her ktere nemaji oceneni*/
SELECT game_ID
FROM game 
WHERE NOT EXISTS (SELECT Game_Game_ID FROM achievments WHERE Game_Game_ID = Game_ID)

/*3;3;1;
Vypis vsech her ktere nemaji oceneni*/
SELECT game_ID
FROM game
WHERE game_ID != ALL (SELECT Game_Game_ID FROM achievments)

/*3;4;1;
Vypis vsech her ktere nemaji oceneni*/
SELECT game_ID
FROM Game 
WHERE game_ID NOT IN (SELECT Game_Game_ID FROM Achievments)

--SKUPINA 4
/*4;1;6; 
Vypise prumerny level podle narodnosti.*/
select Languages, AVG(level) AS Level
from person
GROUP BY Languages

/*4;2;13; 
Vypíše celkovy pocet bodu jednotlivych her.*/
SELECT Game.Name, sum(Amount_Of_Points) AS Total_Number_Of_Points
FROM Achievments
LEFT JOIN Game ON Achievments.Game_Game_ID = Game.Game_ID
GROUP BY Game.Name

/*4;3;12;
Spocita kolik clenu typu uzivatelu mluvi jakym jazykem */
select Type_Of_user, Languages, Count(Languages) as Language_Users
FROM Person
group by Type_Of_user,Languages
order by Type_Of_User

/*4;4;3; 
vypise uzivatele, kteri maji zapsany vice nez jeden achievment.*/
select Person_Person_ID,Person.Nickname, COUNT(Achievments_Achievments_ID) as Count_Of_Completed_Achivments
from Completed_Achievments
left join Person ON Completed_Achievments.Person_Person_ID = Person.Person_ID
group by Person_Person_ID,Person.Nickname
HAVING COUNT(Achievments_Achievments_ID) > 1

--SKUPINA 5
/*5;1;1;
Vypise uzivatele a jeho level ktery vlastni hru co zacina na Need*/
SELECT Nickname, level
FROM person
LEFT JOIN Person_Game PG ON person.Person_ID = PG.Person_Person_ID 
LEFT JOIN Game ON PG.Game_Game_ID = Game.Game_ID
where game.Name LIKE 'Need%'

/*5;2;1;
Vypise uzivatele a jeho level ktery vlastni hru co zacina na Need*/
SELECT Nickname,Level
FROM person
WHERE person.Person_ID IN
	(
		SELECT p.Person_Person_ID
		FROM Person_Game p
		WHERE p.Game_Game_ID IN
			(
				SELECT Game.Game_ID
				FROM Game 
				WHERE game.name LIKE 'Need%'
			)
	)

/*5;3;31;
Vypise Uzivatele a kolik konzoli maji*/
SELECT Person.Nickname, COUNT(Console_Console_ID) AS Amount_Of_Consoles
from Person_Console
RIGHT JOIN Person ON Person_Console.Person_Person_ID = Person.Person_ID
GROUP BY Person.Nickname
ORDER BY Amount_Of_Consoles DESC

/*5;4;2;
Vypise Uzivatele zacinajici na pismeno H a kolik konzoli maji*/
SELECT Person.Nickname, COUNT(Console_Console_ID) AS Amount_Of_Consoles
from Person_Console
RIGHT JOIN Person ON Person_Console.Person_Person_ID = Person.Person_ID
WHERE Nickname LIKE 'H%'
GROUP BY Person.Nickname
ORDER BY Amount_Of_Consoles DESC

--Skupina 6
/*6;1;31;
Vypis vsech hracu a pocet jejich her a pocet jejich konzoli*/SELECT nickname, level,(SELECT COUNT(Game_Game_ID)FROM Person_GameWHERE Person_game.Person_Person_ID = person.person_id) AS pocet_her,(SELECT COUNT(Console_Console_ID)FROM Person_ConsoleWHERE Person_Console.Person_Person_ID = person.person_id) AS pocet_konzolifrom personORDER BY pocet_her DESC/*6;2;31;
Vypis vsech hracu a pocet jejich splnenych achievmentu a pocet jejich konzoli*/
SELECT login, level,(SELECT COUNT(Finished_ID)FROM Completed_AchievmentsWHERE Completed_Achievments.Person_Person_ID = person.person_id) AS completed_achivments,(SELECT COUNT(Console_Console_ID)FROM Person_ConsoleWHERE Person_Console.Person_Person_ID = person.person_id) AS count_of_consolesfrom personORDER BY completed_achivments DESC

