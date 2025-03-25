{% for mqry in data %}
   {% set username = mqry['firstname'] + ' ' + mqry['lastname'] %}
   <div class="message-user-container" id="messages">
      {{ mqry['profile'] }}
      <div onclick="iurl('chatview', {uuid: this.getAttribute('data-uuid') })" data-uuid="{{ mqry['sender_id'] }}" class="message-inner">
         <div class="avatar">
            {% if mqry['profile'] == 'df' %}
               <img src='assets/default.jpg'>
            {% else %}
               <img onload="onImgLoad(this, this.getAttribute('data-src'))" src='assets/imgthumb.gif' onclick="iurl('vprofile', {uuid: this.getAttribute('data-uuid') })" data-uuid="{{ mqry['sender_id'] }}" data-src="http://{{ _ipaddr }}:8000/image?uuid={{ mqry['user_id'] }}&ppic={{ mqry['profile'] }}&ptp=profile">
            {% endif %}
         </div>
         <div class="message-content">
            <div onclick="iurl('chatview', {uuid: this.getAttribute('data-uuid') })" data-uuid="{{ mqry['sender_id'] }}" class="message-username">{{ username | replace(" ", " ") }}{% if mqry['ctype'] != 'ucf' %} <i class="fa fa-check-circle"></i>{% endif %}</div>
            <div class="message-text-message"><i class="message-ics-right active fa fa-check"></i> {{ mqry['message'] | truncate(40, true, '...') }}</div>
         </div>
      </div>
      {% if mqry['profile'] == False %}
      <div onclick="iurl('chatview', {uuid: this.getAttribute('data-uuid') })" data-uuid="0" class="message-inner">
         <div class="avatar">
            <img src='assets/default.jpg'>
         </div>
         <div class="message-content">
            <div onclick="iurl('chatview', {uuid: this.getAttribute('data-uuid') })" data-uuid="0" class="message-username">Welcome user <i class="fa fa-check-circle"></i></div>
            <div class="message-text-message"><i class="message-ics-right active fa fa-check"></i> Welcome to Oxean Gallery where the youth thrive</div>
         </div>
      </div>
      {% endif %}
   </div>
   

{% endfor %}