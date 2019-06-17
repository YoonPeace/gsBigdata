select t2.area
     , t1.pvn_nm
     , t1.bor_nm
     , t1.std_date 
     , round(coalesce(t1.max_temp, avg(t1.max_temp) over (partition by t2.area, t1.std_date)), 1) as max_temp
     , round(coalesce(t1.max_ws, avg(t1.max_ws) over (partition by t2.area, t1.std_date)), 1)     as max_ws
     , round(coalesce(t1.min_temp, avg(t1.min_temp) over (partition by t2.area, t1.std_date)), 1) as min_temp
     , round(coalesce(t1.avg_temp, avg(t1.avg_temp) over (partition by t2.area, t1.std_date)), 1) as avg_temp
     , round(coalesce(t1.avg_rhm, avg(t1.avg_rhm) over (partition by t2.area, t1.std_date)), 1)   as avg_rhm
     , round(coalesce(t1.avg_wa, avg(t1.avg_wa) over (partition by t2.area, t1.std_date)), 1)     as avg_ws
     , round(coalesce(t1.sum_rm, avg(t1.sum_rm) over (partition by t2.area, t1.std_date)), 1)     as sum_rm
    from weather t1
 inner join pvn t2 
	on t1.pvn_nm = t2.pvn_nm
   and t1.bor_nm = t2.bor_nm
 group by 
      t2.area
    , t1.pvn_nm
    , t1.bor_nm
    , t1.std_date
    , t1.max_temp
    , t1.max_ws
    , t1.min_temp
    , t1.avg_temp
    , t1.avg_rhm
    , t1.avg_wa
    , t1.sum_rm
