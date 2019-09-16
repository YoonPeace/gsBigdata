rm(list=ls())
##Set work directory
getwd()
setwd("D://contest//")


# Data Upload
base_data <- read.csv("data//0715_base1.csv",fileEncoding = 'utf-8')
test_data <- read.csv("data//test.csv",fileEncoding = 'utf-8')
str(test_data)
colnames(base_data)
#separate data




,"area_10"            
,"area_20"            
,"서울특별시.서초구"
,"경기도.부천시"      
,"경기도.안양시"      
,"경기도.군포시"     
,"서울특별시.서대문구"
,"서울특별시.동작구"  
,"서울특별시.관악구"  
,"서울특별시.광진구"  
,"서울특별시.마포구"
,"서울특별시.강서구"

raw_data=subset(base_data,서울특별시.강서구==1)
str(raw_data)
col_list = c("promo_day_cnt"      
             ,"promo_ssn_cnt"      
             ,"promo_disc_cnt"     
             ,"promo_co_cnt"       
             ,"avg_temp"           
             ,"ilgyo"              
             ,"avg_rhm"            
             ,"pm10"               
             ,"sun"                
             ,"cloud"              
             ,"qty"                
             ,"gen_cd_M"
             ,"gen_cd_F"           
             ,"agegr_20_1"         
             ,"agegr_20_3"         
             ,"agegr_20_4"         
             ,"agegr_20_2")
unique(raw_data[,'cat'])
mask=subset(raw_data,cat=='마스크팩',select=col_list)
cleanser=subset(raw_data,cat=='훼이셜클렌저',select=col_list)
lip_color=subset(raw_data,cat=='립컬러',select=col_list)
lip_care=subset(raw_data,cat=='립케어',select=col_list)
nail=subset(raw_data,cat=='네일',select=col_list)
wei=subset(raw_data,cat=='체중조절',select=col_list)
lotion=subset(raw_data,cat=='크림로션',select=col_list)
body=subset(raw_data,cat=='바디로션',select=col_list)
sun=subset(raw_data,cat=='선케어',select=col_list)
cut=subset(raw_data,cat=='제모제',select=col_list)


##############lotion##############
##all
lotion_leg <- lm(qty ~ ., data = lotion)
summary(lotion_leg)

##############cleanser##############
##all
cleanser_leg <- lm(qty ~ ., data = cleanser)
summary(cleanser_leg)

result <- predict(cleanser_leg, newdata = test_data)
result


##############mask##############
##all
mask_leg <- lm(qty ~ ., data = mask)
summary(mask_leg)

result <- predict(mask_leg, newdata = test_data)
result

##############lip_color##############
##all
lip_color_leg <- lm(qty ~ ., data = lip_color)
summary(lip_color_leg)

##############lip_care##############
##all
lip_care_leg <- lm(qty ~ ., data = lip_care)
summary(lip_care_leg)

##############sun##############
##all
sun_leg <- lm(qty ~ ., data = sun)
summary(sun_leg)

##############cut##############
##all
cut_leg <- lm(qty ~ ., data = cut)
summary(cut_leg)

result <- predict(cut_leg, newdata = test_data)
result

##############nail##############
##all
nail_leg <- lm(qty ~ ., data = nail)
summary(nail_leg)


##############body##############
##all
body_leg <- lm(qty ~ ., data = body)
summary(body_leg)

##############wei##############
##all
wei_leg <- lm(qty ~ ., data = wei)
summary(wei_leg)


