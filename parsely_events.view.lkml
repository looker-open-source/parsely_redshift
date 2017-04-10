view: events {
  sql_table_name: parsely.rawdata ;;
  dimension: action {
    type: string
    sql: ${TABLE}.action ;;
  }

  dimension: flags {
    type: yesno
    sql: ${TABLE}.flags ;;
  }

  dimension: visitor_geo_city {
    type: string
    group_label: "Location"
    sql: ${TABLE}.ip_city ;;
  }

  dimension: visitor_geo_country {
    type: string
    map_layer_name: countries
    group_label: "Location"
    sql: ${TABLE}.ip_country ;;
  }

  dimension: visitor_geo_state {
    type: string
    group_label: "Location"
    sql: ${TABLE}.ip_subdivision ;;
  }

  dimension: visitor_geo_timezone {
    type: string
    sql: ${TABLE}.ip_timezone ;;
  }

  dimension: visitor_postal {
    type: zipcode
    group_label: "Location"
    sql: ${TABLE}.ip_postal ;;
  }

  dimension: article_author {
    type: string
    group_label: "Article Info"
    sql: ${TABLE}.metadata_authors ;;
  }

  dimension: article_page_type {
    type: string
    group_label: "Article Info"
    sql: ${TABLE}.metadata_page_type ;;
  }

  dimension: article_id {
    type: string
    group_label: "Article Info"
    sql: ${TABLE}.metadata_post_id ;;
  }

  dimension_group: article_publication {
    type: time
    timeframes: [hour, date, week, month, year]
    sql: dateadd(S, ${TABLE}.metadata_pub_date_tmsp/1000, '1970-01-01') ;;
  }

  dimension_group: article_updated {
    type: time
    timeframes: [hour, date, week, month, year]
    sql: ${TABLE}.metadata_save_date_tmsp/1000::float ;;
  }

  dimension: article_section {
    type: string
    group_label: "Article Info"
    sql: ${TABLE}.metadata_section ;;
  }

  #  - dimension: metadata_tags ---currently very messy, combining adnodes, site sections, and tags
  #    type: string
  #    sql: ${TABLE}.metadata_tags

  dimension: article_title {
    type: string
    group_label: "Article Info"
    sql: ${TABLE}.metadata_title ;;
  }

  dimension: article_url {
    type: string
    group_label: "Article Info"
    sql: ${TABLE}.metadata_canonical_url ;;
    suggest_explore: page_facts
    suggest_dimension: article_url
  }

  dimension: referral_source_category {
    group_label: "Referrer Info"
    type: string
    sql: ${TABLE}.ref_category ;;
  }

  dimension: referral_source_url_clean {
    type: string
    group_label: "Referrer Info"
    sql: ${TABLE}.ref_clean ;;
  }

  dimension: referral_source_url_full {
    type: string
    group_label: "Referrer Info"
    sql: ${TABLE}.ref_domain ;;
  }

  ###

  dimension: session {
    type: yesno
    sql: ${TABLE}.session ;;
  }

  dimension: session_id {
    type: number
    sql: ${TABLE}.session_id ;;
  }

  dimension: referrer {
    type: string
    group_label: "Referrer Info"
    sql: ${TABLE}.referrer ;;
  }

  dimension: session_initial_referrer {
    type: string
    group_label: "Referrer Info"
    sql: ${TABLE}.session_initial_referrer ;;
  }

  dimension: session_initial_url {
    type: string
    sql: ${TABLE}.session_initial_url ;;
  }

  dimension_group: session_last_session {
    type: time
    timeframes: [hour, date, week, month, year]
    sql: ${TABLE}.session_last_session_timestamp::float/1000::float ;;
  }

  dimension_group: session {
    type: time
    timeframes: [hour, date, week, month, year]
    sql: ${TABLE}.session_timestamp/1000::float ;;
  }

  dimension: slot {
    type: yesno
    sql: ${TABLE}.slot ;;
  }

  dimension: sref_category {
    type: string
    group_label: "Simple Referrer"
    sql: ${TABLE}.sref_category ;;
  }

  dimension: sref_clean {
    type: string
    group_label: "Simple Referrer"
    sql: ${TABLE}.sref_clean ;;
  }

  dimension: sref_domain {
    type: string
    group_label: "Simple Referrer"
    sql: ${TABLE}.sref_domain ;;
  }

  dimension: sref_fragment {
    type: string
    group_label: "Simple Referrer"
    sql: ${TABLE}.sref_fragment ;;
  }

  dimension: sref_netloc {
    type: string
    group_label: "Simple Referrer"
    sql: ${TABLE}.sref_netloc ;;
  }

  dimension: sref_params {
    type: string
    group_label: "Simple Referrer"
    sql: ${TABLE}.sref_params ;;
  }

  dimension: sref_path {
    type: string
    group_label: "Simple Referrer"
    sql: ${TABLE}.sref_path ;;
  }

  dimension: sref_query {
    type: string
    group_label: "Simple Referrer"
    sql: ${TABLE}.sref_query ;;
  }

  dimension: sref_scheme {
    type: string
    group_label: "Simple Referrer"
    sql: ${TABLE}.sref_scheme ;;
  }

  dimension: surl_clean {
    type: string
    group_label: "Short URL"
    sql: ${TABLE}.surl_clean ;;
  }

  dimension: surl_domain {
    type: string
    group_label: "url"
    sql: ${TABLE}.surl_domain ;;
  }

  dimension: surl_fragment {
    type: string
    group_label: "url"
    sql: ${TABLE}.surl_fragment ;;
  }

  dimension: surl_netloc {
    type: string
    group_label: "url"
    sql: ${TABLE}.surl_netloc ;;
  }

  dimension: surl_params {
    type: string
    group_label: "url"
    sql: ${TABLE}.surl_params ;;
  }

  dimension: surl_path {
    type: string
    group_label: "url"
    sql: ${TABLE}.surl_path ;;
  }

  dimension: surl_query {
    type: string
    group_label: "url"
    sql: ${TABLE}.surl_query ;;
  }

  dimension: surl_scheme {
    type: string
    group_label: "url"
    sql: ${TABLE}.surl_scheme ;;
  }

  ###

  dimension: visitor_browser {
    type: string
    group_label: "Device Info"
    sql: ${TABLE}.ua_browser ;;
  }

  dimension: visitor_device {
    type: string
    group_label: "Device Info"
    sql: ${TABLE}.ua_device ;;
  }

  dimension: visitor_devicebrand {
    type: string
    group_label: "Device Info"
    sql: ${TABLE}.ua_devicebrand ;;
  }

  dimension: visitor_devicemodel {
    type: string
    group_label: "Device Info"
    sql: ${TABLE}.ua_devicemodel ;;
  }

  dimension: visitor_device_type {
    type: string
    group_label: "Device Info"
    sql: ${TABLE}.ua_devicetype ;;
  }

  dimension: visitor_os {
    type: string
    group_label: "Device Info"
    sql: ${TABLE}.ua_os ;;
  }

  ### not sure what to do with this:

  dimension: url {
    type: string
    group_label: "Page Info"
    sql: ${TABLE}.url ;;
  }

  dimension: url_clean {
    type: string
    group_label: "Page Info"
    sql: ${TABLE}.url_clean ;;
  }

  dimension: url_domain {
    type: string
    group_label: "Page Info"
    sql: ${TABLE}.url_domain ;;
  }

  dimension: url_fragment {
    type: string
    group_label: "Page Info"
    sql: ${TABLE}.url_fragment ;;
  }

  dimension: url_netloc {
    type: string
    group_label: "Page Info"
    sql: ${TABLE}.url_netloc ;;
  }

  dimension: url_params {
    type: string
    group_label: "Page Info"
    sql: ${TABLE}.url_params ;;
  }

  dimension: url_path {
    type: string
    group_label: "Page Info"
    sql: ${TABLE}.url_path ;;
  }

  dimension: url_query {
    type: string
    group_label: "Page Info"
    sql: ${TABLE}.url_query ;;
  }

  dimension: url_scheme {
    type: string
    group_label: "Page Info"
    sql: ${TABLE}.url_scheme ;;
  }

  dimension: user_agent {
    type: string
    group_label: "Device Info"
    sql: ${TABLE}.user_agent ;;
  }

  dimension: version {
    type: number
    group_label: "Device Info"
    sql: ${TABLE}.version ;;
  }

  ###

  dimension: visitor {
    type: yesno
    sql: ${TABLE}.visitor ;;
  }

  dimension: visitor_ip {
    type: string
    sql: ${TABLE}.visitor_ip ;;
  }

  dimension: visitor_network_id {
    type: string
    sql: ${TABLE}.visitor_network_id ;;
  }

  dimension: visitor_site_id {
    type: number
    sql: ${TABLE}.visitor_site_id ;;
  }

  dimension: hours_since_publish_date {
    type:  number
    sql:  DATEDIFF(hr,${page_facts.publish_raw},${ts_action_raw}) ;;
  }

  measure: total_engaged_time {
    type: sum
    sql: ${TABLE}.engaged_time_inc::float/60::float ;;
  }

  measure: unique_visitors {
    type: count_distinct
    sql: ${TABLE}.visitor_site_id ;;
  }

  measure: page_views {
    type: count
    filters: {
      field: action
      value: "pageview"
    }
  }

  measure: article_duration {
    type: sum
    sql: ${TABLE}.metadata_duration ;;
  }

  measure: total_article_word_count {
    type: sum
    sql: ${article_word_count} ;;
  }

  dimension: article_word_count {
    type: number
    sql: ${TABLE}.metadata_full_content_word_count ;;
  }

  dimension: article_word_count_tier {
    type: tier
    sql: ${article_word_count};;
    tiers: [100,500,1000,1500,2000,2500,3000,3500,4000]
    style:  integer
    view_label: "Page Metadata"
  }

  measure: articles_published {
    type: count_distinct
    sql: ${TABLE}.metadata_post_id ;;
  }

  measure: pageviews {
    type: count

    filters: {
      field: action
      value: "pageview"
    }

    view_label: "Metrics"
  }

  measure: page_views_mobile {
    type: count

    filters: {
      field: action
      value: "pageview"
    }

    filters: {
      field: visitor_device_type
      value: "mobile"
    }

    view_label: "Metrics"
  }

  measure: page_views_tablet {
    type: count

    filters: {
      field: action
      value: "pageview"
    }

    filters: {
      field: visitor_device_type
      value: "tablet"
    }

    view_label: "Metrics"
  }

  measure: page_views_desktop {
    type: count

    filters: {
      field: action
      value: "pageview"
    }

    filters: {
      field: visitor_device_type
      value: "desktop"
    }

    view_label: "Metrics"
  }

  measure: page_views_other {
    type: count

    filters: {
      field: action
      value: "pageview"
    }

    filters: {
      field: visitor_device_type
      value: "other"
    }

    view_label: "Metrics"
    drill_fields: [url_clean, pageviews]
  }

  measure: average_page_views_per_post {
    type: number
    sql: ${pageviews}/NULLIF(${post_count},0) ;;
    view_label: "Metrics"
    value_format_name: decimal_1
  }

  measure: post_count {
    type: count_distinct
    sql: ${article_url} ;;
    view_label: "Metrics"
  }

  measure: network_visitors {
    type: count_distinct
    sql: ${visitor_network_id} ;;
    view_label: "Metrics"
  }

  measure: average_engaged_time_per_visitor {
    type: number
    sql: ${total_engaged_time}::float/NULLIF(${unique_visitors},0) ;;
    view_label: "Metrics"
    value_format_name: decimal_2
  }

  measure: session_count {
    type: count_distinct
    sql: ${session_id} ||'-' || ${visitor_site_id} ;;
    view_label: "Metrics"
  }

  dimension_group: current_session {
    type: time
    timeframes: [raw, hour, date, week, month, year]
    sql: ${TABLE}.ts_session_current ;;
  }

  dimension_group: last_session {
    type: time
    timeframes: [raw, hour, date, week, month, year]
    sql: ${TABLE}.ts_session_last ;;
  }

  dimension_group: ts_action {
    type: time
    timeframes: [raw, hour, date, week, month, year]
    sql: ${TABLE}.ts_action ;;
  }

  dimension: visitor_operating_system {
    type: string
    group_label: "Device Info"
    sql: ${TABLE}.ua_os ;;
  }

  dimension: flag_returning_visitor {
    type: yesno
    sql: case when ${TABLE}.session_last_session_timestamp = 0 then FALSE when (dateadd(S, ${TABLE}.session_timestamp/1000, '1970-01-01')::date - dateadd(S, ${TABLE}.session_last_session_timestamp/1000, '1970-01-01')::date) <= 30 then TRUE else FALSE end ;;
  }

  dimension: flag_paid_traffic {
    type: yesno
    sql: case when ${TABLE}.surl_query like '%kwfacebook%' or surl_query like '%socialedge%' then TRUE ELSE FALSE end ;;
  }

  dimension: flag_newsletter_traffic {
    type: yesno
    sql: case when ${TABLE}.surl_query like '%newsletter%' then TRUE ELSE FALSE end ;;
  }

  dimension: flag_us_only_flag {
    type: yesno
    sql: case when ${TABLE}.ip_country = 'US' then TRUE ELSE FALSE end ;;
  }

  measure: visits {
    type: count_distinct
    sql: ${TABLE}.session_id ;;
  }

  measure: max_article_word_count {
    type: max
    sql: ${TABLE}.metadata_full_content_word_count ;;
  }
}
