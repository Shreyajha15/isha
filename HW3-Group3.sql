-- Find the bowlers who had a raw score of 155 or better at Thunderbird Lanes
-- combined with bowlers who had a raw score of 140 or better at Bolero Lanes.

-- Translation
-- SELECT BowlerFirstName, BowlerLastName, RawScore and TourneyLocation FROM teams T and Join bowlers B ON T.TeamID = B.TeamID
-- and JOIN bowler_scores BS ON B.BowlerID = BS.BowlerID and JOIN tourney_matches TM ON BS.MatchID = TM.MatchID
-- and JOIN tournaments TN ON TM.TourneyID = TN.TourneyID WHERE (RawScore >= 155 AND TourneyLocation = 'Thunderbird Lanes')
-- OR (RawScore >= 140 AND TourneyLocation = 'Bolero Lanes') and ORDER BY RawScore, BowlerFirstName, BowlerLastName

-- Clean Up
-- SELECT CONCAT(BowlerFirstName, " ", BowlerLastName), RawScore, TourneyLocation
-- FROM teams T JOIN bowlers B ON T.TeamID = B.TeamID
--  JOIN bowler_scores BS ON B.BowlerID = BS.BowlerID
--  JOIN tourney_matches TM ON BS.MatchID = TM.MatchID
--  JOIN tournaments TN ON TM.TourneyID = TN.TourneyID
-- WHERE (RawScore >= 155 AND TourneyLocation = 'Thunderbird Lanes')
-- OR (RawScore >= 140 AND TourneyLocation = 'Bolero Lanes') and then ORDER BY 3, 1, 2;

USE bowlingleagueexample;
SELECT CONCAT(BowlerFirstName, " ", BowlerLastName), RawScore, TourneyLocation
FROM teams T JOIN bowlers B ON T.TeamID = B.TeamID
 JOIN bowler_scores BS ON B.BowlerID = BS.BowlerID
 JOIN tourney_matches TM ON BS.MatchID = TM.MatchID
 JOIN tournaments TN ON TM.TourneyID = TN.TourneyID
WHERE (RawScore >= 155 AND TourneyLocation = 'Thunderbird Lanes')
OR (RawScore >= 140 AND TourneyLocation = 'Bolero Lanes')
ORDER BY 3, 1, 2;

-- Show me the vendors and the products they supply to us for products that cost less than $100

-- Translation
-- SELECT VendName, ProductName and RetailPrice
-- FROM vendors V and JOIN product_vendors PV ON V.VendorID = PV.VendorID
-- and JOIN products P ON PV.ProductNumber = P.ProductNumber
-- WHERE RetailPrice < 100 and then ORDER BY RetailPrice, VendName;

-- Clean Up
-- SELECT VendName, ProductName, RetailPrice
-- FROM vendors V JOIN product_vendors PV ON V.VendorID = PV.VendorID
-- JOIN products P ON PV.ProductNumber = P.ProductNumber
-- WHERE RetailPrice < 100
-- ORDER BY RetailPrice, VendName;

USE salesordersexample;
SELECT VendName, ProductName, RetailPrice
FROM vendors V JOIN product_vendors PV ON V.VendorID = PV.VendorID
JOIN products P ON PV.ProductNumber = P.ProductNumber
WHERE RetailPrice < 100
ORDER BY RetailPrice, VendName;

-- Find the agents and entertainers who live in the same postal code.

-- Translation
-- SELECT AgentID, CONCAT(AgtFirstName, " ", AgtLastName) AS 'Agent Name', EntertainerID, EntStageName and AgtZipCode
-- FROM agents A INNER JOIN entertainers E ON AgtZipCode = EntZipCode ORDER BY AgentID, EntertainerID

-- Clean Up
-- SELECT AgentID, CONCAT(AgtFirstName, " ", AgtLastName) AS 'Agent Name', EntertainerID, EntStageName, AgtZipCode
-- FROM agents A INNER JOIN entertainers E ON AgtZipCode = EntZipCode ORDER BY AgentID, EntertainerID;

USE entertainmentagencyexample;
SELECT AgentID, CONCAT(AgtFirstName, " ", AgtLastName) AS 'Agent Name', EntertainerID, EntStageName, AgtZipCode
FROM agents A INNER JOIN entertainers E ON AgtZipCode = EntZipCode ORDER BY AgentID, EntertainerID;

-- Display all recipe classes and any recipes that might be associated with them.

