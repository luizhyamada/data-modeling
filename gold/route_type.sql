create table gold.route_type as
select
    cast(
        row_number() over(order by route_type_code)
        as int
    ) as route_type_id,
    route_type_code,
    case
        when route_type_code = 'N' then 'Domestic Mixed '
        when route_type_code = 'C' then 'Domestic Cargo'
        when route_type_code = 'I' then 'International Mixed'
        when route_type_code = 'G' then 'International Cargo'
        when route_type_code = 'X' then 'Non-Scheduled Operation'
        when route_type_code = 'NA' then 'Not Applicable'
    end as description
from (
    select distinct route_type_code
    from silver.flight_operation
);