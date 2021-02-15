Create table Person
(
Person_ID int NOT NULL IDENTITY PRIMARY KEY,
Login VARCHAR(30) NOT NULL,
Password VARCHAR(255) NOT NULL,
Nickname VARCHAR(30) NOT NULL,
Languages VARCHAR(30) NOT NULL,
Level int NOT NULL
CONSTRAINT ch_review_Level
CHECK (Level BETWEEN 1 AND 99),
User_Description VARCHAR(255),
Creation_Date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
Type_Of_user varchar(10) NOT NULL CHECK (Type_Of_user IN('User', 'Verified', 'Admin')),
Rarest_Achievment varchar(30)
);

Create table Game
(
Game_ID int NOT NULL IDENTITY PRIMARY KEY,
Name VARCHAR(30) NOT NULL,
Genre VARCHAR(30) NOT NULL,
Score Int NOT NULL 
CONSTRAINT ch_review_Score
CHECK (Score > 0),
Description VARCHAR(30),
Amount_Of_Rewards Int NOT NULL
CONSTRAINT ch_review_rewards
CHECK (Amount_Of_Rewards > 0),
);

Create table Social
(
Social_ID int NOT NULL IDENTITY PRIMARY KEY,
Social_Sites VARCHAR(30),
Email VARCHAR(30) NOT NULL
CONSTRAINT ch_review_Email
CHECK (Email LIKE '%@%.%'),
Phone_Number int,
Person_Person_ID INT NOT NULL CONSTRAINT fk_Social_Person FOREIGN KEY REFERENCES Person(Person_ID)
);

Create table Person_Game
(
Game_Game_ID int NOT NULL CONSTRAINT fk_Person_Game_Game  FOREIGN KEY REFERENCES Game(Game_ID),
Person_Person_ID int NOT NULL CONSTRAINT fk_Person_Game_Person FOREIGN KEY REFERENCES Person(Person_ID),
PRIMARY KEY(Game_Game_ID,Person_Person_ID)
);

Create table Achievments
(
Achievments_ID int NOT NULL IDENTITY PRIMARY KEY,
Name VARCHAR(30) NOT NULL,
Amount_Of_Points INT NOT NULL
CONSTRAINT ch_amount_point CHECK (Amount_Of_Points IN(10, 20, 30,40)),
Decription VARCHAR(30) NOT NULL,
Game_Game_ID INT NOT NULL CONSTRAINT fk_Achievments_Game FOREIGN KEY REFERENCES Game(Game_ID)
);

Create table Hall
(
Hall_ID int NOT NULL IDENTITY PRIMARY KEY,
Position int NOT NULL,
Total_Achievments int NOT NULL,
Person_Person_ID INT NOT NULL CONSTRAINT fk_Hall_Person FOREIGN KEY REFERENCES Person(Person_ID)
);

Create table Console
(
Console_ID int NOT NULL IDENTITY PRIMARY KEY,
Console VARCHAR(30) NOT NULL,
Price int NOT NULL,
Global_sales int NOT NULL,
Release_Year INT NOT NULL,
);

Create table Person_Console
(
Console_Console_ID int NOT NULL CONSTRAINT fk_Person_Console_Console  FOREIGN KEY REFERENCES Console(Console_ID),
Person_Person_ID int NOT NULL CONSTRAINT fk_Person_Console_Person FOREIGN KEY REFERENCES Person(Person_ID),
PRIMARY KEY(Console_Console_ID,Person_Person_ID)
);

Create table Completed_Achievments
(
Finished_ID int  NOT NULL IDENTITY PRIMARY KEY,
Finished_Date date NOT NULL,
Person_Person_ID int NOT NULL CONSTRAINT fk_Person_Person FOREIGN KEY REFERENCES Person(Person_ID),
Achievments_Achievments_ID int NOT NULL CONSTRAINT fk_Person_Achivments FOREIGN KEY REFERENCES Achievments(Achievments_ID),
);

