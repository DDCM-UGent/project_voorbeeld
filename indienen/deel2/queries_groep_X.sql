select count(distinct gebruikersnaam) from gebruiker where locatie is not null and beschrijving is not null;

select count(distinct inhoud) from tag where tag.inhoud ilike 'b%';

select max(aantal) from (select count(gebruikersnaam) as aantal from likes group by id) as sq;

select count(distinct id) from tweet where char_length(inhoud) > 140;

select count(distinct id) from mention where nr > 3;

select count(*) from retweet join tweet t on retweet.id = t.id where retweet.tijdstip - t.tijdstip < interval '60 minutes';

select count(*) from quote where gequoot = 170454;