- dashboard: article_summary
  title: Article Overview
  layout: grid
  rows:
    - elements: [distinct_visitors, avg_engage_tm, total_pageviews_1]
      height: 200

    - elements: [daily_metrics]
      height: 400

    - elements: [article_info, referrers]
      height: 400

  filters:

  - name: date
    type: date_filter

  - name: title
    type: field_filter
    explore: events
    field: events.meta_title
    default_value: "What I Know"

  elements:

    - name: distinct_visitors
      title: Distinct Visitors
      type: single_value
      model: parsely_redshift
      explore: events
      measures: [events.visitors]
      listen:
        title: events.meta_title
        date: events.action_date
      sorts: [events.visitors desc]
      limit: 15
      column_limit: 50
      stacking: ''
      show_value_labels: false
      label_density: 25
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      show_null_labels: false
      font_size: small
      width: 3
      height: 2

    - name: avg_engage_tm
      title: Average Engaged Time
      type: single_value
      model: parsely_redshift
      explore: events
      measures: [events.average_engaged_time_per_visitor]
      listen:
        title: events.meta_title
        date: events.action_date
      sorts: [events.average_engaged_time_per_visitor desc]
      limit: 15
      column_limit: 50
      stacking: ''
      show_value_labels: false
      label_density: 25
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      show_null_labels: false
      font_size: small
      width: 3
      height: 2

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

    - name: daily_metrics
      title: Daily Visitors and Pageviews
      type: looker_line
      model: parsely_redshift
      explore: events
      dimensions: [events.action_date]
      measures: [events.visitors, events.pageviews]
      listen:
        title: events.meta_title
        date: events.action_date
      sorts: [events.action_date desc]
      limit: 500
      column_limit: ''
      stacking: ''
      show_value_labels: false
      label_density: 25
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      show_null_points: true
      show_null_labels: false
      y_axis_combined: true
      point_style: none
      interpolation: linear
      colors: ['#388f5b', '#2a85a9']
      width: 12
      height: 3

    - name: article_info
      title: Article Info
      type: looker_single_record
      model: parsely_redshift
      explore: events
      dimensions: [events.meta_title, events.meta_publish_date, events.meta_authors, events.meta_section, events.url]
      listen:
        title: events.meta_title
        date: events.action_date
      sorts: [events.pub_date desc]
      limit: 500
      column_limit: ''
      show_view_names: false
      show_null_labels: false
      stacking: ''
      show_value_labels: false
      label_density: 25
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      show_null_points: true
      y_axis_combined: true
      point_style: none
      interpolation: linear
      colors: ['#388f5b', '#2a85a9']

    - name: referrers
      title: Top 15 External Referrers
      type: looker_bar
      model: parsely_redshift
      explore: events
      dimensions: [events.referrer]
      measures: [events.visitors]
      filters:
        events.referrer: -"arstechnica.com",-EMPTY
      listen:
        title: events.meta_title
        date: events.action_date
      sorts: [events.visitors desc]
      limit: 15
      column_limit: ''
      show_view_names: false
      show_null_labels: false
      stacking: ''
      show_value_labels: false
      label_density: 25
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      show_null_points: true
      y_axis_combined: true
      point_style: none
      interpolation: linear
      colors: ['#2a85a9']
      inner_radius: 50
