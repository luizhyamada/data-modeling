create table silver.flight_operation(
    flight_id string,
    scheduled_arrival timestamp,
    actual_arrival timestamp,
    authorization_code string,
    justification_code string,
    route_type_code string,
    destination_airport_icao string,
    origin_airport_icao string,
    airline_icao_code string,
    flight_number string,
    scheduled_departure timestamp,
    actual_departure timestamp,
    flight_status string,
    created_at  timestamp,
    updated_at  timestamp
) USING DELTA;