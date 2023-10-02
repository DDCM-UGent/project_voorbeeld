# Logisch ontwerp

* **gebruiker** (gebruikersnaam: varchar, beschrijving: varchar, locatie: varchar)
  * primaire sleutel {gebruikersnaam}

* **tweet** (id: integer, tijdstip: timestamp, inhoud: varchar, locatie: varchar, getweet: varchar)
  * primaire sleutel {id}
  * vreemde sleutel: getweet -> gebruiker{gebruikersnaam}
  * not null: tijdstip, inhoud, getweet

* **quote** (id: integer, gequoot: integer)
  * primaire sleutel: {id}
  * vreemde sleutels: id -> tweet{id}, gequoot -> tweet{id}
  * not null: gequoot
  * check: id $\neq$ gequoot
  * controleer bij toevoeging of het tijdstip van de tweet met id = id na het tijdstip van de tweet met id = qequoot ligt

* **tag** (id: integer, nr: integer, inhoud: varchar)
  * primaire sleutel: {id, nr}
  * vreemde sleutel: id -> tweet{id}
  * not null: inhoud
  * check: nr $\geq$ 1
  * controleer bij toevoeging of nr kleiner of gelijk is aan het aantal hashtags dat voorkomt in de inhoud van de tweet met id = id

* **mention** (id: integer, nr: integer, gebruikersnaam: varchar)
  * primaire sleutel: {id, nr}
  * vreemde sleutels: id -> tweet{id}, gebruikersnaam -> gebruiker{gebruikersnaam}
  * not null: gebruikersnaam
  * check: nr $\geq$ 1
  * controleer bij toevoeging of nr kleiner dan of gelijk is aan het aantal @-symbolen dat voorkomt in de inhoud van de tweet met id = id

* **retweet** (id: integer, gebruikersnaam: varcharn tijdstip: timestamp)
  * primaire sleutel: {id, gebruikersnaam}
  * vreemde sleutels: id -> tweet{id}, gebruikersnaam -> gebruiker{gebruikersnaam}
  * not null: tijdstip
  * controleer bij toevoeging of het tijdstip na het tijdstip van de tweet met id = id ligt

* **likes** (id: integer, gebruikersnaam: varchar)
  * primaire sleutel: {id, gebruikersnaam}
  * vreemde sleutels: id -> tweet{id}, gebruikersnaam -> gebruiker{gebruikersnaam}