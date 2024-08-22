-- Tạo cơ sở dữ liệu
CREATE DATABASE XgameBattle;


-- Sử dụng cơ sở dữ liệu vừa tạo
USE XgameBattle;


-- Tạo bảng PlayerTable
CREATE TABLE PlayerTable (
    PlayerId CHAR(36) PRIMARY KEY,
    PlayerName VARCHAR(100),
    PlayerNatinal VARCHAR(100)
);

-- Tạo bảng ItemTable
CREATE TABLE ItemTable (
    ItemId CHAR(36) PRIMARY KEY,
    ItemName VARCHAR(100),
    ItemTypeId CHAR(36),
    Price DECIMAL(10, 2)
);

-- Tạo bảng ItemTypeTable
CREATE TABLE ItemTypeTable (
    ItemTypeId CHAR(36) PRIMARY KEY,
    ItemTypeName VARCHAR(100)
);

-- Tạo bảng PlayerItem
CREATE TABLE PlayerItem (
    ItemId CHAR(36),
    PlayerId CHAR(36),
    FOREIGN KEY (ItemId) REFERENCES ItemTable(ItemId),
    FOREIGN KEY (PlayerId) REFERENCES PlayerTable(PlayerId)
);

-- Chèn dữ liệu vào bảng PlayerTable
INSERT INTO PlayerTable (PlayerId, PlayerName, PlayerNatinal)
VALUES 
('2C16E515-83AF-4D37-8A21-58AFD900E3F6', 'Player 1', 'Viet Nam'),
('D401EA60-7A83-4C7E-BF6E-707CF1F3E57E', 'Player 2', 'US');

-- Chèn dữ liệu vào bảng ItemTable
INSERT INTO ItemTable (ItemId, ItemName, ItemTypeId, Price)
VALUES 
('72B83972-051D-4B96-B229-05DE585DF1EE', 'Gun', '1', 5),
('83B931C2-AC84-4080-9852-5734C4E05082', 'Bullet', '1', 10),
('97E25C9F-FA12-4D9A-AB32-D62EBC2107BF', 'Shield', '2', 20);

-- Chèn dữ liệu vào bảng ItemTypeTable
INSERT INTO ItemTypeTable (ItemTypeId, ItemTypeName)
VALUES 
('1', 'Attack'),
('2', 'Defense');

-- Chèn dữ liệu vào bảng PlayerItem
INSERT INTO PlayerItem (ItemId, PlayerId)
VALUES 
('72B83972-051D-4B96-B229-05DE585DF1EE', '2C16E515-83AF-4D37-8A21-58AFD900E3F6'),
('83B931C2-AC84-4080-9852-5734C4E05082', '2C16E515-83AF-4D37-8A21-58AFD900E3F6'),
('97E25C9F-FA12-4D9A-AB32-D62EBC2107BF', '2C16E515-83AF-4D37-8A21-58AFD900E3F6');

DELIMITER $$

CREATE PROCEDURE GetMaxPriceForPlayer1()
BEGIN
    SELECT MAX(Price) AS MaxPrice
    FROM ItemTable IT
    JOIN PlayerItem PI ON IT.ItemId = PI.ItemId
    JOIN PlayerTable PT ON PI.PlayerId = PT.PlayerId
    WHERE PT.PlayerName = 'Player 1';
END //


DELIMITER $$

CREATE PROCEDURE GetPlayerItems()
BEGIN
    SELECT 
        PT.PlayerName,
        IT.ItemName,
        IType.ItemTypeName,
        IT.Price
    FROM 
        PlayerTable PT
    JOIN 
        PlayerItem PI ON PT.PlayerId = PI.PlayerId
    JOIN 
        ItemTable IT ON PI.ItemId = IT.ItemId
    JOIN 
        ItemTypeTable IType ON IT.ItemTypeId = IType.ItemTypeId
    ORDER BY 
        PT.PlayerName;
END 

