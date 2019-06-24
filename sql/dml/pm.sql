/*
 * 측정값에 데이터가 없는 경우 권역별 평균 삽입
 * */

select trim(final_t.obs_date) as obs_date
     , trim(final_t.pvn_nm)   as pvn_nm
	 , final_t.bor_nm
     , avg(final_t.so2)  as so2
	 , avg(final_t.co)   as co
	 , avg(final_t.o3)   as o3
	 , avg(final_t.n02)  as n02
	 , avg(final_t.pm10) as pm10
	 , avg(final_t.pm25) as pm25
  from (
/*
 * 2016년 데이터
 * */
	select tt.obs_date
	     , tt.pvn_nm
	     , tt.bor_nm
		 , ta.so2
		 , ta.co
		 , ta.o3
		 , ta.n02
		 , ta.pm10
		 , ta.pm25
	  from (
        select t1.obs_date
		     , t2.pvn_nm
			 , case when trim(t2.bor_nm) = '연천군' or trim(t2.bor_nm) = '포천군' then '연천군포천군'
					when trim(t2.bor_nm) = '가평군' or trim(t2.bor_nm) = '양평군' then '가평군양평군'
					when trim(t2.bor_nm) = '여주시' or trim(t2.bor_nm) = '이천시' then '여주시이천시'
					when trim(t2.bor_nm) = '오산시' or trim(t2.bor_nm) = '안성시' or trim(t2.bor_nm) = '평택시' then '오산시안성시평택시'
					else trim(t2.bor_nm)
				end as bor_nm
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
        	     	   ,substring(trim(bor_nm),3,10) as bor_nm
        	       from contest.weather_pm
        	      where obs_date between '20160101' and '20161231'
        	        and substring(bor_nm,1,2) != '서울'
        	     group by 
        	     	   case when substring(bor_nm,1,2) = '경기' then '경기도'
        	     			when substring(bor_nm,1,2) = '서울' then '서울특별시'
        	     			when substring(bor_nm,1,2) = '인천' then '인천광역시'
        	          	end
        	     	   ,substring(trim(bor_nm),3,10)
        	     union all
        	     /*
        		 * 서울 지역
        		 * */
        	     select case when substring(bor_nm,1,2) = '경기' then '경기도'
        	                 when substring(bor_nm,1,2) = '서울' then '서울특별시'
        	     			 when substring(bor_nm,1,2) = '인천' then '인천광역시'
        	     		end as pvn_nm
        	     	   ,trim(obs_nm) as bor_nm
        	       from contest.weather_pm
        	      where obs_date between '20160101' and '20161231'
        	        and substring(bor_nm,1,2) = '서울'
        	        and substr(obs_nm, position('구' in obs_nm)) = '구'
        	     group by 
        	     	   case when substring(bor_nm,1,2) = '경기' then '경기도'
        	     			when substring(bor_nm,1,2) = '서울' then '서울특별시'
        	     			when substring(bor_nm,1,2) = '인천' then '인천광역시'
        	          	end
        	     	   ,trim(obs_nm)
        		) t2
			group by 
				t1.obs_date
		      , t2.pvn_nm
			 , case when trim(t2.bor_nm) = '연천군' or trim(t2.bor_nm) = '포천군' then '연천군포천군'
					when trim(t2.bor_nm) = '가평군' or trim(t2.bor_nm) = '양평군' then '가평군양평군'
					when trim(t2.bor_nm) = '여주시' or trim(t2.bor_nm) = '이천시' then '여주시이천시'
					when trim(t2.bor_nm) = '오산시' or trim(t2.bor_nm) = '안성시' or trim(t2.bor_nm) = '평택시' then '오산시안성시평택시'
					else trim(t2.bor_nm)
				end
        	) tt
			left outer join 
			(
        		/*
        		 * 서울 외 지역(인천, 경기)
        		 * */			
			 select 
			        trim(substring(bor_nm,3,10)) as bor_nm
			       ,case when substring(bor_nm,1,2) = '경기' then '경기도'
        	             when substring(bor_nm,1,2) = '서울' then '서울특별시'
        	     	     when substring(bor_nm,1,2) = '인천' then '인천광역시'
        	     	 end as pvn_nm
			       ,obs_date
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
			        trim(substring(bor_nm,3,10))
			       ,case when substring(bor_nm,1,2) = '경기' then '경기도'
        	             when substring(bor_nm,1,2) = '서울' then '서울특별시'
        	     	     when substring(bor_nm,1,2) = '인천' then '인천광역시'
        	     	 end
			       ,obs_date

            union all
        	     /*
        		 * 서울 지역
        		 * */
			 select 
			        trim(obs_nm) as bor_nm
			       ,case when substring(bor_nm,1,2) = '경기' then '경기도'
        	             when substring(bor_nm,1,2) = '서울' then '서울특별시'
        	     	     when substring(bor_nm,1,2) = '인천' then '인천광역시'
        	     	 end as pvn_nm
			       ,obs_date
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
			        case when substring(bor_nm,1,2) = '경기' then '경기도'
        	             when substring(bor_nm,1,2) = '서울' then '서울특별시'
        	     	     when substring(bor_nm,1,2) = '인천' then '인천광역시'
        	     	 end
			       ,trim(obs_nm)
			       ,obs_date
			) ta
			on tt.obs_date = ta.obs_date
			and tt.pvn_nm = ta.pvn_nm
			and tt.bor_nm = ta.bor_nm
			
