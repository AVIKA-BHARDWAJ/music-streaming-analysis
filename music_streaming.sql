CREATE DATABASE music_streaming;
USE music_streaming;

DROP TABLE IF EXISTS Tracks;
CREATE TABLE Tracks (
  track_name VARCHAR(255),
  artist_name VARCHAR(255),
  artist_count INT,
  released_year INT,
  released_month INT,
  released_day INT,
  in_spotify_playlists INT,
  in_spotify_charts INT,
  streams BIGINT,
  in_apple_playlists INT,
  in_apple_charts INT,
  in_deezer_playlists INT,
  in_deezer_charts INT,
  in_shazam_charts INT,
  bpm VARCHAR(10),
  musical_key VARCHAR(5),
  mode VARCHAR(10),
  danceability_percent INT,
  valence_percent INT,
  energy_percent INT,
  acousticness_percent INT,
  instrumentalness_percent INT,
  liveness_percent INT,
  speechiness_percent INT
);


LOAD DATA LOCAL INFILE 'C:/Users/avika/Downloads/tracks.csv'
INTO TABLE Tracks
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

ALTER TABLE Tracks
MODIFY COLUMN in_shazam_charts INT NULL,
MODIFY COLUMN in_deezer_playlists INT NULL;

SELECT * FROM Tracks LIMIT 10;
DESCRIBE Tracks;

SELECT COUNT(*) AS total_rows FROM Tracks;
SELECT * FROM Tracks LIMIT 5;

-- Top 30 tracks by Spotify streams:
SELECT track_name, artist_name, streams
FROM Tracks
ORDER BY streams DESC
LIMIT 30;

-- Most frequently appearing artists:
SELECT artist_name, COUNT(*) AS track_count
FROM Tracks
GROUP BY artist_name
ORDER BY track_count DESC
LIMIT 20;

-- Average danceability, valence, and energy
SELECT 
  AVG(`danceability_percent`) AS avg_danceability,
  AVG(`valence_percent`) AS avg_valence,
  AVG(`energy_percent`) AS avg_energy
FROM Tracks;

-- Distribution of tracks by release year:
SELECT released_year, COUNT(*) AS count
FROM Tracks
GROUP BY released_year
ORDER BY released_year;

-- Tracks with high acousticness (>80%):
SELECT track_name, artist_name, `acousticness_percent`
FROM Tracks
WHERE `acousticness_percent` > 80
ORDER BY `acousticness_percent` DESC;
