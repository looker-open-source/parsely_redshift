- dashboard: article_summary
  title: Article Overview
  layout: grid
  rows:
    - elements: [article_info]
      height: 200

    - elements: [distinct_unique_visitors, avg_engage_tm, total_pageviews_1]
      height: 200

    - elements: [daily_metrics, hourly_performance]
      height: 400

    - elements: [referrers, pvs_by_visitor_category, reads_by_session_breakdown]
      height: 400

  filters:

  - name: date
    type: date_filter

  - name: title
    type: field_filter
    explore: events
    field: events.article_title
    default_value: "30 Questions for Pepsi About Its Protest Imagery-Inspired Soda Commercial"

  - name: canonical_url
    type: field_filter
    explore: events
    field: events.article_url
    #default_value: "http://www.slate.com/blogs/browbeat/2017/04/03/rachel_maddow_speaks_out_on_that_trump_tax_returns_fiasco.html"

  elements:

    - name: distinct_unique_visitors
      title: Distinct unique_visitors
      type: single_value
      model: parsely
      explore: events
      measures: [events.unique_visitors]
      listen:
        title: events.article_title
        date: events.ts_action_date
        canonical_url: events.article_url
      sorts: [events.unique_visitors desc]
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
      title: Average Engaged Time (seconds)
      type: single_value
      model: parsely
      explore: events
      measures: [page_engagement_facts.average_engaged_time_per_visitor]
      listen:
        title: events.article_title
        date: events.ts_action_date
        canonical_url: events.article_url
      sorts: [page_engagement_facts.average_engaged_time_per_visitor desc]
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
      model: parsely
      explore: events
      measures: [events.page_views]
      sorts: [events.page_views desc]
      limit: 500
      font_size: medium
      text_color: black
      listen:
        date: events.ts_action_date
        title: events.article_title
        canonical_url: events.article_url

    - name: daily_metrics
      title: Daily unique_visitors and Pageviews
      type: looker_line
      model: parsely
      explore: events
      dimensions: [events.ts_action_date]
      measures: [events.unique_visitors, events.page_views]
      listen:
        title: events.article_title
        date: events.ts_action_date
        canonical_url: events.article_url
      sorts: [events.ts_action_date desc]
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
      model: parsely
      explore: events
      dimensions: [events.article_title, page_facts.publish_date, events.article_author, events.article_section, events.article_url, events.article_word_count]
      listen:
        title: events.article_title
        date: events.ts_action_date
        canonical_url: events.article_url
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
      model: parsely
      explore: events
      dimensions: [events.sref_domain]
      measures: [events.unique_visitors]
      filters:
        events.referrer: -"arstechnica.com",-EMPTY
      listen:
        title: events.article_title
        date: events.ts_action_date
        canonical_url: events.article_url
      sorts: [events.unique_visitors desc]
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

    - name: reads_by_session_breakdown
      title: Reads by Session Breakdown
      type: looker_pie
      model: parsely
      explore: events
      dimensions: [page_engagement_facts.read_category]
      measures: [page_engagement_facts.count]
      filters:
        page_engagement_facts.read_category: -NULL
      listen:
        title: events.article_title
        date: events.ts_action_date
        canonical_url: events.article_url
      sorts: [page_engagement_facts.read_category]
      limit: '500'
      column_limit: '50'
      total: true
      query_timezone: America/New_York
      value_labels: legend
      label_type: labPer
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      limit_displayed_rows: false
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      series_types: {}
      colors: 'palette: Mixed Dark'
      series_colors:
        Deep Read (at least 30 seconds): "#2a85a9"
        Read (at least 10 to 30 seconds): "#33a02c"
        Skim (less than 10 seconds): "#b2df8a"
      series_labels: {}
      inner_radius: 30

    - name: hourly_performance
      title: Hourly Performance (For First 72 Hours Since Published)
      type: looker_line
      model: parsely
      explore: events
      dimensions: [events.hours_since_publish_date]
      measures: [events.unique_visitors, page_engagement_facts.average_engaged_time_per_visitor]
      listen:
        title: events.article_title
        date: events.ts_action_date
        canonical_url: events.article_url
      filters:
        events.hours_since_publish_date: "<73"
      sorts: [events.hours_since_publish_date]
      limit: '500'
      column_limit: '50'
      query_timezone: America/New_York
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      limit_displayed_rows: false
      y_axis_combined: false
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: ordinal
      y_axis_scale_mode: linear
      show_null_points: true
      point_style: none
      interpolation: linear
      value_labels: legend
      label_type: labPer
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      series_types:
        events.average_engaged_time_per_visitor: area
        events.unique_visitors: column
      colors: ['palette: Mixed Dark']
      series_colors:
        events.unique_visitors: "#1f78b4"
        events.average_engaged_time_per_visitor: "#a6cee3"
      series_labels: {}
      inner_radius: 30
      y_axis_orientation: [left, right]

    - name: pvs_by_visitor_category
      title: Pageviews by Visitor Category
      type: looker_pie
      model: parsely
      explore: events
      dimensions: [user_facts.session_count_tier]
      measures: [events.page_views]
      listen:
        title: events.article_title
        date: events.ts_action_date
        canonical_url: events.article_url
      filters:
        user_facts.session_count_tier: "-Below 1"
      sorts: [user_facts.session_count_tier]
      limit: '500'
      column_limit: '50'
      query_timezone: America/New_York
      value_labels: legend
      label_type: labPer
      stacking: ''
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      limit_displayed_rows: false
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      series_types:
        __FILE: parsely/article_summary.dashboard.lookml
        __LINE_NUM: 258
      colors: 'palette: Mixed Dark'
      series_colors:
        Deep Read (at least 30 seconds): "#2a85a9"
        Read (at least 10 seconds): "#388f5b"
        __FILE: parsely/article_summary.dashboard.lookml
        __LINE_NUM: 261
        Read (at least 10 to 30 seconds): "#33a02c"
      series_labels:
        '1': One Time unique_visitors
        '2': Return unique_visitors
        __FILE: parsely/article_summary.dashboard.lookml
        __LINE_NUM: 263
        3 or Above: Frequent unique_visitors
      inner_radius: 30
