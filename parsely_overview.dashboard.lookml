- dashboard: overview
  title: Parse.ly Overview
  layout: grid
  rows:
    - elements: [total_page_views, visitor_count, session_count, avg_engaged_tm]
      height: 200

    - elements: [visitor_metrics]
      height: 100

    - elements: [device_pie, os_pie, country_pie, content_pie]
      height: 300

    - elements: [daily_unique_visitors_and_page_views, visitor_funnel, top_content_frequent]
      height: 400

    - elements: [referrer_metrics]
      height: 100

    - elements: [referrers, referrers_engaged_time]
      height: 400

    - elements: [post_overview]
      height: 100

    - elements: [engaged_time_chart, top_articles]
      height: 400

    - elements: [word_count_metrics, most_engaging_posts]
      height: 400

    - elements: [geo_breakdown]
      height: 100

    - elements: [location_map, zip_map]
      height: 400

    - elements: [device_breakdown]
      height: 100

    - elements: [top_posts_device, read_categories_device]
      height: 400

  filters:

  - name: date
    type: date_filter
#     default_value: 30 Days

  - name: publish_date
    type: date_filter
#     default_value: 30 Days

  elements:

    - name: total_page_views
      title: Total Page Views
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
        publish_date: page_facts.publish_date

    - name: visitor_count
      title: Distinct Visitor Count
      type: single_value
      model: parsely
      explore: events
      measures: [events.unique_visitors]
      sorts: [events.unique_visitors desc]
      limit: 500
      font_size: medium
      text_color: black
      listen:
        date: events.ts_action_date
        publish_date: page_facts.publish_date


    - name: session_count
      title: Session Count
      type: single_value
      model: parsely
      explore: events
      measures: [events.session_count]
      sorts: [events.session_count desc]
      limit: 500
      font_size: medium
      text_color: black
      listen:
        date: events.ts_action_date
        publish_date: page_facts.publish_date

    - name: avg_engaged_tm
      title: Average Engaged Time
      type: single_value
      model: parsely
      explore: events
      measures: [page_engagement_facts.average_engaged_time_per_visitor]
      sorts: [events.session_id, page_engagement_facts.average_engaged_time_per_visitor desc]
      limit: 500
      font_size: medium
      text_color: black
      listen:
        date: events.ts_action_date
        publish_date: page_facts.publish_date

    - name: daily_unique_visitors_and_page_views
      title: Daily unique_visitors and Page Views
      type: looker_line
      model: parsely
      explore: events
      dimensions: [events.ts_action_date]
      measures: [events.unique_visitors, events.page_views]
      filters:
      events.ts_action_date: ''
      page_facts.publish_date: ''
      sorts: [events.ts_action_date desc]
      limit: '500'
      column_limit: '50'
      query_timezone: America/New_York
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
      colors: ["#388f5b", "#2a85a9"]
      legend_position: center
      limit_displayed_rows: false
      y_axis_scale_mode: linear
      reference_lines: [{reference_type: line, line_value: mean, range_start: max, range_end: min,
          margin_top: deviation, margin_value: mean, margin_bottom: deviation, label_position: right,
          color: "#161618", label: 'Average visitors: {{mean}}', __FILE: slate/overview.dashboard.lookml,
          __LINE_NUM: 149, value_format: "###,##"}]
      y_axes: [{label: '', maxValue: !!null '', minValue: !!null '', orientation: left,
          showLabels: true, showValues: true, tickDensity: default, tickDensityCustom: 5,
          type: linear, unpinAxis: false, valueFormat: !!null '', series: [{id: events.unique_visitors,
              name: Unique Visitors}]}, {label: !!null '', maxValue: !!null '', minValue: !!null '',
          orientation: right, showLabels: true, showValues: true, tickDensity: default,
          tickDensityCustom: 5, type: linear, unpinAxis: false, valueFormat: !!null '',
          series: [{id: events.page_views, name: Page Views}]}]
      listen:
        date: events.ts_action_date
        publish_date: page_facts.publish_date

    - name: visitor_funnel
      title: Visitor Funnel
      type: looker_column
      model: parsely
      explore: events
      measures: [events.unique_visitors, user_facts.return_count, user_facts.frequent_count]
      sorts: [user_facts.count desc]
      limit: '500'
      listen:
        date: events.ts_action_date
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
      totals_color: '#808080'
      show_dropoff: true
      colors: ['#5245ed', '#1ea8df', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
      series_colors: {}
      series_labels:
        events.unique_visitors: Total unique_visitors


    - name: location_map
      title: Page Views by Location
      type: looker_map
      model: parsely
      explore: events
      dimensions: [events.visitor_geo_country]
      measures: [events.page_views]
      filters:
        events.page_views: '>25'
        events.visitor_geo_country: "-NULL"
      listen:
        date: events.ts_action_date
        publish_date: page_facts.publish_date
      sorts: [events.page_views desc]
      limit: 500
      map_plot_mode: points
      map_tile_provider: positron
      map_position: fit_data
      map_scale_indicator: 'off'
      map_pannable: true
      map_zoomable: true
      map_marker_type: circle
      map_marker_radius_mode: proportional_value
      map_marker_units: meters
      map_marker_proportional_scale_type: linear
      map_marker_color_mode: fixed
      show_view_names: false
      quantize_map_value_colors: false

    - name: zip_map
      title: US Page Views by Zip
      type: looker_geo_coordinates
      model: parsely
      explore: events
      dimensions: [events.visitor_postal]
      measures: [events.page_views]
      sorts: [events.page_views desc]
      limit: 500
      map: usa
      show_view_names: true
      listen:
        date: events.ts_action_date
        publish_date: page_facts.publish_date

    - name: device_pie
      title: Device Type Breakdown by unique_visitors
      type: looker_pie
      model: parsely
      explore: events
      dimensions: [events.visitor_device]
      measures: [events.unique_visitors]
      sorts: [events.visitor_device]
      limit: 50
      column_limit: 50
      value_labels: legend
      colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
        '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
      show_view_names: true
      listen:
        date: events.ts_action_date
        publish_date: page_facts.publish_date

    - name: os_pie
      title: OS Breakdown by unique_visitors
      type: looker_pie
      model: parsely
      explore: events
      dimensions: [events.visitor_os]
      measures: [events.unique_visitors]
      sorts: [events.unique_visitors desc]
      limit: 500
      column_limit: 50
      value_labels: legend
      colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
        '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
      show_view_names: true
      listen:
        date: events.ts_action_date
        publish_date: page_facts.publish_date

    - name: country_pie
      title: Country Breakdown by unique_visitors
      type: looker_pie
      model: parsely
      explore: events
      dimensions: [events.visitor_geo_country]
      measures: [events.unique_visitors]
      sorts: [events.unique_visitors desc]
      limit: 50
      column_limit: 50
      value_labels: legend
      colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
        '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
      show_view_names: false
      listen:
        date: events.ts_action_date
        publish_date: page_facts.publish_date

    - name: content_pie
      title: Content Breakdown by unique_visitors
      type: looker_pie
      model: parsely
      explore: events
      dimensions: [events.article_section]
      measures: [events.unique_visitors]
      filters:
        events.article_section: -NULL,-EMPTY
      sorts: [events.article_section desc]
      limit: 50
      column_limit: 50
      value_labels: legend
      colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
        '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
      show_view_names: false
      listen:
        date: events.ts_action_date
        publish_date: page_facts.publish_date

    - name: referrers
      title: Top Referrers by Page Views
      type: looker_bar
      model: parsely
      explore: events
      dimensions: [events.sref_domain]
      measures: [events.unique_visitors, events.page_views]
      listen:
        date: events.ts_action_date
        publish_date: page_facts.publish_date
      filters:
        events.sref_domain: "-EMPTY"
      sorts: [events.unique_visitors desc]
      limit: '20'
      column_limit: '50'
      query_timezone: America/New_York
      stacking: ''
      colors: ["#5245ed", "#ed6168", "#1ea8df", "#353b49", "#49cec1", "#b3a0dd", "#db7f2a",
        "#706080", "#a2dcf3", "#776fdf", "#e9b404", "#635189"]
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      limit_displayed_rows: false
      y_axis_combined: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      show_null_labels: false
      y_axis_tick_density_custom: 5
      ordering: none
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"

    - name: referrers_engaged_time
      title: Top Referrers by Engaged Time (> 1000 unique_visitors)
      type: looker_bar
      model: parsely
      explore: events
      dimensions: [events.sref_domain]
      measures: [events.unique_visitors, page_engagement_facts.average_engaged_time_per_visitor]
      listen:
        date: events.ts_action_date
        publish_date: page_facts.publish_date
      filters:
        events.sref_domain: "-EMPTY"
        events.unique_visitors: ">1000"
      sorts: [page_engagement_facts.average_engaged_time_per_visitor desc]
      limit: '20'
      column_limit: '50'
      query_timezone: America/New_York
      stacking: ''
      colors: ["#5245ed", "#ed6168", "#1ea8df", "#353b49", "#49cec1", "#b3a0dd", "#db7f2a",
        "#706080", "#a2dcf3", "#776fdf", "#e9b404", "#635189"]
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
      limit_displayed_rows: false
      y_axis_combined: false
      show_y_axis_labels: false
      show_y_axis_ticks: false
      y_axis_tick_density: default
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      y_axis_scale_mode: linear
      show_null_labels: false
      y_axis_tick_density_custom: 5
      ordering: none
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      series_colors:
        page_engagement_facts.average_engaged_time_per_visitorr: "#b2df8a"


    - name: top_articles
      title: Top 50 Articles
      type: table
      model: parsely
      explore: events
      dimensions: [events.article_title]
      measures: [events.unique_visitors, events.page_views, page_engagement_facts.average_engaged_time_per_visitor]
      sorts: [events.unique_visitors desc]
      limit: 50
      column_limit: 50
      show_view_names: false
      show_row_numbers: true
      truncate_column_names: false
      table_theme: gray
      limit_displayed_rows: false
      listen:
        date: events.ts_action_date
        publish_date: page_facts.publish_date

    - name: top_content_frequent
      title: Top Content for Frequent unique_visitors
      type: looker_bar
      model: parsely
      explore: events
      dimensions: [events.article_section]
      measures: [events.page_views, events.unique_visitors]
      filters:
        events.article_section: "-EMPTY"
        user_facts.session_count_tier: 3 or Above
      listen:
        date: events.ts_action_date
        publish_date: page_facts.publish_date
      sorts: [events.page_views desc]
      limit: '10'
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
      y_axis_combined: true
      show_y_axis_labels: false
      show_y_axis_ticks: false
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
      colors: ['palette: Santa Cruz']
      series_colors: {}

    - name: visitor_metrics
      type: text
      title_text: Visitor Metrics

    - name: referrer_metrics
      type: text
      title_text: Referrer Metrics

    - name: post_overview
      type: text
      title_text: Post Overview

    - name: geo_breakdown
      type: text
      title_text: Geo Breakdown

    - name: device_breakdown
      type: text
      title_text: Device Breakdown

    - name: engaged_time_chart
      title: Engaged Time and Page Views by Hours since Posting
      type: looker_line
      model: parsely
      explore: events
      dimensions: [events.hours_since_publish_date]
      measures: [events.total_engaged_time, events.page_views]
      filters:
        events.hours_since_publish_date: "[0, 72]"
      listen:
        date: events.ts_action_date
        publish_date: page_facts.publish_date
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
      y_axis_orientation: [left, right]
      series_types:
        events.page_views: area
        events.total_engaged_time: column
      colors: ["#5245ed", "#1ea8df", "#353b49", "#49cec1", "#b3a0dd", "#db7f2a", "#706080",
        "#a2dcf3", "#776fdf", "#e9b404", "#635189"]
      series_colors: {}

    - name: word_count_metrics
      title: Word Count Metrics
      type: looker_column
      model: parsely
      explore: events
      dimensions: [events.article_word_count_tier]
      measures: [events.average_page_views_per_post, page_engagement_facts.average_engaged_time_per_visitor,
        events.post_count]
      filters:
        events.article_word_count_tier: "-Undefined"
      listen:
        date: events.ts_action_date
        publish_date: page_facts.publish_date
      sorts: [events.article_word_count_tier]
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
      ordering: none
      show_null_labels: false
      show_totals_labels: false
      show_silhouette: false
      totals_color: "#808080"
      custom_color_enabled: false
      custom_color: forestgreen
      show_single_value_title: true
      show_comparison: false
      comparison_type: value
      comparison_reverse_colors: false
      show_comparison_label: true
      show_null_points: true
      point_style: none
      interpolation: linear
      y_axis_orientation: [left, right]
      series_types: {}
      colors: ["#5245ed", "#1ea8df", "#353b49", "#49cec1", "#b3a0dd", "#db7f2a", "#706080",
        "#a2dcf3", "#776fdf", "#e9b404", "#635189"]
      series_colors: {}
      listen:
        date: events.ts_action_date
        publish_date: page_facts.publish_date

    - name: most_engaging_posts
      title: Most Engaging Posts (>500 PV's)
      type: table
      model: parsely
      explore: events
      dimensions: [events.article_title]
      measures: [events.page_views, events.unique_visitors, events.total_engaged_time, page_engagement_facts.average_engaged_time_per_visitor]
      listen:
        date: events.ts_action_date
        publish_date: page_facts.publish_date
      filters:
        events.page_views: ">500"
      sorts: [page_engagement_facts.average_engaged_time_per_visitor desc]
      limit: '16'
      column_limit: '50'
      query_timezone: America/New_York
      show_view_names: false
      show_row_numbers: true
      truncate_column_names: false
      hide_totals: false
      hide_row_totals: false
      table_theme: gray
      limit_displayed_rows: false
      enable_conditional_formatting: false
      conditional_formatting_ignored_fields: []
      conditional_formatting_include_totals: false
      conditional_formatting_include_nulls: false

    - name: top_posts_device
      title: Top Posts with Device Breakout
      type: looker_bar
      model: parsely
      explore: events
      dimensions: [events.article_title]
      measures: [events.page_views, events.page_views_desktop, events.page_views_mobile,
        events.page_views_tablet, events.page_views_other]
      listen:
        date: events.ts_action_date
        publish_date: page_facts.publish_date
      sorts: [events.page_views desc]
      limit: '15'
      column_limit: '50'
      query_timezone: America/New_York
      stacking: normal
      show_value_labels: false
      label_density: 25
      legend_position: center
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
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
      hidden_series: []
      series_types: {}
      colors: ['palette: Santa Cruz']
      series_colors: {}
      hidden_fields: [events.page_views]
      series_labels:
        events.page_views_desktop: Desktop
        events.page_views_mobile: Mobile
        events.page_views_tablet: Tablet
        events.page_views_other: Other

    - name: read_categories_device
      title: Read Categories by Device Type
      type: looker_donut_multiples
      model: parsely
      explore: events
      dimensions: [page_engagement_facts.read_category, events.visitor_device_type]
      pivots: [page_engagement_facts.read_category]
      measures: [page_engagement_facts.count]
      filters:
        page_engagement_facts.read_category: "-NULL"
        events.visitor_device_type: "-other"
      listen:
        date: events.ts_action_date
        publish_date: page_facts.publish_date
      sorts: [page_engagement_facts.count desc 0, page_engagement_facts.read_category__sort_,
        page_engagement_facts.read_category__sort_, page_engagement_facts.read_category,
        page_engagement_facts.read_category__sort_]
      limit: '500'
      column_limit: '50'
      query_timezone: America/New_York
      show_value_labels: true
      font_size: 12
      stacking: ''
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
      colors: 'palette: Santa Cruz'
      series_colors: {}
