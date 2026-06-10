create or replace table gold.flights as 
select
    fo.flight_id,
    fo.flight_number,
    fo.flight_status,
    rt.route_type_id,
    fa.authorization_type_id,
    al.airline_id,
    ao.airport_id as origin_airport_id,
    ad.airport_id as destination_airport_id,
    fo.scheduled_departure,
    fo.actual_departure,
    fo.scheduled_arrival,
    fo.actual_arrival,
    timediff(minute,  fo.scheduled_departure, fo.actual_departure) as departure_delay_minutes,
    timediff(minute, fo.scheduled_arrival, fo.actual_arrival) as arrival_delay_minutes,
    case
        when date(fo.scheduled_departure)
            between al.operational_status_date
            and al.operational_valid_until
    then true
    else false
end as is_authorized_to_fly
    
from silver.flight_operation fo

left join gold.route_type rt
    on fo.route_type_code = rt.route_type_code

left join gold.flight_authorization_type fa
    on fo.authorization_code = fa.authorization_code

join gold.airlines al
    on fo.airline_icao_code = al.icao

join gold.airports ao
    on fo.origin_airport_icao = ao.icao

join gold.airports ad
    on fo.destination_airport_icao = ad.icao
