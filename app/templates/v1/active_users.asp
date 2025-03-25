{% for actv in data %}
        <div class='actv-cnt-inl'>
        <div class='actv-container'>

         <div class="avatar" onclick="iurl('chatview', {uuid: this.getAttribute('data-uuid') })" data-uuid="{{ actv['user_id'] }}">
            {% if actv['profile'] == 'df' %}
             <img src='assets/default.jpg'>
          {% else %}
             <img onload="onImgLoad(this, this.getAttribute('data-src'))" src='assets/imgthumb.gif' data-src="http://{{ _ipaddr }}:8000/image?uuid={{ actv['user_id'] }}&ppic={{ actv['profile'] }}&ptp=profile">
          {% endif %}
          </div>
         {% set uname = actv['firstname'] %}
         <div class="actv-uname">{{ helpers._trim(uname, 7) }}</div>
       </div>
       </div>
{% endfor %}
