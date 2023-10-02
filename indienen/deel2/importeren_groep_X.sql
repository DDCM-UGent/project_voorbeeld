insert into gebruiker
select distinct tweet_gebruikersnaam, gebruiker_beschrijving, gebruiker_locatie from super_tweets where tweet_gebruikersnaam is not null
union
select distinct mention_gebruikersnaam, mention_gebruiker_beschrijving, mention_gebruiker_locatie from super_tweets where mention_gebruikersnaam is not null
union
select distinct retweet_gebruikersnaam, retweet_gebruiker_beschrijving, retweet_gebruiker_locatie from super_tweets where retweet_gebruikersnaam is not null
union
select distinct favorite_gebruikersnaam, favorite_gebruiker_beschrijving, favorite_gebruiker_locatie from super_favorites where super_favorites.favorite_gebruikersnaam is not null;

insert into tweet
select distinct tweet_id::integer, tweet_tijdstip::timestamp, tweet_inhoud, tweet_locatie, tweet_gebruikersnaam from super_tweets where tweet_id is not null;

insert into quote
select distinct tweet_id::integer, quoted_tweet::integer from super_tweets where tweet_id is not null and quoted_tweet is not null;

insert into tag
select distinct tweet_id::integer, tag_volgnummer::integer, tag from super_tweets where tweet_id is not null and tag_volgnummer is not null;

insert into mention
select distinct tweet_id::integer, mention_volgnummer::integer, mention_gebruikersnaam from super_tweets where tweet_id is not null and mention_volgnummer is not null;

insert into retweet
select distinct tweet_id::integer, retweet_gebruikersnaam, retweet_tijdstip::timestamp from super_tweets where tweet_id is not null and retweet_gebruikersnaam is not null;

insert into likes
select distinct tweet_id::integer, favorite_gebruikersnaam from super_favorites where tweet_id is not null and favorite_gebruikersnaam is not null;