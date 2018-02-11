CREATE TABLE Offers(
	Dday date,
	Offer varchar(255),
	UserID int,
	Rate float,
	Position int,
	Aaction varchar(255));

INSERT INTO Offers (Dday,Offer,UserID,Rate,Position,Aaction)
VALUES('2/2/2017','avant',1,0.05,1,'Install'),
('2/2/2017','avant',1,0.05,1,'Install'),
('2/2/2017','avant',1,0.12,3,'Install'),
('2/2/2017','avant',2,0.15,1,'Quit'),
('2/2/2017','avis',2,0.03,1,'Install'),
('2/2/2017','avis',3,0.05,1,'Install'),
('2/2/2017','avis',4,0.12,2,'Install'),
('2/2/2017','avis',5,0.15,2,'Install'),
('2/2/2017','avis',5,0.15,1,'Install'),
('3/2/2017','avant',3,0.03,1,'Install'),
('3/2/2017','avant',4,0.05,1,'Install'),
('3/2/2017','avant',5,0.12,2,'Install'),
('3/2/2017','avant',6,0.15,3,'Install'),
('3/2/2017','avant',7,0.03,1,'Install'),
('3/2/2017','avant',8,0.05,2,'Install'),
('3/2/2017','avant',9,0.12,3,'Install'),
('3/2/2017','avant',10,0.15,1,'Quit'),
('3/2/2017','avant',11,0.15,2,'Quit'),
('3/2/2017','avant',12,0.2,1,'Quit');


with cte (Dday,Offer,Rate,rnk)
AS (
	select Dday,Offer,Rate,
    	row_number( ) over (partition by Dday,Offer,UserID order by Position asc) as rnk
	from Offers
	where Aaction='Install'
)
select Dday,Offer,count(*) as Installs,sum(case when rnk>1 then 1 else 0 end) as duplicates,
sum(case when rnk>1 then Rate else 0 end) as revenue
from cte
group by Dday,Offer
