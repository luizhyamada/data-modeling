with base as (
    select
        company_name,
        split(icao_iata_code, ' ')[0] as icao,
        case
            when size(split(icao_iata_code, ' ')) > 1
            then split(icao_iata_code, ' ')[1]
        end as iata,
        tax_id,
        air_operations,
        headquarters_address,
        phone_number,
        email,
        operational_status,
        to_date(operational_status_date, 'dd/MM/yyyy') as operational_status_date,
        to_date(operational_valid_until, 'dd/MM/yyyy') as operational_valid_until,
        created_at,
        updated_at
    from bronze.air_cia
),
deduped as (
    select 
        *,
        row_number() over (
            partition by tax_id
            order by updated_at desc
        ) as rn
    from base
)
insert into silver.air_cia
select
    row_number() over (order by icao) as airline_id,
    company_name,
    icao,
    iata,
    tax_id,
    air_operations,
    headquarters_address,
    phone_number,
    email,
    operational_status,
    operational_status_date,
    operational_valid_until,
    created_at,
    updated_at
from deduped
where rn = 1;