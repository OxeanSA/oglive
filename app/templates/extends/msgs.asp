{% for mqry in mquery %}
   {% set username = mqry['firstname'] + ' ' + mqry['lastname'] %}
   <div class="message-user-container" id="messages">
      <div onclick="iurl('vchat', {uuid: this.getAttribute('data-uuid') })" data-uuid="{{ mqry['sender_id'] }}" class="message-inner">
         <div class="avatar">
            {% if mqry['profile'] == 'df' %}
               <img src='assets/default.jpg'>
            {% else %}
               <img onclick="iurl('vprofile', {uuid: this.getAttribute('data-uuid') })" data-uuid="{{ mqry['sender_id'] }}" src="http://{{ _ipaddr }}:8000/image?uuid={{ mqry['id'] }}&ppic={{ mqry['profile'] }}&ptp=profile">
            {% endif %}
         </div>
         <div class="message-content">
            <div onclick="iurl('vchat', {uuid: this.getAttribute('data-uuid') })" data-uuid="{{ mqry['sender_id'] }}" class="message-username">{{ username | replace(" ", " ") }}{% if mqry['ctype'] != 'ucf' %} <i class="fa fa-check-circle"></i>{% endif %}</div>
            <div class="message-text-message"><i class="message-ics-right active fa fa-check-double"></i> {{ mqry['message'] | truncate(40, true, '...') }}</div>
         </div>
      </div>
   </div>
{% endfor %}