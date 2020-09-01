create database truYum;
use truYum;

create table Menu_Items(
ID int IDENTITY(1,1) primary key,
Name varchar(20),
Price decimal(8,2),
Active varchar(4),
Date_of_Launch date,
Category varchar(20),
Free_delivery varchar(5)
);
Create table users(
userid int IDENTITY(1,1) primary key,
userName varchar(20)
);
Create table cart(
cartid int IDENTITY(1,1) primary key,
userid int,
ID int,
constraint Fkey1 FOREIGN KEY (userid) REFERENCES users(userid),
constraint Fkey2 foreign key (ID) references menu_items(ID)
);
-- 1. TYUC001
insert into menu_items(Name,Price,Active,Date_of_launch,Category,Free_delivery)
values('Sandwich','99.00','Yes','2017-03-15','Main course','Yes'),
('Burger','129.00','Yes','2017-12-23','Main course','Yes'),
('Pizza','149.00','Yes','2017-08-21','Main course','No'),
('French Fries','57.00','No','2017-07-02','Starters','No'),
('Chocolate Brownie','32.00','Yes','2022-11-02','Dessert','Yes');
 
select Name,concat('Rs. ',Price) as 'Price',
Active,Date_of_Launch,Category,Free_Delivery from menu_items;


-- 2. TYUC002

select Name,concat('Rs. ',Price) as 'Price',
Category,Free_delivery from menu_items
where Active = 'Yes' and Date_of_launch <= GETDATE();
GO
-- 3. TYUC003
CREATE FUNCTION MenuItemsOnID(@ID int)
RETURNS TABLE AS RETURN
(SELECT * FROM Menu_Items where ID=@ID)
GO
--Suppose we wish to get menu items of ID=2
SELECT * FROM MenuItemsOnID(2)
GO

CREATE FUNCTION [dbo].[MenuId]
(
     @ID int
	
)
RETURNS INT
AS
BEGIN

    RETURN @ID 

END
GO
--Here we updated the columns of userId 2
delete from Menu_Items where ID=dbo.MenuId(2);
set identity_insert Menu_Items ON;
insert into Menu_Items(ID,Name,Price,Active,Date_of_launch,Category,Free_delivery) values (dbo.MenuId(2),'Burger','150.00','Yes','2017-12-23','Main course','Yes');
set identity_insert Menu_Items OFF;

-- 4. TYUC004
insert into users(userName)
values('Abhi'),
('Dev');
insert into cart(userid,ID) values(2,4),(2,1),(2,3);
GO

-- 5. TYUC005

CREATE FUNCTION [dbo].[GetUserId]
(
    @ID int
	
)
RETURNS INT
AS
BEGIN

    RETURN @ID 

END
GO
--We can change the userID in the below query to get the desired results
--Getting menu items of userID =2
 select Name,concat('Rs. ',Price) as 'Price',
 Category,Free_Delivery from menu_items m
 inner join cart c
 on m.ID = c.ID
 INNER JOIN users u
 on u.userid = c.userid
 where u.userid = dbo.GetUserId(2);
 
 --Getting total price of all menu items in userID=2
 select sum(Price) as Total_price
 from menu_items m 
 inner join cart c
 on m.ID = c.ID
 inner join users u
 on u.userid = c.userid
 where u.userid = dbo.GetUserId(2);
 GO
 
 -- 6.TYUC006

--We can change the userID in the below query to get the desired results
--Deleting from cart whose userID =2
 
 delete from cart 
where userid = dbo.GetUserId(2);
 

 
 
 


