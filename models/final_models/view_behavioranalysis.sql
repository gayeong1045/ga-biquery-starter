{{
    config(
        materialized='table'
    )
}}

with account_ga_join as (
    select
        sa.accounts_user_id, 
        sa.accounts_user_password,
        sa.accounts_user_last_login,
        sa.accounts_user_email,
        sa.accounts_user_first_name,
        sa.accounts_user_last_name,
        sa.accounts_user_is_active,
        sa.accounts_user_is_staff,
        sa.accounts_user_is_admin,
        sa.accounts_user_is_superuser,
        sa.accounts_user_date_joined,
        sa.accounts_user_created_at,
        sa.accounts_user_updated_at,
        sa.accounts_user_sns_type,
        sa.accounts_profile_id,
        sa.accounts_profile_company,
        sa.accounts_profile_team,
        sa.accounts_profile_position,
        sa.accounts_profile_category,
        sa.accounts_profile_created_at,
        sa.accounts_profile_updated_at,
        sa.accounts_profile_license,
        sa.accounts_profile_phone_number,
        sa.accounts_profile_marketing_info,
        sa.accounts_profile_private_info,
        sa.accounts_profile_service_info,
        sa.accounts_profile_level,
        ga.event_time,
        ga.match_user_id,
        ga.event_id,
        ga.user_pseudo_id,
        ga.user_id as ga_user_id,
        ga.event_date,
        ga.event_name,     
        ga.ga_session_id,
        ga.engagement_time_msec,
        ga.percent_scrolled,        
        ga.page_location,
        ga.page_referrer,
        ga.traffic_source_name,
        ga.traffic_source_medium,
        ga.traffic_source_site,
        ga.device_category,
        ga.device_operating_system,
        ga.device_web_info_browser,
        ga.geo_country,
        ga.geo_region,
        ga.geo_city,
    from {{ ref('stg_maderi_accounts') }} sa
    left join {{ ref('view_trafficanalysis') }} ga on sa.user_id = ga.match_user_id
),

account_kewyword_join as (
    select
        sa.accounts_user_id, 
        sa.accounts_user_password,
        sa.accounts_user_last_login,
        sa.accounts_user_email,
        sa.accounts_user_first_name,
        sa.accounts_user_last_name,
        sa.accounts_user_is_active,
        sa.accounts_user_is_staff,
        sa.accounts_user_is_admin,
        sa.accounts_user_is_superuser,
        sa.accounts_user_date_joined,
        sa.accounts_user_created_at,
        sa.accounts_user_updated_at,
        sa.accounts_user_sns_type,
        sa.accounts_profile_id,
        sa.accounts_profile_company,
        sa.accounts_profile_team,
        sa.accounts_profile_position,
        sa.accounts_profile_category,
        sa.accounts_profile_created_at,
        sa.accounts_profile_updated_at,
        sa.accounts_profile_license,
        sa.accounts_profile_phone_number,
        sa.accounts_profile_marketing_info,
        sa.accounts_profile_private_info,
        sa.accounts_profile_service_info,
        sa.accounts_profile_level,
        a.t_user_keyword_created_at,
        a.user_id,
        a.t_user_keyword_keyword_name,
        a.t_user_keyword_synonym,
        a.t_user_keyword_exclusion_word,
        a.t_user_keyword_is_own, 
    from {{ ref('stg_maderi_accounts') }} sa
    left join {{ref('stg_maderi_userkeyword')}} a on sa.user_id = a.user_id
),

