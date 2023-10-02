alter table quote drop constraint if exists check_quote_id;
alter table tag drop constraint if exists check_tag_nr;
alter table mention drop constraint if exists check_mention_nr;

drop trigger if exists controleer_nr_mention_trigger on mention;
drop trigger if exists controleer_nr_tag_trigger on tag;
drop trigger if exists controleer_tijdstip_quote_trigger on quote;
drop trigger if exists controleer_tijdstip_retweet_trigger on retweet;

drop function if exists controleer_nr_mention();
drop function if exists controleer_nr_tag();
drop function if exists controleer_tijdstip_quote();
drop function if exists controleer_tijdstip_retweet();

alter table quote add constraint check_quote_id check (id <> quote.gequoot);
alter table tag add constraint check_tag_nr check (nr >= 1);
alter table mention add constraint check_mention_nr check (nr >= 1);

create function controleer_nr_mention() returns trigger as $$
    declare
        aantal_mentions integer;
    begin
        select array_length(string_to_array(inhoud, '@'), 1) - 1 into aantal_mentions from tweet where id = new.id;

        if (new.nr > aantal_mentions) then
            raise exception 'aantal @-symbolen % is kleiner dan huidig volgnummer %.', aantal_mentions, new.nr;
        end if;

        return new;

    end;
$$ language plpgsql;

create trigger controleer_nr_mention_trigger before insert on mention for each row execute function controleer_nr_mention();

create function controleer_nr_tag() returns trigger as $$
    declare
        aantal_tags integer;
    begin
        select array_length(string_to_array(inhoud, '#'), 1) - 1 into aantal_tags from tweet where id = new.id;

        if (new.nr > aantal_tags) then
            raise exception 'aantal #-symbolen % is kleiner dan huidig volgnummer %.', aantal_tags, new.nr;
        end if;

        return new;
    end;
$$ language plpgsql;

create trigger controleer_nr_tag_trigger before insert on tag for each row execute function controleer_nr_tag();

create function controleer_tijdstip_quote() returns trigger as $$
    declare
        tijdstip_quote timestamp;
        tijdstip_tweet timestamp;
    begin
        select tijdstip into tijdstip_quote from tweet where id = new.id;
        select tijdstip into tijdstip_tweet from tweet where id = new.gequoot;

        if tijdstip_quote < tijdstip_tweet then
            raise exception 'tijdstip % van quote met id % ligt niet chronologisch na het tijdstip % van de gequoote tweet met id %', tijdstip_quote, new.id, tijdstip_tweet, new.gequoot;
        end if;

        return new;
    end;
$$ language plpgsql;

create trigger controleer_tijdstip_quote_trigger before insert on quote for each row execute function controleer_tijdstip_quote();

create function controleer_tijdstip_retweet() returns trigger as $$
    declare
        tijdstip_tweet timestamp;
    begin
        select tijdstip into tijdstip_tweet from tweet where id = new.id;

        if new.tijdstip < tijdstip_tweet then
            raise exception 'tijdstip % van retweet ligt niet chronologisch na het tijdstip % van de hergepubliceerde tweet met id %', new.tijdstip, tijdstip_tweet, new.id;
        end if;

        return new;
    end;
$$ language plpgsql;

create trigger controleer_tijdstip_retweet_trigger before insert on retweet for each row execute function controleer_tijdstip_retweet();