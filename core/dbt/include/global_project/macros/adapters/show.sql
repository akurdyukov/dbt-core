{% macro show(limit) -%}
  {%- set sql_header = config.get('sql_header', none) -%}
  {{ sql_header if sql_header is not none }}
  {%- if limit is not none -%}
  {{ get_limit_subquery_sql(compiled_code, limit) }}
  {%- else -%}
  {{ compiled_code }}
  {%- endif -%}
{% endmacro %}

{% macro get_limit_subquery_sql(sql, limit) %}
  {{ adapter.dispatch('get_limit_subquery_sql', 'dbt')(sql, limit) }}
{% endmacro %}

{% macro default__get_limit_subquery_sql(sql, limit) %}
    select *
    from (
        {{ sql }}
    ) as model_limit_subq
    limit {{ limit }}
{% endmacro %}