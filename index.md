---
    layout: "main"
---
На данном сайте я собрал свои наработки в виде справочника, что бы иметь информацию которую я использую в удобном виде.

{% for post in site.posts %}
   <a href="{{ post.url }}">{{ post.title }}</a> 
{% endfor %}

```sql
CREATE TABLE nameDB.nameTABLE
(
    col_name string not null
)

select * from taBLE
```