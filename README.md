# Care Co Insurance Analysis

## Overview

Care Co is a fictional health insurance provider that has 4 plan options: bronze, silver, gold and platinum. In 2019, the Wholistic Wellness Initiative was introduced, offering financial reimbursement for a variety of wellness products, including probiotics, daily vitamins, and stress relief supplements. This program is designed to encourage a well-rounded approach to health and well-being for its customers.  

<img width="186" alt="Plan id Premium" src="https://github.com/user-attachments/assets/da1c7fa0-2696-4c3c-a7b6-abc1c80f6a6e">  

For this analysis I examine campaign performance related to this initiative, customer behaviour across the different plan options as well as product-specific performance. Thus, the analysis is broken down into three main components that seek to answer the following questions.  

Campaign Performance:  
- How do the campaigns perform across various metrics: impressions, click-through rate, and cost per click?  
- Which platform generated the highest number of impressions?  
- Which plans did new customers choose to enroll in?  
  
Customer Behaviour:  
- What are the differences in claims frequency and claim amounts across bronze, silver, gold, and platinum plans?  
- How do customers in each plan utilize the Wholistic Wellness Initiative?  
- Are there any notable trends or patterns in customer retention and product usage based on their chosen plan?  
  
Product Performance:  
- Which wellness products (e.g., probiotics, vitamins, stress relief supplements) are most frequently claimed?  
- How do claim amounts vary across different products?  

## Campaign Performance:

