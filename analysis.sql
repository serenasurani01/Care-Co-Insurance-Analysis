
USE DATABASE CARECO;
USE SCHEMA public;
DROP TABLE IF EXISTS marketing_analysis;
DROP TABLE IF EXISTS campaign_quartiles;
DROP TABLE IF EXISTS avg_click_quartile;
DROP TABLE IF EXISTS cleaned_campaign_data;
DROP TABLE IF EXISTS market_analysis_camp_cat;
DROP TABLE IF EXISTS market_analysis_camp_plat;
DROP TABLE IF EXISTS signups_by_month;
DROP TABLE IF EXISTS signups_by_month_plan;
DROP TABLE IF EXISTS customer_premiums_paid;
DROP TABLE IF EXISTS plan_analysis;
DROP TABLE IF EXISTS claim_analysis_product;
DROP TABLE IF EXISTS claim_analysis_product_plan;

-- Imputing Missing Clicks Data
create temporary table campaign_quartiles as(
select campaign_id, 
impressions, 
clicks, 
ntile(4) over(order by impressions ASC) as impression_quartile
from campaigns);

create temporary table avg_click_quartile as (
select impression_quartile,
avg(clicks) as avg_clicks
from campaign_quartiles
where clicks is NOT NULL
and clicks > 0 
group by impression_quartile);

create temporary table cleaned_campaign_data as(
select 
    cq.campaign_id as campaign_id, 
    cq.impressions as impressions,
    round(case when cq.clicks is null then ac.avg_clicks
    when cq.clicks > 0 then cq.clicks
    else ac.avg_clicks end, 0) as clicks
    from campaign_quartiles cq
    left join 
    avg_click_quartile ac
    on cq.impression_quartile = ac.impression_quartile  
);


-- Marketing Analysis by campaign_id

create temporary table marketing_analysis as( 
select camp.campaign_id as campaign_id  ,
camp.campaign_category as campaign_category,
camp.campaign_type as campaign_type ,
camp.cost as cost,
camp.platform as platform,
camp.impressions as impressions,
camp.clicks as org_clicks,
ccd.clicks as clicks,
camp.days_run as days_run,
coalesce(s.signups,0) as signups,
coalesce((s.signups/nullif(camp.impressions,0))*100,0) as conversion_rate,
coalesce((ccd.clicks/nullif(camp.impressions,0)) *100,0) as click_through_rate,
coalesce((camp.cost/nullif(ccd.clicks,0)),0) as cost_per_click,
coalesce((camp.cost/nullif(s.signups,0)),0) as cost_per_acquistion,
coalesce((camp.cost/nullif(camp.impressions,0)) * 1000,0) as cost_per_thousand_impressions
from campaigns camp
left join (select campaign_id, 
count(customer_id) as signups 
from customers
group by campaign_id) as s
on s.CAMPAIGN_ID = camp.CAMPAIGN_ID
left join cleaned_campaign_data ccd
on ccd.CAMPAIGN_ID = camp.CAMPAIGN_ID
);

-- Marketing Analysis by campaign category

create temporary table market_analysis_camp_cat as ( select
camp_cat_org.*,
coalesce(camp_cat_org.camp_cat_signups,0) as signups,
coalesce((camp_cat_org.camp_cat_signups/nullif(camp_cat_org.camp_cat_impressions,0))*100,0) as conversion_rate,
coalesce((camp_cat_org.camp_cat_clicks/nullif(camp_cat_org.camp_cat_impressions,0)) *100,0) as click_through_rate,
coalesce((camp_cat_org.camp_cat_cost/nullif(camp_cat_org.camp_cat_clicks,0)),0) as cost_per_click,
coalesce((camp_cat_org.camp_cat_cost/nullif(camp_cat_org.camp_cat_signups,0)),0) as cost_per_acquistion,
coalesce((camp_cat_org.camp_cat_cost/nullif(camp_cat_org.camp_cat_impressions,0)) * 1000,0) as cost_per_thousand_impressions
from (select campaign_category as campaign_category, 
sum(cost) as camp_cat_cost, 
sum(impressions) as camp_cat_impressions, 
sum(clicks) as camp_cat_clicks, 
sum(days_run) as camp_cat_days, 
sum(signups) as camp_cat_signups
from marketing_analysis 
group by campaign_category) camp_cat_org
);

-- Marketing Analysis by Platform

create temporary table market_analysis_camp_plat as ( select
plat_org.*,
coalesce(plat_org.camp_plat_signups,0) as signups,
coalesce((plat_org.camp_plat_signups/nullif(plat_org.camp_plat_impressions,0))*100,0) as conversion_rate,
coalesce((plat_org.camp_plat_clicks/nullif(plat_org.camp_plat_impressions,0)) *100,0) as click_through_rate,
coalesce((plat_org.camp_plat_cost/nullif(plat_org.camp_plat_clicks,0)),0) as cost_per_click,
coalesce((plat_org.camp_plat_cost/nullif(plat_org.camp_plat_signups,0)),0) as cost_per_acquistion,
coalesce((plat_org.camp_plat_cost/nullif(plat_org.camp_plat_impressions,0)) * 1000,0) as cost_per_thousand_impressions
from (select platform as platform, 
sum(cost) as camp_plat_cost, 
sum(impressions) as camp_plat_impressions, 
sum(clicks) as camp_plat_clicks, 
sum(days_run) as camp_plat_days, 
sum(signups) as camp_plat_signups
from marketing_analysis 
group by platform) plat_org
);

