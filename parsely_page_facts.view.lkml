view: page_facts {
  ## This derived table is to grab an accurate publish time for each canonical url.
  ## The logic can be replaced depending on how this is defined.
  ## In this case we are defining it as the time of the first pageview.
  derived_table: {
    sql: select
         metadata_title
        , metadata_authors
        , metadata_section
        , metadata_canonical_url
        , metadata_full_content_word_count
        , min(ts_action) as publish_timestamp
      from parsely.rawdata
      where action = 'pageview'
      group by 1,2,3,4,5
       ;;
    # sortkeys: ["publish_timestamp"]
    # distribution_style: all
    # sql_trigger_value: SELECT FLOOR((EXTRACT(epoch from GETDATE()) - 60*60*3)/(60*60*24)) ;;
  }

  dimension: article_url {
    type: string
    primary_key: yes
    sql: ${TABLE}.metadata_canonical_url ;;
  }

  dimension: article_title {
    type: string
    sql: ${TABLE}.metadata_title ;;
  }

  dimension_group: publish {
    type: time
    sql: ${TABLE}.publish_timestamp ;;
    timeframes: [time, hour, hour_of_day, date, week, month, raw]
    view_label: "Page Metadata"
  }

}
