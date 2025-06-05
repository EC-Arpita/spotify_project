--Q1: Retrieve the names of all tracks that have more than 1 billion streams.

select track from spotify
where stream > 1000000000 ;

--Q2: List all albums along with their respective artists.

select album , artist from spotify
order by 1 ;

--Q3: Get the total number of comments for tracks where licensed = TRUE.

select sum(comments) as total_no_comments 
from spotify 
where licensed = TRUE ;

--Q4: Find all tracks that belong to the album type single.

select track 
from spotify
where album_type = 'single' ;

--Q5: Count the total number of tracks by each artist.

select count(*) as total_tracks ,
artist from spotify
group by 2
order by 1 ;
