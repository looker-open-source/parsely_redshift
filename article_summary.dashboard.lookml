- dashboard: article_summary
  title: Article Overview
  layout: grid
  rows:
    - elements: [total_pageviews_1]
      height: 200

  filters:
  
  - name: date
    type: date_filter
  
  - name: title
    type: field_filter
    explore: events
    field: events.meta_title
    default_value: "What I Know"
  
  elements:
  
    - name: total_pageviews_1
      title: Total Pageviews
      type: single_value
      model: parsely_redshift
      explore: events
      measures: [events.pageviews]
      sorts: [events.pageviews desc]
      limit: 500
      font_size: medium
      text_color: black
      listen: 
        date: events.action_date
        title: events.meta_title