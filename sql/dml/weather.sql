select obs_date
     , pvn_nm
	 , bor_nm
	 , area
	 , so2 
  from (
        select obs_date
             , pvn_nm
             , bor_nm
             , case when pvn_nm = '경기도' and bor_nm = '광명시' then '서부'
                    when pvn_nm = '경기도' and bor_nm = '군포시' then '서부'
                    when pvn_nm = '경기도' and bor_nm = '김포시' then '서부'
                    when pvn_nm = '경기도' and bor_nm = '부천시' then '서부'
                    when pvn_nm = '경기도' and bor_nm = '안양시' then '서부'
                    when pvn_nm = '경기도' and bor_nm = '의왕시' then '서부'
                    when pvn_nm = '경기도' and bor_nm = '하남시' then '서부'
                    when pvn_nm = '인천광역시' and bor_nm = '계양구' then '서부'
                    when pvn_nm = '인천광역시' and bor_nm = '남구' then '서부'
                    when pvn_nm = '인천광역시' and bor_nm = '남동구' then '서부'
                    when pvn_nm = '인천광역시' and bor_nm = '동구' then '서부'
                    else area end as area
             , avg(so2)   as so2
             , avg(co)    as co
             , avg(o3)    as o3
             , avg(n02)   as n02
             , avg(pm10)  as pm10
             , avg(pm25)  as pm25
          from (
           select  obs_date
                 , case when t1.bor_nm = '성남시중원구' then '성남시'
                        when t1.bor_nm = '고양시덕양구' then '고양시' 
                        when t1.bor_nm = '수원시권선구' then '수원시' 
                        when t1.bor_nm = '안산시상록구' then '안산시'
                        when t1.bor_nm in ('가평군','양평군') then '가평군양평군'
                        when t1.bor_nm in ('연천군','포천군') then '연천군포천군'
                        when t1.bor_nm in ('여주시','이천시') then '여주시이천시'
                        when t1.bor_nm in ('오산시','안성시','평택시') then '오산시안성시평택시'
                    else t1.bor_nm
                    end as bor_nm 
                  , pvn_nm
                  , t2.area
                  , avg(so2)   as so2
                  , avg(co)    as co
                  , avg(o3)    as o3
                  , avg(n02)   as n02
                  , avg(pm10)  as pm10
                  , avg(pm25)  as pm25
           from contest.pm_test t1 
           left outer join 
                (
                	select area
                	     , bor_nm
                	  from contest.weather
                 group by area
                	     , bor_nm
                ) t2 
             on t1.bor_nm = t2.bor_nm
           group by obs_date 
                , case when t1.bor_nm = '성남시중원구' then '성남시'
                       when t1.bor_nm = '고양시덕양구' then '고양시' 
                       when t1.bor_nm = '수원시권선구' then '수원시' 
                       when t1.bor_nm = '안산시상록구' then '안산시'
                       when t1.bor_nm in ('가평군','양평군') then '가평군양평군'
                       when t1.bor_nm in ('연천군','포천군') then '연천군포천군'
                       when t1.bor_nm in ('여주시','이천시') then '여주시이천시'
                       when t1.bor_nm in ('오산시','안성시','평택시') then '오산시안성시평택시'
                   else t1.bor_nm
                   end 
                ,  pvn_nm
                ,  t2.area
        		) tt 
        group by obs_date
               , pvn_nm
               , bor_nm
               , case when pvn_nm = '경기도' and bor_nm = '광명시' then '서부'
                      when pvn_nm = '경기도' and bor_nm = '군포시' then '서부'
                      when pvn_nm = '경기도' and bor_nm = '김포시' then '서부'
                      when pvn_nm = '경기도' and bor_nm = '부천시' then '서부'
                      when pvn_nm = '경기도' and bor_nm = '안양시' then '서부'
                      when pvn_nm = '경기도' and bor_nm = '의왕시' then '서부'
                      when pvn_nm = '경기도' and bor_nm = '하남시' then '서부'
                      when pvn_nm = '인천광역시' and bor_nm = '계양구' then '서부'
                      when pvn_nm = '인천광역시' and bor_nm = '남구' then '서부'
                      when pvn_nm = '인천광역시' and bor_nm = '남동구' then '서부'
                      when pvn_nm = '인천광역시' and bor_nm = '동구' then '서부'
                      else area end
		) t
where so2 is null