-- Translation
-- SELECT RC.RecipeClassID, RecipeClassDescription, RecipeID and RecipeTitle
-- FROM recipe_classes RC LEFT JOIN recipes R ON RC.RecipeClassID = R.RecipeClassID ORDER BY RC.RecipeClassID, RecipeID;

-- Clean Up
-- SELECT RC.RecipeClassID, RecipeClassDescription, RecipeID, RecipeTitle
-- FROM recipe_classes RC LEFT JOIN recipes R ON RC.RecipeClassID = R.RecipeClassID ORDER BY RC.RecipeClassID, RecipeID;

USE recipesexample;
SELECT RC.RecipeClassID, RecipeClassDescription, RecipeID, RecipeTitle
FROM recipe_classes RC LEFT JOIN recipes R ON RC.RecipeClassID = R.RecipeClassID ORDER BY RC.RecipeClassID, RecipeID;

-- What products have never been ordered?

-- Translation
-- SELECT P.ProductNumber, P.ProductName, P.ProductDescription and P.RetailPrice FROM products P WHERE P.ProductNumber is NOT IN 
-- 	(SELECT P.ProductNumber FROM products P INNER JOIN order_details OD ON P.ProductNumber = OD.ProductNumber);

-- Clean Up
-- SELECT P.ProductNumber, P.ProductName, P.ProductDescription, P.RetailPrice FROM products P WHERE P.ProductNumber NOT IN 
-- 	(SELECT P.ProductNumber FROM products P INNER JOIN order_details OD ON P.ProductNumber = OD.ProductNumber);

USE salesordersexample;
SELECT P.ProductNumber, P.ProductName, P.ProductDescription, P.RetailPrice
FROM products P
WHERE P.ProductNumber NOT IN 
	(SELECT P.ProductNumber
		FROM products P INNER JOIN order_details OD ON P.ProductNumber = OD.ProductNumber);

-- List the subjects taught on Wednesday.

-- Translation
-- SELECT DISTINCT C.SubjectID, SubjectName and WednesdaySchedule
-- FROM classes C LEFT JOIN subjects S ON C.SubjectID = S.SubjectID
-- WHERE WednesdaySchedule = 1 and then ORDER BY SubjectID;

-- Clean Up
-- SELECT DISTINCT C.SubjectID, SubjectName, WednesdaySchedule
-- FROM classes C LEFT JOIN subjects S ON C.SubjectID = S.SubjectID
-- WHERE WednesdaySchedule = 1 ORDER BY SubjectID;

USE schoolschedulingexample;
SELECT DISTINCT C.SubjectID, SubjectName, WednesdaySchedule
FROM classes C LEFT JOIN subjects S ON C.SubjectID = S.SubjectID
WHERE WednesdaySchedule = 1 ORDER BY SubjectID;

-- List all the bowlers who have a raw score that’s less than all of the other bowlers on the same team.
USE bowlingleagueexample;
SELECT DISTINCT BS.RawScore, B.TeamID, CONCAT(B.BowlerFirstName, " ", B.BowlerLastname) AS 'Bowler Name'
FROM bowler_scores BS JOIN bowlers B ON BS.BowlerID = B.BowlerID JOIN (SELECT min(BS.RawScore) AS 'MinRawScore', B.TeamID
FROM bowlers B JOIN bowler_scores BS ON B.BowlerID = BS.BowlerID GROUP BY TeamID) X ON B.TeamID = X.TeamID
WHERE BS.RawScore = MinRawScore ORDER BY 1, 2, 3;

-- List the ingredients that are used in some recipe where the measurement amount in the recipe
-- is not the default measurement amount
USE recipesexample;
SELECT I.IngredientName, R.RecipeTitle, I.MeasureAmountID AS "DefaultMeasurementAmount", RI.MeasureAmountID
FROM recipe_ingredients RI LEFT JOIN ingredients I ON RI.IngredientID = I.IngredientID JOIN recipes R ON RI.RecipeID = R.RecipeID
WHERE RI.MeasureAmountID != I.MeasureAmountID
ORDER BY 1,2;

-- Find the entertainers who played engagements for customers Berg or Hallmark

USE entertainmentagencyexample;
SELECT ENT.EntStageName, CONCAT(C.CustFirstName, " ", C.CustLastName)
FROM engagements E JOIN entertainers ENT ON E.EntertainerID = ENT.EntertainerID JOIN customers C ON E.CustomerID = C.CustomerID
WHERE C.CustFirstName REGEXP "^Berg|HallMark" OR C.CustLastName REGEXP "^Berg|HallMark" ORDER BY 1,2;