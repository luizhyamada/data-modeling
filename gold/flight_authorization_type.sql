create table gold.flight_authorization_type as
select
    cast(
        row_number() over(order by authorization_code)
        as int
    ) as authorization_type_id,
    authorization_code,
    case
        when authorization_code = '0' then 'Regular Flight Stage'
        when authorization_code = '1' then 'Non Regular Flight Stage'
        when authorization_code = '2' then 'Extra Flight Stage'
        when authorization_code = '3' then 'Return Flight Stage'
        when authorization_code = '4' then 'Added Flight Stage'
        when authorization_code = '6' then 'Non-Revenue Flight Without Cargo'
        when authorization_code = '7' then 'Charter/Freight Flight Stage'
        when authorization_code = '9' then 'Charter Flight Stage'
        when authorization_code = 'D' then 'Duplicated Flight Stage'
        when authorization_code = 'E' then 'Non-Revenue Flight With Cargo'
    end as description
from (
    select distinct authorization_code
    from silver.flight_operation
);