insert into silver.flight_operation
WITH base AS (
    SELECT
        scheduled_arrival,
        actual_arrival,
        authorization_code,
        CASE WHEN justification_code = 'N/A' THEN NULL ELSE justification_code END AS justification_code,
        route_type_code,
        destination_airport_icao,
        origin_airport_icao,
        airline_icao_code,
        flight_number,
        scheduled_departure,
        actual_departure,
        CASE 
            WHEN flight_status = 'CANCELADO'     THEN 'cancelled'
            WHEN flight_status = 'REALIZADO'     THEN 'done'
            WHEN flight_status = 'NÃO INFORMADO' THEN 'not informed'
            ELSE flight_status
        END AS flight_status,
        created_at,
        updated_at
    FROM bronze.vra
),

deduped AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY
                airline_icao_code,
                flight_number,
                origin_airport_icao,
                scheduled_departure
            ORDER BY updated_at DESC
        ) AS rn
    FROM base
)
select
    left(
        sha2(
            concat_ws('|',
                airline_icao_code,
                flight_number,
                origin_airport_icao,
                destination_airport_icao,
                cast(scheduled_departure as string)
            ), 256
        ), 16
    ) as flight_id, 
    scheduled_arrival,
    actual_arrival,
    authorization_code,
    justification_code,
    route_type_code,
    destination_airport_icao,
    origin_airport_icao,
    airline_icao_code,
    flight_number,
    scheduled_departure,
    actual_departure,
    flight_status,
    created_at,
    updated_at
from 
    deduped 
where 
    rn = 1;
