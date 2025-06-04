--Q1: Calculate the average danceability of tracks in each album.
 select avg(danceability) as avg_danceability , album from spotify
 group by album ;

 --Q2: Find the top 5 tracks with the highest energy values.
select track , max(energy) from spotify
group by 1
order by 2 desc limit 5 ;

--Q3: List all tracks along with their views and likes where official_video = TRUE.
select track , sum(likes) as total_likes ,
sum(views) as total_views from spotify
where official_video = TRUE
group by 1;

--Q4: For each album, calculate the total views of all associated tracks.
select album , track ,
sum(views) as total_views from spotify
group by 1 , 2;


--Q5: Retrieve the track names that have been streamed on Spotify more than YouTube.
 select * from
 ( select
    track , 
  COALESCE(sum(case when most_played_on = 'Youtube' then stream end),0) as streamed_on_youtube,
  COALESCE(sum(case when most_played_on = 'Spotify' then stream end),0) as streamed_on_spotify
  from spotify
  group by 1
 ) as a
 where 
  streamed_on_spotify > streamed_on_youtube
  and 
   streamed_on_youtube <> 0 ;
