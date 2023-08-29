- dashboard: sisu_users
  title: Sisu users
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: skhKcuVx74zrp4Ihg8gi65
  elements:
  - title: Sisu users
    name: Sisu users
    model: thelook_bq
    explore: order_items
    type: marketplace_sisu_insights_2::sisu-insights
    fields: [users.age, users.count]
    sorts: [users.count desc 0]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    hidden_fields: []
    hidden_points_if_no: []
    show_view_names: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    defaults_version: 0
    note_state: collapsed
    note_display: below
    note_text: This is a note above
    listen: {}
    row: 0
    col: 0
    width: 24
    height: 9
