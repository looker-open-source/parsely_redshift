- connection: parsely_hearst

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: events
  joins: 
  - join: visitor_facts
    sql_on: ${events.visitor_site_id} = ${visitor_facts.visitor_site_id}
    relationship: many_to_one
    view_label: "Visitors"
    