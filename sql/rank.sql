with firstrank as (
select area_nm
, cat
from (
select *, row_number () over (partition by area_nm) as rownum
from (
select area_nm
, cat
, sum(qty) as qty
from sales_data
group by area_nm, cat
order by area_nm, qty desc
) t
) tt
where rownum = 1
), secondrank as (
select area_nm
, cat
from (
select *, row_number () over (partition by area_nm) as rownum
from (
select area_nm
, cat
, sum(qty) as qty
from sales_data
group by area_nm, cat
order by area_nm, qty desc
) t
) tt
where rownum = 2
), thirdrank as (
select area_nm
, cat
from (
select *, row_number () over (partition by area_nm) as rownum
from (
select area_nm
, cat
, sum(qty) as qty
from sales_data
group by area_nm, cat
order by area_nm, qty desc
) t
) tt
where rownum = 3
)
select t1.area_nm as area_nm
, coalesce(t1.cat) ||&#39; &#39; || coalesce(t2.cat) || &#39; &#39; || coalesce(t3.cat) as catrank
from firstrank t1
inner join secondrank t2

on t1.area_nm = t2.area_nm
inner join thirdrank t3
on t2.area_nm = t3.area_nm