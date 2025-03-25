<div class="recommended-content">
   <div class="section-title">Suggested</div>
   {% for f in rquery %}
   {% set username = f['firstname'] + ' ' + f['lastname'] %}
   <div class="friends-container">
      <div class="friends-ics-right">Follow</div>
      <div class="friends-ics-right">Remove</div>

      <div class="friends-inner">
         <div class="friends-media">

            {% if f['profile'] == 'df' %}
               <img class="friends-user-avatar" src="assets/default.jpg">
            {% else %}
               <img class="friends-user-avatar" src="http://{{ _ipaddr }}:8000/image?uuid={{ f['id'] }}&ppic={{ f['profile'] }}&ptp=profile">
            {% endif %}
         </div>
         <div class="friends-content">
            <div class="friends-username">{{ _trim(username, 11) }}</div>
            <span class="friends-bottom-count"><i class="fa fa-users"></i> {{ _rand(3, "digits") }}   <i class="fa fa-thumbs-o-up"></i> {{ _rand(2, "digits") }}</span>
         </div>
      </div>
   </div>
   {% endfor %}
   <div>More</div>
   <div class='br-line'></div>

   {% for fs in fquery %}
   {% set username = fs['firstname'] + ' ' + fs['lastname'] %}
   <div class="friends-container">
      <div class="friends-ics-right">Follow</div>

      <div class="friends-inner">
         <div class="friends-media">
            {% if fs['profile'] == 'df' %}
               <img class="friends-user-avatar" src="assets/default.jpg">
            {% else %}
               <img class="friends-user-avatar" src="http://{{ _ipaddr }}:8000/image?uuid={{ fs['id'] }}&ppic={{ fs['profile'] }}&ptp=profile">
            {% endif %}
         </div>
         <div class="friends-content">
            <div class="friends-username">{{ _trim(username, 12) }}</div>
            <span class="friends-bottom-count"><i class="fa fa-users"></i> {{ _rand(3, "digits") }}   <i class="fa fa-thumbs-o-up"></i> {{ _rand(2, "digits") }}</span>
         </div>
      </div>
   </div>
   {% endfor %}
</div>
