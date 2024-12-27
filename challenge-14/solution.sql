SELECT 
    value->>'receipt_id' as receipt_id,
    value->>'garment' as garment,
    value->>'color' as color,
    (value->>'cost')::numeric as cost,
    (value->>'drop_off')::date as drop_off,
    (value->>'pickup')::date as pickup
FROM santarecords,
    json_array_elements(cleaning_receipts::json) as value
where value->>'garment' = 'suit' and value->>'color' = 'green'
order by drop_off desc;