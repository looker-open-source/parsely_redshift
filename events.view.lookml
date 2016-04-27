- view: events
  sql_table_name: parsely.rawdata
  fields:

  - dimension: action
    type: string
    sql: ${TABLE}.action

  - dimension: apikey
    type: string
    sql: ${TABLE}.apikey

  - dimension: display_avail_height
    type: number
    sql: ${TABLE}.display_avail_height

  - dimension: display_avail_width
    type: number
    sql: ${TABLE}.display_avail_width

  - dimension: display_pixel_depth
    type: number
    sql: ${TABLE}.display_pixel_depth

  - dimension: display_total_height
    type: number
    sql: ${TABLE}.display_total_height

  - dimension: display_total_width
    type: number
    sql: ${TABLE}.display_total_width

  - dimension: engaged_time_inc
    type: number
    sql: ${TABLE}.engaged_time_inc

  - dimension: extra_data
    type: string
    sql: ${TABLE}.extra_data

  - dimension: ip_country
    type: string
    sql: ${TABLE}.ip_country
    view_label: "IP"

  - dimension: ip_latitude
    type: number
    hidden: true
    sql: ${TABLE}.ip_lat
    view_label: "IP"

  - dimension: ip_longitude
    type: number
    hidden: true
    sql: ${TABLE}.ip_lon
    view_label: "IP"
  
  - dimension: ip_location
    type: location
    sql_latitude: ${ip_latitude}
    sql_longitude: ${ip_longitude}
    view_label: "IP"

  - dimension: ip_zipcode
    type: string
    sql: ${TABLE}.ip_zipcode
    view_label: "IP"

  - dimension: meta_authors
    type: string
    sql: ${TABLE}.meta_authors

  - dimension: meta_canonical_url
    type: string
    sql: ${TABLE}.meta_canonical_url

  - dimension: meta_image_url
    type: string
    sql: ${TABLE}.meta_image_url

  - dimension_group: meta_publish
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.meta_pub_date

  - dimension: meta_section
    type: string
    sql: ${TABLE}.meta_section

  - dimension: meta_tags
    type: string
    sql: ${TABLE}.meta_tags

  - dimension: meta_title
    type: string
    sql: ${TABLE}.meta_title

  - dimension: referrer_clean
    type: string
    sql: ${TABLE}.ref_clean

  - dimension: referrer_domain
    type: string
    sql: ${TABLE}.ref_domain

  - dimension: referrer_path
    type: string
    sql: ${TABLE}.ref_path

  - dimension: referrer
    type: string
    sql: ${TABLE}.referrer

  - dimension: session_id
    type: string
    sql: ${TABLE}.session_id

  - dimension: session_initial_referrer
    type: string
    sql: ${TABLE}.session_initial_referrer

  - dimension: session_initial_url
    type: string
    sql: ${TABLE}.session_initial_url

  - dimension: session_last_session_timestamp
    type: string
    sql: ${TABLE}.session_last_session_timestamp

  - dimension: session_timestamp
    type: string
    sql: ${TABLE}.session_timestamp

  - dimension_group: action
    type: time
    timeframes: [time, hour, hour_of_day, date, week, month]
    sql: ${TABLE}.ts_action

  - dimension_group: session_current
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.ts_session_current

  - dimension_group: session_last
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.ts_session_last
  
  - dimension: days_since_last_visit
    type: number
    sql: ${session_current_date} - ${session_last_date}

  - dimension: user_agent_browser
    type: string
    sql: ${TABLE}.ua_browser

  - dimension: user_agent_devicebrand
    type: string
    sql: ${TABLE}.ua_devicebrand

  - dimension: user_agent_devicemodel
    type: string
    sql: ${TABLE}.ua_devicemodel

  - dimension: user_agent_devicetype
    type: string
    sql: ${TABLE}.ua_devicetype

  - dimension: user_agent_os
    type: string
    sql: ${TABLE}.ua_os

  - dimension: url
    type: string
    sql: ${TABLE}.url

  - dimension: url_clean
    type: string
    sql: ${TABLE}.url_clean

  - dimension: url_domain
    type: string
    sql: ${TABLE}.url_domain

  - dimension: url_path
    type: string
    sql: ${TABLE}.url_path

  - dimension: user_agent
    type: string
    sql: ${TABLE}.user_agent

  - dimension: utm_campaign
    type: string
    sql: ${TABLE}.utm_campaign

  - dimension: utm_content
    type: string
    sql: ${TABLE}.utm_content

  - dimension: utm_medium
    type: string
    sql: ${TABLE}.utm_medium

  - dimension: utm_source
    type: string
    sql: ${TABLE}.utm_source

  - dimension: utm_term
    type: string
    sql: ${TABLE}.utm_term

  - dimension: visitor_ip
    type: string
    sql: ${TABLE}.visitor_ip

  - dimension: visitor_network_id
    type: string
    sql: ${TABLE}.visitor_network_id

  - dimension: visitor_site_id
    type: string
    sql: ${TABLE}.visitor_site_id

  - measure: count
    type: count
    drill_fields: []
  
  - measure: pageview_count
    type: count
    filter: 
      action: pageview
  
  - measure: visitor_count
    type: count_distinct
    sql: ${visitor_site_id}
  
  - measure: network_visitor_count
    type: count_distinct
    sql: ${visitor_network_id}
  
  - measure: total_engaged_time
    type: sum
    sql: ${engaged_time_inc}
  
  - measure: average_engaged_time_per_visitor
    type: number
    sql: ${total_engaged_time}::float/NULLIF(${visitor_count},0)
  
  - measure: number_of_articles
    type: count_distinct 
    sql: ${meta_canonical_url}
  
  - measure: session_count
    type: count_distinct
    sql: ${session_id} || '-' || ${visitor_site_id}

