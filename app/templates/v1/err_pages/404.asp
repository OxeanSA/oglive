{% extends "et/etc/int/err_pages/base.asp" %}
{% block content %}

    <div class="jumbotron">
      <h1>Page Not Found</h1>
      <p>Sorry, what you were looking for is not here.</p>
      <hr>
      <a href="{{url_for('main')}}">Go to login page</a>
    </div>
{% endblock %}
