  {% set profile = data.profile_ul %}
  {% set _username = data.firstname + ' ' + data.lastname %}

<div class="view-profile-container">
  <div class="profile-view-header-top">
    <div class="bar-btn-gl onclick-blue" onclick="BackTo('home', 'useCache')">
      <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" height="28" viewBox="0 -960 960 960" width="29">
        <path d="M560-240 320-480l240-240 56 56-184 184 184 184-56 56Z"/>
      </svg>
    </div>
  </div>
    <div class="profile-view-card">
      {% if profile == 'df' %}
        <div class="profile-view-header" style="background: url('assets/imgthumb.gif') center;">
      {% else %}
        <div class="profile-view-header" style="background: url('assets/imgthumb.gif') center;">
      <!--  <div class="profile-view-header" style="background: url('http://{{ _ipaddr }}:8000/image?uuid={{ uuid }}&ppic={{ profile }}&ptp=profile') center;"> -->
      {% endif %}

      <div class="profile-view-main">
        {% if profile == 'df' %}
          <img class="profile-view-image" src="assets/default.jpg">
        {% else %}
          <img class="profile-view-image" src="http://{{ _ipaddr }}:8000/image?uuid={{ uuid }}&ppic={{ profile }}&ptp=profile">
        {% endif %}

        <div class="profile-view-details">
          <div class="row">
            <div class="info">
              <span>{{ helpers._random_str(3, "digits") }}</span>
              <h3 onclick="">Likes</h3>
            </div>
            <i class="divider"></i>
            <div class="info">
              <span>{{ helpers._random_str(3, "digits") }}</span>
              <h3 onclick="">Followers</h3>
            </div>
            <i class="divider"></i>
            <div class="info">
              <span>{{ helpers._random_str(3, "digits") }}</span>
              <h3 onclick="">Posts</h3>
            </div>
          </div>
          <div class="profile-view-right-ics">
            <div class="profile-view-follow-button">Follow</div>
            <div class="icn profile-view-right-ge onclick-blue"><i class="fa fa-media"></i></div>
          </div>
          <div class="profile-view-username">{{ _username | replace(" ", " ") }}</div>
          <div class="profile-view-user-username">{{ data.username }}</div>
          <div class="profile-view-user-bio"><i>User bio test 07 jan 2025</i></div>
          
          <div class="profile-view-bottom-ics">
            <div onclick="iurl('vchat', {uuid: this.getAttribute('data-uuid') })" data-uuid="{{ uuid }}" class="icn profile-view-bottom-ge fa fa-message onclick-blue"></div>
            <div class="icn profile-view-bottom-ge fa fa-phone onclick-blue"></div>
          </div>
        </div>
        
        <div class="ics-home-inline mb-6 mt-8">
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

       <dic class="hr"></div>
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
          <img src="assets/df2.jpg">
          <img src="assets/df5.jpg">
          <img src="assets/df2.jpg">
          <img src="assets/df3.jpg">
        </div>
      </div>
      </div>
      
    </div>
</div>