account_ch_join as (
    select
        sa.accounts_user_id, 
        sa.accounts_user_password,
        sa.accounts_user_last_login,
        sa.accounts_user_email,
        sa.accounts_user_first_name,
        sa.accounts_user_last_name,
        sa.accounts_user_is_active,
        sa.accounts_user_is_staff,
        sa.accounts_user_is_admin,
        sa.accounts_user_is_superuser,
        sa.accounts_user_date_joined,
        sa.accounts_user_created_at,
        sa.accounts_user_updated_at,
        sa.accounts_user_sns_type,
        sa.accounts_profile_id,
        sa.accounts_profile_company,
        sa.accounts_profile_team,
        sa.accounts_profile_position,
        sa.accounts_profile_category,
        sa.accounts_profile_created_at,
        sa.accounts_profile_updated_at,
        sa.accounts_profile_license,
        sa.accounts_profile_phone_number,
        sa.accounts_profile_marketing_info,
        sa.accounts_profile_private_info,
        sa.accounts_profile_service_info,
        sa.accounts_profile_level,
        b.t_ch_user_data_created_at,     -- t_ch_user_data의 time은 DATETIME 자료형으로 TIMESTAMP로 형변환
        b.user_id,
        b.t_ch_user_data_ch_id,
        b.t_ch_user_data_is_own,
        b.t_ch_user_data_sns_type,
    from {{ ref('stg_maderi_accounts') }} sa 
    left join {{ref('stg_maderi_userch')}} b on sa.user_id = b.user_id
),

account_history_join as (
    select
        sa.accounts_user_id, 
        sa.accounts_user_password,
        sa.accounts_user_last_login,
        sa.accounts_user_email,
        sa.accounts_user_first_name,
        sa.accounts_user_last_name,
        sa.accounts_user_is_active,
        sa.accounts_user_is_staff,
        sa.accounts_user_is_admin,
        sa.accounts_user_is_superuser,
        sa.accounts_user_date_joined,
        sa.accounts_user_created_at,
        sa.accounts_user_updated_at,
        sa.accounts_user_sns_type,
        sa.accounts_profile_id,
        sa.accounts_profile_company,
        sa.accounts_profile_team,
        sa.accounts_profile_position,
        sa.accounts_profile_category,
        sa.accounts_profile_created_at,
        sa.accounts_profile_updated_at,
        sa.accounts_profile_license,
        sa.accounts_profile_phone_number,
        sa.accounts_profile_marketing_info,
        sa.accounts_profile_private_info,
        sa.accounts_profile_service_info,
        sa.accounts_profile_level,
        c.accounts_loginhistory_created_at,             -- accounts_loginhistory의 time값은 TIMESTAMP 자료형
        c.user_id,
    from {{ ref('stg_maderi_accounts') }} sa 
    left join {{ ref('stg_maderi_accountshistory') }} c on sa.user_id = c.user_id
),

account_payment_join as (
    select
        sa.accounts_user_id, 
        sa.accounts_user_password,
        sa.accounts_user_last_login,
        sa.accounts_user_email,
        sa.accounts_user_first_name,
        sa.accounts_user_last_name,
        sa.accounts_user_is_active,
        sa.accounts_user_is_staff,
        sa.accounts_user_is_admin,
        sa.accounts_user_is_superuser,
        sa.accounts_user_date_joined,
        sa.accounts_user_created_at,
        sa.accounts_user_updated_at,
        sa.accounts_user_sns_type,
        sa.accounts_profile_id,
        sa.accounts_profile_company,
        sa.accounts_profile_team,
        sa.accounts_profile_position,
        sa.accounts_profile_category,
        sa.accounts_profile_created_at,
        sa.accounts_profile_updated_at,
        sa.accounts_profile_license,
        sa.accounts_profile_phone_number,
        sa.accounts_profile_marketing_info,
        sa.accounts_profile_private_info,
        sa.accounts_profile_service_info,
        sa.accounts_profile_level,
        d.t_payment_history_event_at,    -- t_payment_history_event_at은 STRING 자료형이므로 TIMESTAMP로 형변환
        d.user_id,
        d.t_payment_history_amount,
        d.t_payment_history_name,
        d.t_payment_history_status,
    from {{ ref('stg_maderi_accounts') }} sa 
    left join {{ref('stg_maderi_paymenthistory')}} d on sa.user_id = d.user_id
),

-- join 후 union all

