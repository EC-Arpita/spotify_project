--Q1: Find the top 3 most-viewed tracks for each artist using window functions.
select * from
 (select
    artist ,
    track ,
    sum(views) as total_views,
    dense_rank() over(partition by artist order by sum(views) desc) as rank
  from spotify 
  group by 1,2
  order by 1,3 desc
 ) as a 
   where rank <= 3 ;

--Q2: Write a query to find tracks where the liveness score is above the average.

select track from spotify
where liveness > (select avg(liveness) as avg_liveness from spotify)

--Q3: Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
WITH cte
AS
(SELECT 
	album,
	MAX(energy) as highest_energy,
	MIN(energy) as lowest_energery
FROM spotify
GROUP BY 1
)
SELECT 
	album,
	highest_energy - lowest_energery as energy_diff
FROM cte
ORDER BY 2 DESC ;

--Q4: Find tracks where the energy-to-liveness ratio is greater than 1.2.
with cte
as
(select 
  track,
  avg(energy) as avg_energy,
  avg(liveness) as avg_liveness 
  from spotify 
  group by 1) 
 select track from cte
 where avg_energy <> 0
   and
     (((avg_energy - avg_liveness )/avg_energy)* 100 ) > 1.2

--Q5: Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.
select track , 
sum(likes) over(order by views) as cum_sum
from spotify
order by views ; -- this will show cum_sum as 0 because views column had identical or non-varying values, 
--so the window function couldn’t "accumulate" properly.

-- therefore i use order by track to find cum_sum
 select 
  track,
  views,
  likes,
  sum(likes) over (order by track) as cum_sum
from spotify ;

 