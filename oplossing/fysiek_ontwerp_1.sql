drop table if exists likes;
drop table if exists retweet;
drop table if exists mention;
drop table if exists tag;
drop table if exists quote;
drop table if exists tweet;
drop table if exists gebruiker;


create table gebruiker (
    gebruikersnaam varchar primary key,
    beschrijving varchar,
    locatie varchar
);

create table tweet (
    id integer primary key,
    tijdstip timestamp not null,
    inhoud varchar not null,
    locatie varchar,
    getweet varchar not null references gebruiker(gebruikersnaam)
);

create table quote (
    id integer primary key references tweet(id),
    gequoot integer not null references tweet(id)
);

create table tag (
    id integer references tweet(id),
    nr integer,
    inhoud varchar not null,
    primary key (id, nr)
);

create table mention (
    id integer references tweet(id),
    nr integer,
    gebruikersnaam varchar not null references gebruiker(gebruikersnaam),
    primary key (id, nr)
);

create table retweet (
    id integer references tweet(id),
    gebruikersnaam varchar references gebruiker(gebruikersnaam),
    tijdstip timestamp not null,
    primary key (id, gebruikersnaam)
);

create table likes (
    id integer references tweet(id),
    gebruikersnaam varchar references gebruiker(gebruikersnaam),
    primary key (id, gebruikersnaam)
);