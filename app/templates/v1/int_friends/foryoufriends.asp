<div class="recommended-content">
   {% for f in data %}
   {% set username = f['firstname'] + ' ' + f['lastname'] %}
   <div class="friends-container">
      <div class="friends-ics-right">Follow</div>
      <div class="friends-ics-right" onclick="iurl('vchat', {uuid: this.getAttribute('data-uuid') })" data-uuid="{{ f['user_id'] }}"><i class="fa fa-comment-alt"></i></div>

      <div class="friends-inner">
         <div class="friends-media" onclick="iurl('vprofile', {uuid: this.getAttribute('data-uuid') })" data-uuid="{{ f['user_id'] }}">
            <img class="friends-user-avatar" src="assets/default.jpg">
         </div>
         <div class="friends-content">
            <div class="friends-username">{{ helpers._trim(username, 15) }}</div>
            <span class="friends-bottom-count">{{ f["username"] }}</span>
         </div>
      </div>
   </div>
   {% endfor %}

   <div class="section-title">For you</div>
   {% for fs in data %}
   {% set username = fs['firstname'] + ' ' + fs['lastname'] %}
   <div class="friends-container">
      <div class="friends-ics-right">Follow</div>
      <div class="friends-ics-right" onclick="iurl('vchat', {uuid: this.getAttribute('data-uuid') })" data-uuid="{{ fs['user_id'] }}"><i class="fa fa-comment-alt"></i></div>

      <div class="friends-inner">
         <div class="friends-media" onclick="iurl('vprofile', {uuid: this.getAttribute('data-uuid') })" data-uuid="{{ fs['user_id'] }}">
            <img class="friends-user-avatar" src="assets/default.jpg">
         </div>
         <div class="friends-content">
            <div class="friends-username">{{ helpers._trim(username, 15) }}</div>
            <span class="friends-bottom-count">{{ fs["username"] }}</span>
         </div>
      </div>
   </div>
   {% endfor %}
</div>
