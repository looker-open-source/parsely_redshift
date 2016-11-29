view: visitor_facts {
  derived_table: {
    sql: WITH a AS (SELECT distinct events.visitor_site_id AS visitor_site_id,
       first_value(ref_domain IGNORE NULLS) over (partition by visitor_site_id order by ts_session_current rows between unbounded preceding and unbounded following) first_referrer
      FROM parsely.rawdata AS events
      WHERE ref_domain <> '')

      SELECT events.visitor_site_id as visitor_site_id,
              first_referrer,
              min(events.ts_session_current) AS first_session_date,
              max(events.ts_session_current) AS latest_session_date,
              COUNT(CASE WHEN (events.action = 'pageview') THEN 1 ELSE NULL END) AS total_pageviews,
              COUNT(DISTINCT events.session_id ||'-' || events.visitor_site_id) AS session_count,
              COALESCE(SUM(events.engaged_time_inc), 0) AS total_engaged_time,
              COUNT(DISTINCT events.meta_canonical_url) AS post_count
            FROM parsely.rawdata AS events
            LEFT JOIN a ON a.visitor_site_id = events.visitor_site_id
      GROUP BY 1,2
       ;;
  }

  dimension: visitor_site_id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.visitor_site_id ;;
  }

  dimension: first_referrer {
    type: string
    sql: first_referrer ;;
  }

  dimension_group: first_session {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.first_session_date ;;
  }

  dimension_group: latest_session {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.latest_session_date ;;
  }

  dimension: total_pageviews {
    type: number
    sql: ${TABLE}.total_pageviews ;;
  }

  dimension: session_count {
    type: number
    sql: ${TABLE}.session_count ;;
  }

  dimension: session_count_tier {
    type: tier
    sql: ${session_count} ;;
    tiers: [1, 2, 3, 5, 10, 20]
    style: integer
  }

  dimension: total_engaged_time {
    type: number
    sql: ${TABLE}.total_engaged_time ;;
  }

  dimension: post_count {
    type: number
    sql: ${TABLE}.post_count ;;
  }

  set: detail {
    fields: [visitor_site_id, first_session_date, latest_session_date, total_pageviews, session_count, total_engaged_time, post_count]
  }
}
