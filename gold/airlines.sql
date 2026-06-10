create or replace  table gold.airlines as
select 
    airline_id,
    company_name,
    icao,
    iata,
    operational_status_date,
    case 
        when operational_valid_until is null 
        then '9999-12-31' 
    else operational_valid_until 
    end as operational_valid_until
from
    silver.air_cia;