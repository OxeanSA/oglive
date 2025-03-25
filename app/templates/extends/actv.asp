{% for actv in active_s %}
        <div class='actv-cnt-inl'>
        <div class='actv-container'>

         <div class="avatar">
            {% if actv['profile'] == 'df' %}
             <img src='assets/default.jpg'>
          {% else %}
             <img src="http://{{ _ipaddr }}:8000/image?uuid={{ actv['id'] }}&ppic={{ actv['profile'] }}&ptp=profile">
          {% endif %}
          </div>
         {% set uname = actv['firstname'] %}
         <div class="actv-uname">{{ _trim(uname, 7) }}</div>
       </div>
       </div>
{% endfor %}