A dashboard with relevant KPIs can be found [here](https://public.tableau.com/app/profile/serena.surani/viz/CareCo/Dashboard1)  
![WHOLISTIC WELLNESS INITIATIVE MARKETING ANALYSIS (2019 - 2023)](https://github.com/user-attachments/assets/2b17e753-cbdb-4b2d-945d-f97c66c5eed8)

**How do the campaigns perform across various metrics: impressions, click-through rate, and cost per click?**
  
The #HealthyLiving campaign category generated the highest number of signups and also achieved the highest average conversion rate at 4.04%. It was closely followed by #CoverageMatters and Health For All, both of which had similar signup numbers and conversion rates to #HealthyLiving. Despite Tailored Health Plans having slightly more impressions than these three categories, its conversion rate was lower, at just 1.03%.  
  
The Compare Health Coverage campaign category had the highest median cost per click (CPC) at $0.39. It accounted for 17% of the total campaign cost while bringing in 17% of the signups. In contrast, #CoverageMatters had the lowest CPC at just $0.03, accounting for 22% of the signups but only 4% of the total cost. Health For All had the second-highest number of signups but also the second-highest CPC at $0.28.  
  
![Pasted Graphic 6](https://github.com/user-attachments/assets/a4d15100-a8dc-4644-b9ca-c6729cc11be6)  


**Which platform generated the highest number of impressions?**

Social Media and SEO generated the highest number of impressions, with Social Media also leading in both average conversion rate (2.35%) and total signups (7,610). When comparing Email to SEO, Email had fewer impressions but resulted in more signups, while also being approximately $5k cheaper. Both platforms contributed to 25% of the total signups, but Email accounted for 28% of the cost, whereas SEO made up 35% of the total cost. Despite having the fewest impressions, TV achieved a higher conversion rate (1.21%) compared to both SEO and Email.

**Which plans did new customers choose to enroll in?**


Throughout this initiative, over 16,000 new customers joined the business, with 86% opting for the silver plan. The top-performing campaign categories for both gold and silver plans were consistent: #HealthyLiving, Health for All, CoverageMatters, and Compare Health Coverage accounted for 85% of all silver customers and 92% of gold customers. In contrast, the Preventive Care News campaign was particularly effective in targeting bronze-level customers, with 70% of bronze sign-ups coming from this campaign. Only 12 new customers enrolled in the platinum plan, making it difficult to draw conclusions about which campaigns were most successful in attracting this group due to the limited data.  
  
<img width="310" alt="platinum" src="https://github.com/user-attachments/assets/2b637382-ff34-4682-9ad7-3552141c6b96">  

## Customer Behaviour  

**What are the differences in claims frequency and claim amounts across bronze, silver, gold, and platinum plans?**

Claim Amounts:  

<img width="211" alt="Total Claim Amounts by Customer" src="https://github.com/user-attachments/assets/95c436d7-ff55-45f9-b35b-636798b97dd0">  
  
For the bronze, silver, and gold plans, the lower quartile (Q1) is consistently set at $126.0, likely reflecting customers who made a single claim for Vitamin B+ Advanced Complex (priced at $126), the most popular product that constitutes 31% of all product claims. The gold and platinum plans have slightly higher median values, at $270, indicating that, on average, customers in these higher-tier plans tend to have somewhat larger claims compared to those in the lower-tier plans. Regarding Q3, the value rises as the plan tier increases, though gold customers have a higher Q3 value than platinum customers.  
  
Claims Frequency:  
Platinum customers submit fewer claims overall, but their claim frequency is significantly higher at 0.77 claims per month, suggesting they file claims more frequently during their shorter tenures. In contrast, the other plans have a similar claim frequency of about 0.36 claims per month, meaning those customers would, on average, file 3.6 claims annually.  
  

**How do customer behaviours and plan utilization vary across different plan tiers?**

![Count of](https://github.com/user-attachments/assets/63509069-be1d-438e-8e18-a2c634f15185)  


Customer Retention:   
Gold and silver plans tend to retain customers for a longer period, with the average customer staying for 14 and 13 months, respectively. However, bronze and platinum plans have the lowest retention at 6 months and 5 months respectively. 

Loss Ratio:  
Bronze customers have a high loss ratio of 0.68, meaning for every $1 they pay in premiums they recoup 68 cents through claims, making this group potentially less profitable. In contrast, gold plan members, despite having more claims, have the lowest loss ratio (0.14), indicating they contribute much more in premiums than they receive in claims, which makes them more profitable for the insurer.

Additionally, 666 customers had a loss ratio greater than 1, meaning they are claiming more than the premiums they are paying. In the bronze tier, 21% of customers fall into this category, compared to only 4% in the silver tier, with negligible rates in the other tiers.

Total Premiums Paid vs Total Claimed:  
Silver plan members contributed over $62 million in premiums over the 4-year period, representing 83% of the total premiums paid. However, they also made the highest claims, totalling approximately $3 million, which accounts for 84% of all claims. The gold plan shows a similar pattern but on a smaller scale, with premiums exceeding $12 million. Gold members contributed 16.3% of total premiums, while their claims accounted for only 14%. The platinum plan is the smallest, with both premiums (0.1%) and claims (0%) reflecting the limited number of customers in this tier.  
  

**Are there any notable trends or patterns in product usage based on their chosen plan?**  

  
Bronze plan customers tend to make fewer claims on the same item compared to other plans. On average, bronze members make 1.5 claims per product, while silver and gold members make 2.7 and 4.2 claims, respectively. There are also notable differences in product usage across tiers. For instance, 43% of bronze members claimed the Detox + Debloat Vitamin at least once, compared to around 20% of gold and silver members. Additionally, about 50% of all customers claimed the Vitamin B+ Advanced Complex, with the breakdown by tier being 40% for bronze, 48% for silver, and 47% for gold.  


## Product Performance  


**Which wellness products (e.g., probiotics, vitamins, stress relief supplements) are most frequently claimed?**  

![Row Labels](https://github.com/user-attachments/assets/20fec850-2eba-4910-a976-b4c4121c2458)  
  

Vitamin B+ Complex had the highest number of customers making claims for it. However, Hair Growth Supplement holds the record for the most frequent claims, totalling over 20,000 in four years. While the average product is claimed about 0.8 times per month, Hair Vitamins Trio and Hair Vitamins II Biotin are claimed twice a month on average, with the first product having an average claim amount of $180.  


**How do claim amounts vary across different products?**  

![Claim Amount](https://github.com/user-attachments/assets/3de33bfc-748a-4bd0-96ef-392bc12d9b8b)  

The median cost per product is $171.74, but two products—SuperYou Natural Stress Relief and Detox + Debloat Vitamin—stand out with an average claim value exceeding $300.  

## Next Steps and Recommendations: 
  

**Upsell to Silver Plan:** Develop marketing campaigns aimed at upselling bronze-tier customers to the silver plan. Offering additional coverage or exclusive benefits for silver plan members could encourage more profitable customers to upgrade. This will help reduce the number of high-loss customers in the bronze tier while increasing profitability in the silver tier.  
  

**Customer Retention Initiatives:** Combine efforts with aforementioned recommendation to increase the Customer Lifetime Value of bronze and platinum members. Implement retention efforts for bronze and platinum customers, who have the shortest tenures. Offer wellness incentives to bronze members and personalized services to platinum members. Improving retention in these tiers will reduce churn and increase long-term profitability.  
  

**Grow Platinum Tier:** With only 12 platinum customers, there is limited data available to fully understand the needs and usage behaviour of this group to effectively attract more high-value customers. To drive enrollment, offering a limited-time discount or incentive, such as reduced premiums for the first year or enhanced wellness benefits, could encourage customers from lower tiers to upgrade.  
  

**Conduct A/B Testing for Campaign Effectiveness:** Implement A/B testing to compare different marketing campaigns and identify which are statistically significant in driving signups and engagement across various plan tiers.  
  

**Optimize Email Campaigns:** Although Email generated fewer impressions than SEO, it resulted in more signups and was approximately $5k cheaper, making it a more cost-effective channel. To further capitalize on this, refine email marketing strategies by personalizing content, segmenting audiences, and optimizing send times to increase engagement.  









