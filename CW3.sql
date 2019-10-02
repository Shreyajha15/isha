-- Show me an alphabetical list of all the staff members and their salaries if they make between $40,000 and $50,000 a year

USE schoolschedulingexample;
SELECT StfLastName AS 'Last Name', StfFirstName AS 'First Name', Salary
FROM staff
WHERE Salary >= 40000 AND Salary <= 50000
ORDER BY StfLastName, StfFirstName ASC;

-- Show me a list of students whose last name is ‘Kennedy’ or who live in Seattle

USE schoolschedulingexample;
SELECT StudLastName AS 'Student Last Name', StudFirstName AS 'Student First Name', StudCity AS 'City'
FROM students
WHERE StudLastName LIKE 'kennedy' OR StudCity LIKE 'seattle'
ORDER BY StudLastName, StudFirstName ASC;

-- List the ID numbers of the teams that won one or more of the first ten matches in Game 3

USE bowlingleagueexample;
SELECT WinningTeamID AS 'Team ID', GameNumber, MatchID
FROM match_games
WHERE GameNumber = 3 AND MatchID <= 10;

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
SELECT c1.ClassID, subj1.SubjectName, s1.StfLastname, s1.StfFirstName, f1.Tenured
FROM classes c1, faculty f1, faculty_subjects fs1, staff s1, subjects subj1
WHERE f1.Tenured = 1 AND f1.StaffID = fs1.StaffID AND fs1.SubjectID = c1.SubjectID
 AND f1.StaffID = s1.StaffID AND fs1.SubjectID = subj1.SubjectID
ORDER BY subj1.SubjectName, s1.StfLastname, s1.StfFirstName;

-- Provide a list of all engagements along with the names of Agent and Entertainers who are from Seattle

USE entertainmentagencyexample;
SELECT e1.EngagementNumber, ent1.EntStageName, ent1.EntCity, a1.AgtLastName, a1.AgtFirstName, a1.AgtCity
FROM engagements e1, agents a1, entertainers ent1
WHERE (e1.AgentID = a1.AgentID AND a1.AgtCity LIKE 'seattle') AND (e1.EntertainerID = ent1.EntertainerID AND ent1.EntCity LIKE 'seattle')
ORDER BY ent1.EntStageName, a1.AgtLastName, a1.AgtFirstName;

-- Provide a list of recipes who have no eggs or meat in their ingredients

USE recipesexample;
SELECT * FROM ingredients;
SELECT r1.RecipeID, r1.RecipeTitle, i1.IngredientName
FROM recipes r1, ingredients i1, recipe_ingredients ri1
WHERE i1.IngredientClassID != 2 AND i1.IngredientID != 62 AND i1.IngredientID = ri1.IngredientID AND ri1.RecipeID = r1.RecipeID
ORDER BY r1.RecipeID;

-- Provide a list of teams along with the names of the team captains