-- Show me an alphabetical list of all the staff members and their salaries if they make between $40,000 and $50,000 a year

USE schoolschedulingexample;
SELECT StfLastName AS 'Last Name', StfFirstName AS 'First Name', Salary
FROM staff
WHERE Salary BETWEEN 40000 AND 50000
ORDER BY Salary, StfLastName, StfFirstName ASC;

-- Show me a list of students whose last name is ‘Kennedy’ or who live in Seattle

USE schoolschedulingexample;
SELECT StudLastName AS 'Student Last Name', StudFirstName AS 'Student First Name', StudCity AS 'City'
FROM students
WHERE StudLastName LIKE '%kennedy%' OR StudCity LIKE 'seattle'
ORDER BY StudLastName, StudFirstName ASC;

-- List the ID numbers of the teams that won one or more of the first ten matches in Game 3

USE bowlingleagueexample;
SELECT MatchID, GameNumber, WinningTeamID AS 'Team ID'
FROM match_games
WHERE GameNumber = 3
ORDER BY MatchID
LIMIT 10;

-- List the bowlers in teams 3, 4, and 5 whose last names begin with the letter ‘H’

USE bowlingleagueexample;
SELECT BowlerLastName AS 'Bowler Last Name', BowlerFirstName AS 'Bowler First name', TeamID
FROM bowlers
WHERE TeamID IN (3, 4, 5) AND BowlerLastName LIKE 'H%'
ORDER BY BowlerLastName, BowlerFirstName;

-- List the recipes that have no notes

USE recipesexample;
SELECT RecipeID, RecipeTitle, Notes
FROM recipes
WHERE Notes IS NULL OR Notes LIKE '';

-- Show the ingredients that are meats (ingredient class is 2) but that aren’t chicken

USE recipesexample;
SELECT * FROM ingredients ORDER BY IngredientClassID;
SELECT IngredientID, IngredientName, IngredientClassID
FROM ingredients
WHERE IngredientClassID = 2 AND IngredientName NOT LIKE '%chicken%';

-- Provide a list of classes along with the associated faculty for courses offered by tenured faculty

USE schoolschedulingexample;
SELECT DISTINCT subj1.SubjectCode, subj1.SubjectName, CONCAT(s1.StfFirstName, " ", s1.StfLastname)
FROM faculty f1 JOIN staff s1 ON f1.StaffID = s1.StaffID
	 JOIN faculty_classes fc1 ON f1.StaffID = fc1.StaffID
     JOIN classes c1 ON c1.ClassID = fc1.ClassID
	 JOIN subjects subj1 ON c1.SubjectID = subj1.SubjectID
WHERE Tenured = 1
ORDER BY 1, 3;

-- Provide a list of all engagements along with the names of Agent and Entertainers who are from Seattle

USE entertainmentagencyexample;
SELECT e1.EngagementNumber, ent1.EntStageName, ent1.EntCity, a1.AgtLastName, a1.AgtFirstName, a1.AgtCity
FROM engagements e1 JOIN agents a1 ON e1.AgentID = a1.AgentID
	JOIN entertainers ent1 ON e1.EntertainerID = ent1.EntertainerID
WHERE EntCity LIKE 'seattle'
ORDER BY ent1.EntStageName, a1.AgtLastName, a1.AgtFirstName;

-- Provide a list of recipes who have no eggs or meat in their ingredients

USE recipesexample;
SELECT r1.RecipeID, r1.RecipeTitle, i1.IngredientName
FROM recipes r1 JOIN recipe_ingredients ri1 ON ri1.RecipeID = r1.RecipeID
 JOIN ingredients i1 ON ri1.IngredientID = i1.IngredientID
 JOIN ingredient_classes ic1 ON i1.IngredientClassID = ic1.IngredientClassID
WHERE IngredientClassDescription <> 'meat'
 AND IngredientName NOT REGEXP '^*eggs*|bacon*|beef*|chicken*|pork*|steak*'
ORDER BY RecipeID;

-- Provide a list of teams along with the names of the team captains

USE bowlingleagueexample;
SELECT t1.TeamName, b1.BowlerLastName, b1.BowlerFirstName
FROM teams t1 JOIN bowlers b1 ON t1.CaptainID = b1.BowlerID
WHERE CaptainID = BowlerID;