connection: "parsely_hearst"

# include all the views
include: "parsely_*.view"

# include all the dashboards
include: "parsely_*.dashboard"

explore: events {
  #sql_always_where: ${parsely_pipeline.ts_action_raw} > TO_DATE('2017-03-21','YYYY-MM-DD') ;;
  description: "Explore hit level data"
  join: user_facts {
    sql_on: ${events.visitor_site_id} = ${user_facts.visitor_site_id} ;;
    relationship: many_to_one
    view_label: "Visitors"
  }

  join:  page_facts {
    sql_on: ${events.article_url} = ${page_facts.article_url} ;;
    relationship: many_to_one
  }

  join:  page_engagement_facts {
    sql_on: ${events.ts_action_raw} = ${page_engagement_facts.pageview_start_raw} and
            ${events.session_id} = ${page_engagement_facts.session_id} and
            ${events.article_url} = ${page_engagement_facts.metadata_canonical_url} and
            ${events.action} = 'pageview';;
    view_label: "Session Page Engagement"
    relationship: one_to_one
  }
}
