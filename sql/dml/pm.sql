/*
 * 2016년 데이터
 * */
	select * 
	  from (
        select *
          from (
                  select obs_date
                    from contest.weather_pm
        	       where obs_date between '20160101' and '20161231'
                group by obs_date
        	    ) t1 
        cross join
        		(
        		/*
        		 * 서울 외 지역(인천, 경기)
        		 * */
        	     select case when substring(bor_nm,1,2) = '경기' then '경기도'
        	                 when substring(bor_nm,1,2) = '서울' then '서울특별시'
        	     			 when substring(bor_nm,1,2) = '인천' then '인천광역시'
        	     		end as pvn_nm
        	     	   ,substring(bor_nm,3,10) as bor_nm
        	       from contest.weather_pm
        	      where obs_date between '20160101' and '20161231'
        	        and substring(bor_nm,1,2) != '서울'
        	     group by 
        	     	   case when substring(bor_nm,1,2) = '경기' then '경기도'
        	     			when substring(bor_nm,1,2) = '서울' then '서울특별시'
        	     			when substring(bor_nm,1,2) = '인천' then '인천광역시'
        	          	end
        	     	   ,substring(bor_nm,3,10)
        	     union all
        	     /*
        		 * 서울 지역
        		 * */
        	     select case when substring(bor_nm,1,2) = '경기' then '경기도'
        	                 when substring(bor_nm,1,2) = '서울' then '서울특별시'
        	     			 when substring(bor_nm,1,2) = '인천' then '인천광역시'
        	     		end as pvn_nm
        	     	   ,obs_nm
        	       from contest.weather_pm
        	      where obs_date between '20160101' and '20161231'
        	        and substring(bor_nm,1,2) = '서울'
        	        and substr(obs_nm, position('구' in obs_nm)) = '구'
        	     group by 
        	     	   case when substring(bor_nm,1,2) = '경기' then '경기도'
        	     			when substring(bor_nm,1,2) = '서울' then '서울특별시'
        	     			when substring(bor_nm,1,2) = '인천' then '인천광역시'
        	          	end
        	     	   ,obs_nm
        		) t2
        	) tt
			left outer join 
			(
        		/*
        		 * 서울 외 지역(인천, 경기)
        		 * */			
			 select 
			        substring(bor_nm,3,10) as bor_nm
			       ,case when substring(bor_nm,1,2) = '경기' then '경기도'
        	             when substring(bor_nm,1,2) = '서울' then '서울특별시'
        	     	     when substring(bor_nm,1,2) = '인천' then '인천광역시'
        	     	 end as pvn_nm
			       ,obs_nm
			       ,obs_date
			       ,adres
			       ,avg("SO2") so2
			       ,avg("CO") co
			       ,avg("O3") o3
			       ,avg("N02") n02
			       ,avg("PM10") pm10
			       ,avg("PM25") pm25
			   from contest.weather_pm
        	  where obs_date between '20160101' and '20161231'
        	    and substring(bor_nm,1,2) != '서울'
			group by 
			        substring(bor_nm,3,10)
			       ,case when substring(bor_nm,1,2) = '경기' then '경기도'
        	             when substring(bor_nm,1,2) = '서울' then '서울특별시'
        	     	     when substring(bor_nm,1,2) = '인천' then '인천광역시'
        	     	 end
			       ,obs_nm
			       ,obs_date
			       ,adres
            union all
        	     /*
        		 * 서울 지역
        		 * */
			 select 
			        obs_nm as bor_nm
			       ,case when substring(bor_nm,1,2) = '경기' then '경기도'
        	             when substring(bor_nm,1,2) = '서울' then '서울특별시'
        	     	     when substring(bor_nm,1,2) = '인천' then '인천광역시'
        	     	 end as pvn_nm
			       ,obs_nm
			       ,obs_date
			       ,adres
			       ,avg("SO2") so2
			       ,avg("CO") co
			       ,avg("O3") o3
			       ,avg("N02") n02
			       ,avg("PM10") pm10
			       ,avg("PM25") pm25
			   from contest.weather_pm
        	  where obs_date between '20160101' and '20161231'
        	    and substring(bor_nm,1,2) = '서울'
        	    and substr(obs_nm, position('구' in obs_nm)) = '구'
			group by 
			        substring(bor_nm,3,10)
			       ,case when substring(bor_nm,1,2) = '경기' then '경기도'
        	             when substring(bor_nm,1,2) = '서울' then '서울특별시'
        	     	     when substring(bor_nm,1,2) = '인천' then '인천광역시'
        	     	 end
			       ,obs_nm
			       ,obs_date
			       ,adres
			) ta
			on tt.obs_date = ta.obs_date
			and tt.pvn_nm = ta.pvn_nm
			and tt.bor_nm = ta.bor_nm
union all 
/*
 * 2017 ~ 2018년 데이터
 * */
	select * 
	  from (
        select *
          from (
                  select obs_date
                    from contest.weather_pm
        	       where obs_date between '20170101' and '20190101'
                group by obs_date
        	    ) t1 
        cross join
        		(
        	     select case when substring(bor_nm,1,2) = '경기' then '경기도'
        	                 when substring(bor_nm,1,2) = '서울' then '서울특별시'
        	     			 when substring(bor_nm,1,2) = '인천' then '인천광역시'
        	     		end as pvn_nm
        	     	   ,substring(bor_nm,3,10) as bor_nm
        	       from contest.weather_pm
        	     group by 
        	     	   case when substring(bor_nm,1,2) = '경기' then '경기도'
        	     			when substring(bor_nm,1,2) = '서울' then '서울특별시'
        	     			when substring(bor_nm,1,2) = '인천' then '인천광역시'
        	          	end
        	     	   ,substring(bor_nm,3,10)
        		) t2
			) tt
			left outer join 
			(select 
			        substring(bor_nm,3,10) as bor_nm
			       ,case when substring(bor_nm,1,2) = '경기' then '경기도'
        	             when substring(bor_nm,1,2) = '서울' then '서울특별시'
        	     	     when substring(bor_nm,1,2) = '인천' then '인천광역시'
        	     	 end as pvn_nm
			       ,obs_nm
			       ,obs_date
			       ,adres
			       ,avg("SO2") so2
			       ,avg("CO") co
			       ,avg("O3") o3
			       ,avg("N02") n02
			       ,avg("PM10") pm10
			       ,avg("PM25") pm25
			   from contest.weather_pm
			group by 
			        substring(bor_nm,3,10)
			       ,case when substring(bor_nm,1,2) = '경기' then '경기도'
        	             when substring(bor_nm,1,2) = '서울' then '서울특별시'
        	     	     when substring(bor_nm,1,2) = '인천' then '인천광역시'
        	     	 end
			       ,obs_nm
			       ,obs_date
			       ,adres
			) ta
			on tt.obs_date = ta.obs_date
			and tt.pvn_nm = ta.pvn_nm
			and tt.bor_nm = ta.bor_nm
				
