# Beschrijving

In dit project dienen jullie een databank te ontwerpen voor de opslag van data die afkomstig zijn van de sociaalnetwerksite Twitter.

Eerst en vooral moet de databank tweets (i.e. berichten) kunnen opslaan.
Tweets worden uniek geïdentificeerd door een id.
Daarnaast moet voor elke tweet de inhoud (zie verder voor meer informatie hieromtrent) worden bijgehouden, alsook het tijdstip waarop de tweet werd aangemaakt en (optioneel) de geografische locatie (in tekstueel formaat, bv. 'Gent') vanwaar de tweet werd verstuurd.
Een tweet wordt gepubliceerd door een bepaalde gebruiker.
Een dergelijke gebruiker wordt uniek geïdentificeerd door een gebruikersnaam.
Verder wordt voor een gebruiker mogelijks ook een tekstuele beschrijving en een geografische locatie (opnieuw in tekstueel formaat) opgeslagen.

Naast gewone tweets zijn er ook quotes die gepubliceerd kunnen worden door een gebruiker.
Een quote is een speciaal soort tweet (dus ook met een id, een inhoud, een tijdstip en, optioneel, een locatie) waarin verwezen wordt naar een _andere_ tweet (van dezelfde of een andere gebruiker).
Het tijdstip van een quote mag chronologisch niet voor het tijdstip van publicatie van de originele tweet liggen.

In de inhoud van een tweet (en quote) kunnen er twee verschillende types speciale tekst voorkomen die eenvoudig opgevraagd moeten kunnen worden uit de databank.
Eerst en vooral kan een tweet één of meerdere tags bevatten, die in de inhoud van een tweet voorafgegaan worden door een #-symbool.
Daarnaast kan een tweet ook mentions (vermeldingen van gebruikersnamen) bevatten, die op hun beurt in de inhoud van een tweet voorafgegaan worden door een @-symbool.
Voor elke tag (resp. mention), dient, per tweet, een uniek en oplopend volgnummer opgeslagen te worden in de databank, startend bij 1 en eindigend bij het totale aantal tags (resp. mentions) dat voorkomt in de tweet.
Om redundante data te vermijden is het namelijk zo dat, voor elke tweet, niet de volledige inhoud opgeslagen dient te worden, maar wel de verkorte inhoud.
Dit komt overeen met de volledige inhoud waarbij alle tags (van de vorm '#xxx...', met 'xxx...' een tag) vervangen worden door # en alle mentions (van de vorm '@xxx...', met 'xxx...' een bestaande gebruikersnaam) vervangen worden door @.
Het volgnummer van een tag (resp. mention) geeft dan aan welke tag (resp. gebruikersnaam) er in de verkorte inhoud ingevuld dient te worden om de volledige inhoud te bekomen (zie voorbeeld hieronder).
Je dient, voor de eenvoudigheid, niet te controleren of alle volgnummers voorkomen.
Ook dien je bij de eigenlijke opslag van tags en mentions het #-symbool (resp. @-symbool) niet expliciet op te slaan, enkel een link naar de tag (resp. gebruikersnaam) is voldoende.
Je mag veronderstellen dat de enige #-symbolen (resp. @-symbolen) die voorkomen in de inhoud van de tweet bedoeld zijn als placeholders voor tags (resp. mentions).

Tot slot kunnen gebruikers op nog twee manieren interageren met gepubliceerde tweets (van zichzelf of van een andere gebruiker).
Een eerste soort interactie is een retweet (i.e. een letterlijke herpublicatie) van een tweet, waarbij het tijdstip van de retweet opgeslagen dient te worden.
Opnieuw is het belangrijk dat dit tijdstip chronologisch niet voor het tijdstip van publicatie van de hergepubliceerde tweet ligt.
Een tweede soort interactie is een favorite (i.e. like) van een tweet.
Eenzelfde gebruiker kan eenzelfde tweet slechts eenmalig retweeten en liken.

### Voorbeeld

Veronderstel, als voorbeeld, de volgende tweet met id 1 en volledige inhoud

> Het #herexamen van @profDeTre was redelijk moeilijk in vergelijking met eerste zittijd.
    Gelukkig leverde het ontwerpproject van @deassistenten me genoeg punten op.
    #geslaagd

De verkorte (en gegeven) inhoud van deze tweet ziet er als volgt uit.

>  Het # van @ was redelijk moeilijk in vergelijking met eerste zittijd.
    Gelukkig leverde het ontwerpproject van @ me genoeg punten op.
    #


Door het opslaan van 'herexamen' (met volgnummer 1) en 'geslaagd' (met volgnummer 2) als hashtag en 'profDeTre' (met volgnummer 1) en 'deassistenten' (met volgnummer 2) als mentions, kan de volledige inhoud eenvoudig gereconstrueerd worden.

### Bijkomende info

Om de informatievergaring af te sluiten, willen we nog een aantal zaken duidelijk maken in verband met de operaties die uitgevoerd kunnen worden op de data.
Dit is een hulp bij het implementeren van de beperkingen later in dit project.
Ten eerste moet het ten allen tijde mogelijk zijn data toe te voegen.
Daarnaast is het ook mogelijk om alle data te verwijderen met de restrictie dat dit enkel en alleen kan als ze niet meer gebruikt worden elders in de databank.
Zo kan, bijvoorbeeld, een gebruiker enkel verwijderd worden indien deze niet meer in relatie staat met andere entiteiten (tweets, retweets...).
Tot slot is het in geen geval mogelijk om data die reeds in de databank zit aan te passen.
Met aanpassingen moet je dus in geen geval rekening houden.