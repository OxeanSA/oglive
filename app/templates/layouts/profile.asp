{% set user = data %}
{% set profile = user.profile_ul %}
{% set _username = user.firstname + ' ' + user.lastname %}
<div class="profile-pg">
  <div class="side-buttons-list">
    <div class="accounts-switch-button">{{ user['username'] }} &triangledown;</div>
  </div>
  
  <div class="detail">
    <div class="p-cnt">
    {% if profile == 'df' %}
      <img class="u-profile" src="assets/default.jpg">
    {% else %}
      <img class="u-profile" src="http://{{ _ipaddr }}:8000/image?uuid={{ data['user_id'] }}&ppic={{ profile }}&ptp=profile">
    {% endif %}
    </div>
    <div class="uname-cnt">
      <div class='m-uname'>{{ _username }}</div>
    </div>
    <div class="row">
      <div class="info">
        <span>{{ helpers._random_str(3, "digits") }}</span>
        <h3>Likes</h3>
      </div>
      <i class="divider"></i>
      <div class="info">
        <span>{{ helpers._random_str(3, "digits") }}</span>
        <h3 onclick="changeTheme()">Followers</h3>
      </div>
      <i class="divider"></i>
      <div class="info">
        <span>{{ helpers._random_str(3, "digits") }}</span>
        <h3 onclick="LogOut(true)">Posts</h3>
      </div>
    </div>
  </div>
  <div class="ics-home-inline mb-6">
    <div class="ai-search-cnt">
      <div class="ai-search-icr active"></div>
      <span>All ({{ helpers._random_str(2, "digits") }})</span>
    </div>
    
    <div class="ai-search-cnt">
      <div class="ai-search-icr"></div>
      <span>Photos ({{ helpers._random_str(1, "digits") }})</span>
    </div>
    <div class="ai-search-cnt">
       <div class="ai-search-icr"></div>
       <span>Videos ({{ helpers._random_str(1, "digits") }})</span>
     </div>
 </div>
  <div class="profile-inner-content clear">
    <div class="column">
      <img src="assets/df5.jpg">
      <img src="assets/df3.jpg">
      <img src="assets/df2.jpg">
      <img src="assets/df5.jpg">
    </div>
    <div class="column">
      <img src="assets/df2.jpg">
      <img src="assets/df5.jpg">
      <img src="assets/df2.jpg">
      <img src="assets/df3.jpg">
    </div>
    <div class="column">
      <img src="assets/df4.jpg">
      <img src="assets/df2.jpg">
      <img src="assets/df2.jpg">
      <img src="assets/df.jpg">
    </div>
  </div>
</div>
