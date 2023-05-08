view: last_year_sales {
  derived_table: {
    sql: SELECT
          products.sku  AS products_sku,
          CASE
      WHEN users.age  < 0 THEN '0'
      WHEN users.age  >= 0 AND users.age  < 10 THEN '1'
      WHEN users.age  >= 10 AND users.age  < 20 THEN '2'
      WHEN users.age  >= 20 AND users.age  < 30 THEN '3'
      WHEN users.age  >= 30 AND users.age  < 40 THEN '4'
      WHEN users.age  >= 40 AND users.age  < 50 THEN '5'
      WHEN users.age  >= 50 AND users.age  < 60 THEN '6'
      WHEN users.age  >= 60 AND users.age  < 70 THEN '7'
      WHEN users.age  >= 70 THEN '8'
      ELSE '9'
      END AS users_age_tier__sort_,
          CASE
      WHEN users.age  < 0 THEN 'Below 0'
      WHEN users.age  >= 0 AND users.age  < 10 THEN '0 to 9'
      WHEN users.age  >= 10 AND users.age  < 20 THEN '10 to 19'
      WHEN users.age  >= 20 AND users.age  < 30 THEN '20 to 29'
      WHEN users.age  >= 30 AND users.age  < 40 THEN '30 to 39'
      WHEN users.age  >= 40 AND users.age  < 50 THEN '40 to 49'
      WHEN users.age  >= 50 AND users.age  < 60 THEN '50 to 59'
      WHEN users.age  >= 60 AND users.age  < 70 THEN '60 to 69'
      WHEN users.age  >= 70 THEN '70 or Above'
      ELSE 'Undefined'
      END AS users_age_tier,
          users.city  AS users_city,
          users.traffic_source  AS users_traffic_source,
          LOWER(SUBSTR(users.gender,1,1))  AS users_gender_short,
          COUNT(DISTINCT order_items.order_id ) AS order_items_order_count,
          COALESCE(SUM(order_items.sale_price ), 0) AS order_items_total_sale_price
      FROM looker-private-demo.ecomm.order_items  AS order_items
      FULL OUTER JOIN looker-private-demo.ecomm.inventory_items  AS inventory_items ON inventory_items.id = order_items.inventory_item_id
      LEFT JOIN looker-private-demo.ecomm.users  AS users ON order_items.user_id = users.id
      LEFT JOIN looker-private-demo.ecomm.products  AS products ON products.id = inventory_items.product_id
      GROUP BY
          1,
          2,
          3,
          4,
          5,
          6
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }
  dimension: pk
{
  primary_key: yes
  sql: ${products_sku}+${users_city}+${users_age_tier}+${users_traffic_source} ;;
}

  dimension: products_sku {
    hidden: yes
    type: string
    sql: ${TABLE}.products_sku ;;
  }

  dimension: users_age_tier__sort_ {
    hidden: yes
    type: string
    sql: ${TABLE}.users_age_tier__sort_ ;;
  }

  dimension: users_age_tier {
    hidden: yes
    type: string
    sql: ${TABLE}.users_age_tier ;;
  }

  dimension: users_city {
    hidden: yes
    type: string
    sql: ${TABLE}.users_city ;;
  }

  dimension: users_traffic_source {
    hidden: yes
    type: string
    sql: ${TABLE}.users_traffic_source ;;
  }

  dimension: users_gender_short {
    hidden: yes
    type: string
    sql: ${TABLE}.users_gender_short ;;
  }

  dimension: order_items_order_count {
    # hidden: yes
    type: number
    sql: ${TABLE}.order_items_order_count ;;
  }

  dimension: order_items_total_sale_price {
    # hidden: yes
    type: number
    sql: ${TABLE}.order_items_total_sale_price ;;
  }

  measure: growth_rate {
    type: sum
    value_format_name: percent_0
    sql: ${order_items_total_sale_price}+${last_year_sales.order_items_total_sale_price} ;;
  }

  set: detail {
    fields: [
      products_sku,
      users_age_tier__sort_,
      users_age_tier,
      users_city,
      users_traffic_source,
      users_gender_short,
      order_items_order_count,
      order_items_total_sale_price
    ]
  }
}
