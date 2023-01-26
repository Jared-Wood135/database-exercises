SHOW DATABASES;
USE albums_db;
DESCRIBE albums;
SELECT * FROM albums;
SELECT DISTINCT id, artist FROM albums;
SELECT min(release_date) FROM albums;
SELECT max(release_date) FROM albums;
SELECT name FROM albums WHERE artist='Pink Floyd';
SELECT genre FROM albums WHERE name='Nevermind';
SELECT name FROM albums WHERE release_date BETWEEN 1990 and 2000;
SELECT name FROM albums WHERE sales < 20;
SELECT name FROM albums WHERE genre LIKE 'Rock';


/* BEGIN Q & A:
Q: 3a. How many rows are in the albums table?
A: 31
Q: 3b. How many unique artist names are in the albums table?
A: 31
Q: 3c. What is the primary key for the albums table?
A: albums
Q: 3d. What is the oldest release date for any album in the albums table? What is the most recent release date?
A: Oldest: 1967 // Newest: 2011
Q: 4a. The name of all albums by Pink Floyd
A: "The Dark Side of the Moon" and "The Wall"
Q: 4b. The year Sgt. Pepper's Lonely Hearts Club Band was released
A: 1967
Q: 4c. The genre for the album Nevermind
A: "Grunge, Alternative rock"
Q: 4d. Which albums were released in the 1990s
A: "1", "Come On Over", "Dangerous", "Falling into You", "Jagged Little Pill", "Let's Talk About Love", "Metallica", "Nevermind", "Supernatural", "The Bodyguard", "The Immaculate Collection", "Titanic: Music from the Motion Picture"
Q: 4e. Which albums had less than 20 million certified sales
A: "Abbey Road", "Bad", "Born in the U.S.A.", "Brothers in Arms", "Dangerous", "Dirty Dancing", "Grease: The Original Soundtrach from the Motion Picture", "Let's Talk About Love", "Nevermind", "Sgt. Pepper's Lonely Hearts Club Band", "The Immaculate Collection", "The Wall", "Titanic: Music from the Motion Picture"
Q: 4f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
A: "1", "Abbey Road", "Born in the U.S.A.", "Sgt. Pepper's Lonely Hearts Club Band", "Supernatural".  It does not include albums with "Hard rock" or "Progressive rock" because the query was specifically searching for "Rock".