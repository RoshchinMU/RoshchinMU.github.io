---
layout: article
title: Московский клуб программистов
excerpt: Тяжела и неказиста жизнь простого программиста
---

Как выяснилось, в Москве есть большая потребность в неформальных встречах программистов,
без привязки к конкретным технологиям и языкам.

Ниша «посидеть и поговорить» оказалась незаполненной.
Этот пробел требует немедленной ликвидации, которой мы и занимаемся.

<!-- {% for post in site.posts %}
  <h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
  {{ post.excerpt }}
{% endfor %} -->

{% for staff_member in site.staff_members %}
  <h2>
    <a href="{{ staff_member.url }}">
      {{ staff_member.name }} - {{ staff_member.position }}
    </a>
  </h2>
  <p>{{ staff_member.content | markdownify }}</p>
{% endfor %}