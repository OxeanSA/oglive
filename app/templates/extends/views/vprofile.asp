{% set profile = conn.execute("SELECT profile FROM users WHERE id=='{}'".format(uuid)).fetchone()['profile'] %}
{% set prfl = conn.execute("SELECT firstname, lastname FROM users WHERE id=='{}'".format(uuid)).fetchone() %}
{% set _username = prfl['firstname'] + ' ' + prfl['lastname'] %}
<div class="profile-view-header-top">
  <div class="bar-btn-gl onclick-blue" onclick="BackTo('home', 'useCache')">
    <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" height="28" viewBox="0 -960 960 960" width="29">
      <path d="M560-240 320-480l240-240 56 56-184 184 184 184-56 56Z"/>
    </svg>
  </div>
  <div class="bar-btn-gl-text">{{ _username | replace(" ", " ") }}</div>
  <div class="bar-btn-gf onclick-blue"><i class="fas fa-comment"></i></div>
</div>
<div class="view-profile-container">
    <div class="profile-view-card">
      {% if profile == 'df' %}
        <div class="profile-view-header" style="background: url('assets/imgthumb.gif') center;">
      {% else %}
        <div class="profile-view-header" style="background: url('http://{{ _ipaddr }}:8000/image?uuid={{ uuid }}&ppic={{ profile }}&ptp=profile') center;">
      {% endif %}

      <div class="profile-view-main">
        {% if profile == 'df' %}
          <img class="profile-view-image" src="assets/default.jpg">
        {% else %}
          <img class="profile-view-image" src="http://{{ _ipaddr }}:8000/image?uuid={{ uuid }}&ppic={{ profile }}&ptp=profile">
        {% endif %}

        <div class="profile-view-details">
          <div class="profile-view-right-ics">
            <div class="icn profile-view-right-ge fa fa-phone onclick-blue"></div>
            <div class="icn profile-view-right-ge fa fa-cloud onclick-blue"></div>
            <div class="icn profile-view-right-ge fa fa-message onclick-blue"></div>
          </div>
            <div class="profile-view-username">{{ _username | replace(" ", " ") }}</div>
            <div class="profile-view-user-rating">{{ _rand(3, "digits") }} <span class="profile-view-rating-text">likes</span>   <span class='dot-big'>•</span>  {{ _rand(2, "digits") }}  <span class="profile-view-rating-text">followers</span> </div>
        </div>
        <div class="profile-view-follow-button"><i class="fa fa-add onclick-blue"></i> Follow</div>
      </div>
    </div>
</div>