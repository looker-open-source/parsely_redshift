view: page_engagement_facts {
  ## This derived table calculates the engaged time based on canonical url, visitor site id, and session id.
  ## It is joined on the first pageview event for the url on each visitor's session.
  ## If there are multiple pageviews for the same session, the engaged time is combined on the first pageview event.
  derived_table: {
    sql: select visitor_site_id
        , session_id
        , metadata_canonical_url
        , min(case when action = 'pageview' then ts_action else null end) as pageview_start_time
        , sum(case when action = 'heartbeat' then engaged_time_inc else 0 end ) as total_engaged_time
      from parsely.rawdata
      group by 1,2,3
       ;;
    # sortkeys: ["session_id"]
    # distribution_style: even
    # sql_trigger_value: SELECT FLOOR((EXTRACT(epoch from GETDATE()) - 60*60*3)/(60*60*24)) ;;
  }

  measure: session_count {
    type: count_distinct
    sql: ${session_id} ||'-' || ${visitor_site_id} ;;
  }

  measure: count {
    type: count
  }

  dimension: visitor_site_id {
    type: string
    hidden:  yes
    sql: ${TABLE}.visitor_site_id ;;
  }

  measure: unique_visitors {
    type: count_distinct
    sql: ${visitor_site_id} ;;
  }

  dimension: session_id {
    type: number
    hidden:  yes
    sql: ${TABLE}.session_id ;;
  }

  dimension: metadata_canonical_url {
    type: string
    hidden:  yes
    sql: ${TABLE}.metadata_canonical_url ;;
  }

  dimension_group: pageview_start {
    type: time
    sql: ${TABLE}.pageview_start_time ;;
    timeframes: [raw, date, hour, week, month, year, time]
  }

  dimension: engaged_time {
    type: number
    sql: ${TABLE}.total_engaged_time ;;
  }

  measure: total_engaged_time {
    type: sum
    sql: ${engaged_time} ;;
  }

  measure: average_engaged_time_per_visitor {
    type: number
    sql: ${total_engaged_time}::float/NULLIF(${unique_visitors},0) ;;
    view_label: "Metrics"
    value_format_name: decimal_2
  }

  dimension: pk {
    sql: concat(${metadata_canonical_url},${TABLE}.pageview_start_time,cast(${session_id} as string),${visitor_site_id}) ;;
    primary_key: yes
    hidden:  yes
  }

  dimension: read_category {
    case: {
      when: {
        label: "Deep Read (at least 30 seconds)"
        sql: ${engaged_time} >= 30 ;;
      }
      when: {
        label: "Read (at least 10 to 30 seconds)"
        sql: ${engaged_time} >= 10 ;;
      }
      when: {
        label: "Skim (less than 10 seconds)"
        sql: ${engaged_time} >=0;;
      }

    }
  }
}
