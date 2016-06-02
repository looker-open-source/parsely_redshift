- dashboard: overview
  title: Parse.ly Overview
  layout: grid
  rows:
    - elements: [total_pageviews, visitor_count, session_count, avg_engaged_tm]
      height: 200
    
    - elements: [device_pie, os_pie, country_pie, content_pie]
      height: 300
      
    - elements: [daily_visitors_and_pageviews]
      height: 400
    
    - elements: [referrers, top_articles]
      height: 400
      
    - elements: [location_map, zip_map]
      height: 400
  

  filters:
  
  - name: date
    type: date_filter
#     default_value: 30 Days
  
  - name: publish_date
    type: date_filter
#     default_value: 30 Days

  elements:
  
  - name: total_pageviews
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
      publish_date: events.meta_publish_date
  
  - name: visitor_count
    title: Distinct Visitor Count
    type: single_value
    model: parsely_redshift
    explore: events
    measures: [events.visitors]
    sorts: [events.visitors desc]
    limit: 500
    font_size: medium
    text_color: black
    listen: 
      date: events.action_date
      publish_date: events.meta_publish_date
      
  
  - name: session_count
    title: Session Count
    type: single_value
    model: parsely_redshift
    explore: events
    measures: [events.session_count]
    sorts: [events.session_count desc]
    limit: 500
    font_size: medium
    text_color: black
    listen: 
      date: events.action_date
      publish_date: events.meta_publish_date
  
  - name: avg_engaged_tm
    title: Average Engaged Time
    type: single_value
    model: parsely_redshift
    explore: events
    measures: [events.average_engaged_time_per_visitor]
    sorts: [events.session_id, events.average_engaged_time_per_visitor desc]
    limit: 500
    font_size: medium
    text_color: black
    listen: 
      date: events.action_date
      publish_date: events.meta_publish_date
  
  - name: daily_visitors_and_pageviews
    title: Daily Visitors and Pageviews
    type: looker_line
    model: parsely_redshift
    explore: events
    dimensions: [events.action_date]
    measures: [events.visitors, events.pageviews]
    listen:
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
    colors: ['#388f5b','#2a85a9']
  
  - name: location_map
    title: Pageviews by Location
    type: looker_map
    model: parsely_redshift
    explore: events
    dimensions: [events.ip_location]
    measures: [events.pageviews]
    filters:
      events.pageviews: '>25'
    listen: 
      date: events.action_date
      publish_date: events.meta_publish_date
    sorts: [events.pageviews desc]
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
    title: US Pageviews by Zip
    type: looker_geo_coordinates
    model: parsely_redshift
    explore: events
    dimensions: [events.ip_zipcode]
    measures: [events.pageviews]
    sorts: [events.pageviews desc]
    limit: 500
    map: usa
    show_view_names: true
    listen: 
      date: events.action_date
      publish_date: events.meta_publish_date
  
  - name: device_pie
    title: Device Type Breakdown by Visitors
    type: looker_pie
    model: parsely_redshift
    explore: events
    dimensions: [events.user_agent_devicetype]
    measures: [events.visitors]
    sorts: [events.user_agent_devicetype]
    limit: 500
    column_limit: 50
    value_labels: legend
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_view_names: true
    listen: 
      date: events.action_date
      publish_date: events.meta_publish_date
  
  - name: os_pie
    title: OS Breakdown by Visitors
    type: looker_pie
    model: parsely_redshift
    explore: events
    dimensions: [events.user_agent_os]
    measures: [events.visitors]
    sorts: [events.visitors desc]
    limit: 500
    column_limit: 50
    value_labels: legend
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_view_names: true
    listen: 
      date: events.action_date
      publish_date: events.meta_publish_date
  
  - name: country_pie
    title: Country Breakdown by Visitors
    type: looker_pie
    model: parsely_redshift
    explore: events
    dimensions: [events.ip_country]
    measures: [events.visitors]
    sorts: [events.visitors desc]
    limit: 50
    column_limit: 50
    value_labels: legend
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_view_names: false
    listen: 
      date: events.action_date
      publish_date: events.meta_publish_date
  
  - name: content_pie
    title: Content Breakdown by Visitors
    type: looker_pie
    model: parsely_redshift
    explore: events
    dimensions: [events.meta_section]
    measures: [events.visitors]
    filters:
      events.meta_section: -NULL,-EMPTY
    sorts: [events.meta_section desc]
    limit: 50
    column_limit: 50
    value_labels: legend
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_view_names: false
    listen: 
      date: events.action_date
      publish_date: events.meta_publish_date
  
  - name: referrers
    title: Top 20 Referrers
    type: looker_bar
    model: parsely_redshift
    explore: events
    dimensions: [events.referrer_clean]
    measures: [events.visitors, events.pageviews]
    filters:
      events.referrer_clean: -EMPTY
    sorts: [events.visitors desc]
    limit: 20
    column_limit: 50
    stacking: ''
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
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
    listen: 
      date: events.action_date
      publish_date: events.meta_publish_date
  
  - name: top_articles
    title: Top 50 Articles
    type: table
    model: parsely_redshift
    explore: events
    dimensions: [events.meta_title]
    measures: [events.visitors, events.pageviews, events.average_engaged_time_per_visitor]
    sorts: [events.visitors desc]
    limit: 50
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    table_theme: gray
    limit_displayed_rows: false
    listen: 
      date: events.action_date
      publish_date: events.meta_publish_date









      