union all 

/*
 * 2017 ~ 2018년 데이터
 * */
	select tt.obs_date
	     , tt.pvn_nm
	     , tt.bor_nm
	     , ta.so2
	     , ta.co
	     , ta.o3
	     , ta.n02
	     , ta.pm10
	     , ta.pm25
	  from (
        select t1.obs_date 
		     , t2.pvn_nm
			 , case when trim(t2.bor_nm) = '연천군' or trim(t2.bor_nm) = '포천군' then '연천군포천군'
					when trim(t2.bor_nm) = '가평군' or trim(t2.bor_nm) = '양평군' then '가평군양평군'
					when trim(t2.bor_nm) = '여주시' or trim(t2.bor_nm) = '이천시' then '여주시이천시'
					when trim(t2.bor_nm) = '오산시' or trim(t2.bor_nm) = '안성시' or trim(t2.bor_nm) = '평택시' then '오산시안성시평택시'
					else trim(t2.bor_nm)
				end as bor_nm
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
				  where substring(bor_nm,3,10) != ''
        	     group by 
        	     	   case when substring(bor_nm,1,2) = '경기' then '경기도'
        	     			when substring(bor_nm,1,2) = '서울' then '서울특별시'
        	     			when substring(bor_nm,1,2) = '인천' then '인천광역시'
        	          	end
        	     	   ,substring(bor_nm,3,10)
        		) t2
			group by 
			   t1.obs_date 
		     , t2.pvn_nm
			 , case when trim(t2.bor_nm) = '연천군' or trim(t2.bor_nm) = '포천군' then '연천군포천군'
					when trim(t2.bor_nm) = '가평군' or trim(t2.bor_nm) = '양평군' then '가평군양평군'
					when trim(t2.bor_nm) = '여주시' or trim(t2.bor_nm) = '이천시' then '여주시이천시'
					when trim(t2.bor_nm) = '오산시' or trim(t2.bor_nm) = '안성시' or trim(t2.bor_nm) = '평택시' then '오산시안성시평택시'
					else trim(t2.bor_nm)
				end			
			) tt
			left outer join 
			(
			 select 
			        trim(substring(bor_nm,3,10)) as bor_nm
			       ,case when substring(bor_nm,1,2) = '경기' then '경기도'
        	             when substring(bor_nm,1,2) = '서울' then '서울특별시'
        	     	     when substring(bor_nm,1,2) = '인천' then '인천광역시'
        	     	 end as pvn_nm
			       ,obs_date
			       ,avg("SO2") so2
			       ,avg("CO") co
			       ,avg("O3") o3
			       ,avg("N02") n02
			       ,avg("PM10") pm10
			       ,avg("PM25") pm25
			   from contest.weather_pm
			group by 
			        trim(substring(bor_nm,3,10))
			       ,case when substring(bor_nm,1,2) = '경기' then '경기도'
        	             when substring(bor_nm,1,2) = '서울' then '서울특별시'
        	     	     when substring(bor_nm,1,2) = '인천' then '인천광역시'
        	     	 end
			       ,obs_date
			) ta
			on tt.obs_date = ta.obs_date
			and tt.pvn_nm = ta.pvn_nm
			and tt.bor_nm = ta.bor_nm
	) final_t
group by 
       trim(final_t.obs_date)
     , trim(final_t.pvn_nm)
	 , final_t.bor_nm