-- Signups by month

create temporary table signups_by_month as ( select 
date_trunc('month', signup_date::date) as signup_month,
count(customer_id) as signups 
from customers
group by signup_month
order by signup_month);

-- Signups by month and plan

create temporary table signups_by_month_plan as ( select 
plan,
date_trunc('month', signup_date::date) as signup_month,
count(customer_id) as signups 
from customers
group by plan, signup_month);

-- Claims Analysis

-- analysis by customer
create temporary table customer_premiums_paid as (
select cus.*,
cl_cus.number_of_claims as number_of_claims,
cl_cus.last_claim_date as last_claim_date,
cl_cus.total_claimed as total_claimed,
cl_cus.total_covered as total_covered,
datediff(MONTH,cus.signup_date,last_claim_date) as number_months, 
plan_t.premium as monthly_premium,
case when number_months = 0 then monthly_premium
else monthly_premium * number_months end as total_premiums_paid,
number_of_claims / nullif(number_months, 0) as claims_frequency,
total_claimed / nullif(number_of_claims, 0) as claims_severity,
total_claimed / nullif(total_premiums_paid, 0) as loss_ratio,
total_covered / nullif(total_claimed, 0) as coverage_ratio,
total_claimed - total_premiums_paid as claims_vs_premiums
from customers cus
left join (select customer_id,
count(claim_id) as number_of_claims,
max(claim_date) as last_claim_date,
sum(claim_amount) as total_claimed,
sum(covered_amount) as total_covered
from claims
group by customer_id) cl_cus
on cl_cus.customer_id = cus.customer_id
left join plan as plan_t
on lower(plan_t.plan) = lower(cus.plan)
);

-- analysis by plan

create temporary table plan_analysis as (
select plan,
sum(total_claimed) as plan_total_claimed,
sum(total_covered) as plan_total_covered,
sum(number_of_claims) as plan_number_of_claims,
sum(total_premiums_paid) as plan_total_premiums_paid,
avg(coverage_ratio) as avg_coverage_ratio,
avg(claims_frequency) as avg_claims_frequency
from customer_premiums_paid
group by plan
);

-- analysis by product
create temporary table claim_analysis_product as (
select 
product_org.product_name,
count(distinct product_org.customer_id ) as unique_customers,
sum(product_org.number_of_claims) as total_claims_product,
sum(product_org.total_claimed) as total_claimed_product,
sum(product_org.total_covered_amount) as total_covered_product,
avg(product_org.frequency_of_claim_by_month) as avg_frequency_of_claim_by_month
from (
select 
customer_id, 
product_name, 
count(claim_id) as number_of_claims,
min(claim_date) as earliest_claim_date, 
max(claim_date) as latest_claim_date,
datediff(month, min(claim_date), max(claim_date)) as months_between_claims,
case 
when datediff(month, min(claim_date), max(claim_date)) = 0 then null
else count(claim_id) / nullif(datediff(month, min(claim_date), max(claim_date)), 0)
end as frequency_of_claim_by_month,
sum(claim_amount) as total_claimed,
sum(covered_amount) as total_covered_amount
from 
claims
group by 
customer_id, 
product_name
) as product_org
group by 
product_org.product_name
);


-- analysis by product and plan
create temporary table claim_analysis_product_plan as (
select 
product_org.product_name,
product_org.plan,
count(distinct product_org.customer_id ) as unique_customers,
sum(product_org.number_of_claims) as total_claims_product,
sum(product_org.total_claimed) as total_claimed_product,
sum(product_org.total_covered_amount) as total_covered_product,
avg(product_org.frequency_of_claim_by_month) as avg_frequency_of_claim_by_month
from (
select 
cl.customer_id as customer_id, 
cl.product_name as product_name, 
cs.plan as plan,
count(cl.claim_id) as number_of_claims,
min(cl.claim_date) as earliest_claim_date, 
max(cl.claim_date) as latest_claim_date,
datediff(month, min(cl.claim_date), max(cl.claim_date)) as months_between_claims,
case 
when datediff(month, min(cl.claim_date), max(cl.claim_date)) = 0 then null
else count(cl.claim_id) / nullif(datediff(month, min(cl.claim_date), max(cl.claim_date)), 0)
end as frequency_of_claim_by_month,
sum(cl.claim_amount) as total_claimed,
sum(cl.covered_amount) as total_covered_amount
from 
claims cl
left join customers cs
on cs.customer_id = cl.customer_id
group by 
cl.customer_id, 
cl.product_name,
cs.plan
) as product_org
group by 
product_org.product_name,
product_org.plan
);




