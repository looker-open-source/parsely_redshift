connection: "parsely_hearst"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: events {
  join: visitor_facts {
    sql_on: ${events.visitor_site_id} = ${visitor_facts.visitor_site_id} ;;
    relationship: many_to_one
    view_label: "Visitors"
  }
}