union_all as (
    select
        event_time as TIME,                  -- TIME column으로 차후 모든 테이블의 time 값을 한 column에 묶어줌
                                                    -- ga의 evnet_time은 TIMESTAMP 자료형
        match_user_id as userID,             -- ga 데이터의 user_id와 구분을 위해 userID로 column명 변경
        accounts_user_id, 
        accounts_user_password,
        accounts_user_last_login,
        accounts_user_email,
        accounts_user_first_name,
        accounts_user_last_name,
        accounts_user_is_active,
        accounts_user_is_staff,
        accounts_user_is_admin,
        accounts_user_is_superuser,
        accounts_user_date_joined,
        accounts_user_created_at,
        accounts_user_updated_at,
        accounts_user_sns_type,
        accounts_profile_id,
        accounts_profile_company,
        accounts_profile_team,
        accounts_profile_position,
        accounts_profile_category,
        accounts_profile_created_at,
        accounts_profile_updated_at,
        accounts_profile_license,
        accounts_profile_phone_number,
        accounts_profile_marketing_info,
        accounts_profile_private_info,
        accounts_profile_service_info,
        accounts_profile_level,
        event_id,
        user_pseudo_id,
        ga_user_id,
        event_date,
        event_name,     
        ga_session_id,
        engagement_time_msec,
        percent_scrolled,        
        page_location,
        page_referrer,
        traffic_source_name,
        traffic_source_medium,
        traffic_source_site,
        device_category,
        device_operating_system,
        device_web_info_browser,
        geo_country,
        geo_region,
        geo_city,
        NULL as t_user_keyword_name,            -- ga 데이터가 아닌 column은 NULL 처리 후 alias로 column명 지정
        NULL as t_user_keyword_synonym,
        NULL as t_user_keyword_exclusion_word,
        NULL as t_user_keyword_is_own,
        NULL as t_ch_user_data_ch_id,
        NULL as t_ch_user_data_is_own,
        NULL as t_ch_user_data_sns_type,
        NULL as t_payment_history_amount,
        NULL as t_payment_history_name,
        NULL as t_payment_history_status,
        CASE                                    -- user_id를 통해 직원/고객 구분
            when match_user_id in (select user_id from {{ ref('inter_accounts_employeeinfo') }}) then 'employee'
            else 'customer'
        END AS is__employee,
       'GA'as discriminator
    from account_ga_join

    UNION ALL

    select
        t_user_keyword_created_at,            -- t_user_keyword의 time값은 TIMESTAMP 자료형
        user_id,
        accounts_user_id, 
        accounts_user_password,
        accounts_user_last_login,
        accounts_user_email,
        accounts_user_first_name,
        accounts_user_last_name,
        accounts_user_is_active,
        accounts_user_is_staff,
        accounts_user_is_admin,
        accounts_user_is_superuser,
        accounts_user_date_joined,
        accounts_user_created_at,
        accounts_user_updated_at,
        accounts_user_sns_type,
        accounts_profile_id,
        accounts_profile_company,
        accounts_profile_team,
        accounts_profile_position,
        accounts_profile_category,
        accounts_profile_created_at,
        accounts_profile_updated_at,
        accounts_profile_license,
        accounts_profile_phone_number,
        accounts_profile_marketing_info,
        accounts_profile_private_info,
        accounts_profile_service_info,
        accounts_profile_level, 
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,  
        t_user_keyword_keyword_name,
        t_user_keyword_synonym,
        t_user_keyword_exclusion_word,
        t_user_keyword_is_own,
        NULL, 
        NULL, 
        'keyword',
        NULL,
        NULL,
        NULL,
        CASE
            when user_id in (select user_id from {{ ref('inter_accounts_employeeinfo') }}) then 'employee'
            else 'customer'
        END,
        't_user_keyword'
    from account_kewyword_join

    UNION ALL

    select
        cast(t_ch_user_data_created_at as timestamp),     -- t_ch_user_data의 time은 DATETIME 자료형으로 TIMESTAMP로 형변환
        user_id,                                              -- UNION하는 table의 time값의 대다수가 TIMESTAMP 자료형이므로 현재는 TIMESTAMP로 통일
        accounts_user_id, 
        accounts_user_password,
        accounts_user_last_login,
        accounts_user_email,
        accounts_user_first_name,
        accounts_user_last_name,
        accounts_user_is_active,
        accounts_user_is_staff,
        accounts_user_is_admin,
        accounts_user_is_superuser,
        accounts_user_date_joined,
        accounts_user_created_at,
        accounts_user_updated_at,
        accounts_user_sns_type,
        accounts_profile_id,
        accounts_profile_company,
        accounts_profile_team,
        accounts_profile_position,
        accounts_profile_category,
        accounts_profile_created_at,
        accounts_profile_updated_at,
        accounts_profile_license,
        accounts_profile_phone_number,
        accounts_profile_marketing_info,
        accounts_profile_private_info,
        accounts_profile_service_info,
        accounts_profile_level,                                             
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        t_ch_user_data_ch_id,
        t_ch_user_data_is_own,
        t_ch_user_data_sns_type,
        NULL,
        NULL,
        NULL,
        CASE
            when user_id in (select user_id from {{ ref('inter_accounts_employeeinfo') }}) then 'employee'
            else 'customer'
        END,
        't_ch_user_data' 
    from account_ch_join

    UNION ALL
        
    select
        accounts_loginhistory_created_at,             -- accounts_loginhistory의 time값은 TIMESTAMP 자료형
        user_id,
        accounts_user_id, 
        accounts_user_password,
        accounts_user_last_login,
        accounts_user_email,
        accounts_user_first_name,
        accounts_user_last_name,
        accounts_user_is_active,
        accounts_user_is_staff,
        accounts_user_is_admin,
        accounts_user_is_superuser,
        accounts_user_date_joined,
        accounts_user_created_at,
        accounts_user_updated_at,
        accounts_user_sns_type,
        accounts_profile_id,
        accounts_profile_company,
        accounts_profile_team,
        accounts_profile_position,
        accounts_profile_category,
        accounts_profile_created_at,
        accounts_profile_updated_at,
        accounts_profile_license,
        accounts_profile_phone_number,
        accounts_profile_marketing_info,
        accounts_profile_private_info,
        accounts_profile_service_info,
        accounts_profile_level,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,  
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        CASE
            when user_id in (select user_id from {{ ref('inter_accounts_employeeinfo') }}) then 'employee'
            else 'customer'
        END,
        'accounts_loginhistory'
    from account_history_join

    UNION ALL

    select
        cast(t_payment_history_event_at as timestamp),    -- t_payment_history_event_at은 STRING 자료형이므로 TIMESTAMP로 형변환
        user_id,
        accounts_user_id, 
        accounts_user_password,
        accounts_user_last_login,
        accounts_user_email,
        accounts_user_first_name,
        accounts_user_last_name,
        accounts_user_is_active,
        accounts_user_is_staff,
        accounts_user_is_admin,
        accounts_user_is_superuser,
        accounts_user_date_joined,
        accounts_user_created_at,
        accounts_user_updated_at,
        accounts_user_sns_type,
        accounts_profile_id,
        accounts_profile_company,
        accounts_profile_team,
        accounts_profile_position,
        accounts_profile_category,
        accounts_profile_created_at,
        accounts_profile_updated_at,
        accounts_profile_license,
        accounts_profile_phone_number,
        accounts_profile_marketing_info,
        accounts_profile_private_info,
        accounts_profile_service_info,
        accounts_profile_level,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,  
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        t_payment_history_amount,
        t_payment_history_name,
        t_payment_history_status,
        CASE
            when user_id in (select user_id from {{ ref('inter_accounts_employeeinfo') }}) then 'employee'
            else 'customer'
        END,
         't_payment_history'
    from account_payment_join
)

select *
from union_all ua left join {{ ref('cal_accounts_loginsegment') }} le
on ua.userID = le.userID_account
